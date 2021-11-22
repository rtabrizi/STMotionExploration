//
//  main.c
//  FeatureAnalysis
//
//  Created by Arunan Elamaran on 1/25/21.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <math.h>

#define TOTAL_TIME     9000 //amount of time taken for performing a motion
#define INTERVAL       5    //the time gap between each data value

//------------------------------GLOBAL VARIABLES-----------------------------------------

char *directory = "/Users/arunanelamaran/Desktop/STM_Project/FeatureAnalysis/FeatureAnalysis/";
//change the directory above to the one in which your CSV's are stored.

struct Motion Stand;
struct Motion Normal;
struct Motion Ascent;
struct Motion Descent;
struct Motion New;

int arraylength = TOTAL_TIME/INTERVAL;
int dataps = 1000/INTERVAL; //number of values received on each axis per second

float vals[6][TOTAL_TIME/INTERVAL]; //array that stores all values from all 6 axes during the specified time interval

char *axesnames[6] = {"AX", "AY", "AZ", "GX", "GY", "GZ"};

//------------------------------STRUCTS-----------------------------------------

//The struct defined below stores values that can be potential features or can be utilized in equations to find features
struct Motion
{
    struct AxisInfo
    {
        double avg;
        double absavg;
        double peakavg;
        double peakspefavg;
                
        double min;
        double max;
    };
    
    struct AxisInfo axes[7]; //(there are only 6 axes but ignore 0th place - don't want any confusion, so AX is 1)
    
    int AX_standev;
    double vertical_pos;
};

//------------------------------Essential FUNCTIONS-----------------------------------
int general(char* filename, struct Motion *motionptr); //function that performs all the data extraction and potential feature analyzation

int extract(char* filename); //extracts data from CSVs
void normalize(struct Motion *motionptr); //normalizes the extracted data

//------------------------------Analysis FUNCTIONS (performed on each axis) -----------------------------------
void analyzeaverages(struct Motion *motionptr); //analyzes the data for averages
void findPeaks(struct Motion *motionptr); //finds the peaks for each interval for the AX values
void verticalpos(struct Motion *motionptr); //calculates change in vertical position
void verticalpos2(struct Motion *motionptr); //calculates change in vertical position (accounts for noise, etc.)

int rawavg(struct Motion *motionptr); //raw average of values in axis
void stan_devcalc(struct Motion *motionptr); //standard deviaton of values in axis

void findMinMax(struct Motion *motionptr); //finds minimum and maximum values in an axis (WARNING: should filter data to account for noise and should also develop so that it finds the min and max for certain intervals)

void stepnumber(struct Motion *motionptr); //NOT FINISHED - meant to find the number of steps taken by an individual

//------------------------------MAIN METHOD---------------------------------------
int main(int argc, const char * argv[]) {
    
    int success;
    success = //general("StandStill.csv", &Stand)
            general("Normal.csv", &Normal)
            *general("Ascent.csv", &Ascent)
            *general("Descent.csv", &Descent);
            //*general("New2.csv", &New);
    
    //change the file names according to what they are called in the folder
    
    if(!success) { return 1; }
    
    //checks to make sure that entire extraction, analyzation, etc. process was successfully completed
    
    for(int a = 0; a < 4; a++)
    {
        double mean = (Ascent.axes[a].peakspefavg+Descent.axes[a].peakspefavg+Normal.axes[a].peakspefavg)/3;
        Ascent.axes[a].peakspefavg /= mean;
        Descent.axes[a].peakspefavg /= mean;
        Normal.axes[a].peakspefavg /= mean;
        
        New.axes[a].peakspefavg /= mean;

        mean = (Ascent.axes[a].peakspefavg+Descent.axes[a].peakspefavg+Normal.axes[a].peakspefavg)/3;
        Ascent.axes[a].peakspefavg -= mean;
        Descent.axes[a].peakspefavg -= mean;
        Normal.axes[a].peakspefavg -= mean;
        
        New.axes[a].peakspefavg -= mean;
    }
    
    for(int a = 1; a < 7; a++)
    {
        printf("%s\n", axesnames[a-1]);
        
        printf("NORMAL");
        printf("avg: %f\n", Normal.axes[a].avg);
        printf("absavg: %f\n", Normal.axes[a].absavg);
        printf("peakavg: %f\n", Normal.axes[a].peakavg);
        printf("peakspefavg: %f\n\n", Normal.axes[a].peakspefavg);
        
        printf("ASCENT");
        printf("avg: %f\n", Ascent.axes[a].avg);
        printf("absavg: %f\n", Ascent.axes[a].absavg);
        printf("peakavg: %f\n", Ascent.axes[a].peakavg);
        printf("peakspefavg: %f\n\n", Ascent.axes[a].peakspefavg);
        
        printf("DESCENT");
        printf("avg: %f\n", Descent.axes[a].avg);
        printf("absavg: %f\n", Descent.axes[a].absavg);
        printf("peakavg: %f\n", Descent.axes[a].peakavg);
        printf("peakspefavg: %f\n", Descent.axes[a].peakspefavg);
        
        printf("\n\n\n");
        
    }
    
    printf("Normal pos: %d\n", (int)Normal.vertical_pos);
    printf("Ascent pos: %d\n", (int)Ascent.vertical_pos);
    printf("Descent pos: %d\n\n\n", (int)Descent.vertical_pos);
    
    printf("Normal standev: %i\n", Normal.AX_standev);
    printf("Ascent standev: %i\n", Ascent.AX_standev);
    printf("Descent standev: %i\n", Descent.AX_standev);
    
    
    
    return 0;
}


//------------------------------FUNCTION INITALIZATION-----------------------------------------

int general(char* filename, struct Motion *motionptr)
{
    int success = extract(filename);
    
    if(!success)
    {
        return 0;
    }
    
    rawavg(motionptr);
    stan_devcalc(motionptr);
    verticalpos(motionptr);
    analyzeaverages(motionptr);
    
    normalize(motionptr);
    //analyzeaverages(motionptr);
    findPeaks(motionptr);
    findMinMax(motionptr);
    
    return 1;
}

int extract(char* filename)
{
    int count = 0;
    int place = 0;
    
    char full_directory[500];
    strcpy(full_directory, directory);
    strcat(full_directory, filename);
    
    FILE *file = fopen(full_directory, "r");
    
    if(file == NULL)
    {
        printf("Could not open %s. \n",filename);
        return 0;
    }
    
    char line[200];
    
    while((fgets(line, sizeof(line), file)) && (count < arraylength))
    {
        char *token;
        token = strtok(line, ",");
        
        while(token != NULL)
        {
            char *needtoconvert;
            double num = strtod(token, &needtoconvert); //convert token into num
                        
            switch(place)
            {
                case 1:
                    vals[0][count] = num;
                    break;
                    
                case 2:
                    vals[1][count] = num;
                    break;
                
                case 3:
                    vals[2][count] = num;
                    break;
                
                case 4:
                    vals[3][count] = num;
                    break;
                    
                case 5:
                    vals[4][count] = num;
                    break;
                    
                case 6:
                    vals[5][count] = num;
                    break;
            }
            
            
            token = strtok(NULL, ",");
            place += 1;
        }
        
        count += 1;
        place = 0;
    }
    
    return 1;
}

void normalize(struct Motion *motionptr)
{
    double absum = 0;
    
    for(int m = 0; m < 6; m++)
    {
        for(int r = 0; r < arraylength; r++)
        {
            absum += fabs(vals[m][r]);
        }
        
        double absavg = absum/arraylength;
        
        for(int r = 0; r < arraylength; r++)
        {
            vals[m][r] /= absavg;
            
            if(m==0)
            {
                vals[m][r] -= 1; //Stand.AX_avg FIGURE OUT IF FOR ALL OR IF JUST FOR ONE + if right axis
            }
                
        }
    }
}

void analyzeaverages(struct Motion *motionptr)
{
    double sum = 0;
    double absum = 0;
    
    for(int m = 0; m < 6; m++)
    {
        for(int r = 0; r < arraylength; r++)
        {
            sum += vals[m][r];
            absum += fabs(vals[m][r]);
        }
        
        motionptr->axes[m+1].avg = sum/arraylength;
        motionptr->axes[m+1].absavg = absum/arraylength;
    }
}

void findPeaks(struct Motion *motionptr)
{
    double temppeakmax = -10000000000000;
    double peaksum = 0;
    
    for(int a = 0; a < 6; a++)
    {
        peaksum = 0;
        temppeakmax = -10000000000000;
        
        for(int r = 0; r < arraylength; r++)
        {
            if(vals[a][r] > temppeakmax)
            {
                temppeakmax = vals[a][r];
            }
            
            if( ((r+1)%dataps) == 0)
            {
                peaksum += temppeakmax;
                temppeakmax = -10000000000;
            }
        }
        
        motionptr->axes[a+1].peakspefavg = peaksum/(TOTAL_TIME/1000);
    }
}

void findMinMax(struct Motion *motionptr)
{
    double tempmax = -10000000000000;
    double tempmin = 10000000000000;
    
    for(int a = 0; a < 6; a++)
    {
        tempmax = -10000000000000;
        tempmin = 10000000000000;
        
        for(int r = 0; r < arraylength; r++)
        {
            if(vals[a][r] > tempmax)
            {
                tempmax = vals[a][r];
            }
            
            else if(vals[a][r] < tempmin)
            {
                tempmin = vals[a][r];
            }
        }
        
        motionptr->axes[a+1].max = tempmax;
        motionptr->axes[a+1].min = tempmin;
    }
}

void verticalpos(struct Motion *motionptr)
{
    int length = (TOTAL_TIME/INTERVAL) + 1;
    double velocity[length];
    
    velocity[0] = 0;
    
    for(int i = 0; i < arraylength; i++)
    {
        velocity[i+1] = velocity[i] + (0.005 * (vals[0][i]-1000));
    }
    
    double position = 0;
    double prev_position = 0;
    
    for(int i = 0; i < length; i++)
    {
        position = prev_position + (0.005 * velocity[i]);
        prev_position = position;
    }
    
    motionptr->vertical_pos = position;
}

void verticalpos2(struct Motion *motionptr)
{
    int range = abs(930-rawavg(motionptr)); //range of vals from stand avg to the motion avg
    int lastindex = 0;
    
    int length = (TOTAL_TIME/INTERVAL);
    double velocity[length];
    
    velocity[0] = 0;
    
    for(int i = 0; i < arraylength; i++)
    {
        if(range > fabs(vals[0][i] - 930))
        {
            velocity[i+1] = velocity[i] + (0.005 * (vals[0][i]-930));
            lastindex = i;
        }
    }
    printf("avg: %d\n total length: %d\n lastindex: %d\n\n", range + 930, length,lastindex);
    velocity[lastindex+1] = 100000;
    
    double position = 0;
    double prev_position = 0;
    
    for(int i = 0; i < length; i++)
    {
        if(velocity[i] != 100000)
        {
            position = prev_position + (0.005 * velocity[i]);
            prev_position = position;
        }
    }
    
    motionptr->vertical_pos = position;
}


int rawavg(struct Motion *motionptr)
{
    int avg = 0;
    
    for(int i = 0; i < arraylength; i++)
    {
        avg += vals[0][i];
    }
    
    return (avg/arraylength);
}

void stan_devcalc(struct Motion *motionptr)
{
    int error = 0;
    
    for(int i = 0; i < arraylength; i++)
    {
        error += abs(motionptr->axes[1].avg-vals[0][i]);
    }
    
    motionptr->AX_standev = error/arraylength;
}

/*void stepnumber(struct Motion *motionptr)
{
    int above = 0;
    int abovecount = 0;
    int belowcount = 0;
    
    int stepduration = 15/INTERVAL;
    
    for(int i = 0; i < arraylength; i++)
    {
        if(vals[0][i] > (1.25*(motionptr->axes[1].avg)))
        {
            if(
        }
        
        else if(vals[0][i] < (1.25*(motionptr->axes[1].avg)))
        {
            if(
        }
    }
}*/
