//
//  main.c
//  DecisionTree
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
#define INTERVAL       5 //time gap between each data value

//------------------------------GLOBAL VARIABLES-----------------------------------------

char *directory = "/Users/arunanelamaran/Desktop/STM_Project/DecisionTree_copy/DecisionTree/";
//change the directory above to the one in which your CSV's are stored.


struct Motion Stand;
struct Motion Normal;
struct Motion Ascent;
struct Motion Descent;
struct Motion New;

int arraylength = TOTAL_TIME/INTERVAL;
int dataps = 1000/INTERVAL; //number of values received on each axis per second


//------------------------------STRUCTS-----------------------------------------

struct Motion
{
    float AX_vals[TOTAL_TIME/INTERVAL];
    double GY_vals[TOTAL_TIME/INTERVAL];
    
    double AX_avg;
    double AX_absavg;
    double AX_peakavg;
    double AX_peakspefavg;
};

//------------------------------FUNCTIONS-----------------------------------
int extract(char* filename, struct Motion *motionptr);
void normalize(struct Motion *motionptr);
void analyze(struct Motion *motionptr);
void findPeaks(char* axis, struct Motion *motionptr);

//------------------------------MAIN METHOD---------------------------------------
int main(int argc, const char * argv[]) {
    
    int success;
    success = //extract("StandStill.csv", &Stand)
            extract("Normal.csv", &Normal)
            *extract("Ascent.csv", &Ascent)
            *extract("Descent.csv", &Descent)
            *extract("New3.csv", &New);
    
    if(!success) { return 1; }
    
    //New 1 = Ascent
    //New 2 = Descent
    //New 3 = Normal
    
    Stand.AX_avg = 1;
    
    //normalize(&Stand);
    normalize(&Normal);
    normalize(&Ascent);
    normalize(&Descent);
    normalize(&New);
    
    //analyze(&Stand);
    analyze(&Normal);
    analyze(&Ascent);
    analyze(&Descent);
    analyze(&New);
    
    
    printf("\nNormal Avg: %f\n", Normal.AX_absavg);
    printf("Ascent Avg: %f\n", Ascent.AX_absavg);
    printf("Descent: %f\n", Descent.AX_absavg);
    printf("New: %f\n\n\n", New.AX_absavg);
    
    
    if (New.AX_peakavg > 1000000) //just check to see if min and max value are not that different
    {
        printf("Stand Still\n");
        return 0;
    }
    
    findPeaks("AX", &Normal);
    findPeaks("AX", &Ascent);
    findPeaks("AX", &Descent);
    findPeaks("AX", &New);

    double mean = (Ascent.AX_peakspefavg+Descent.AX_peakspefavg+Normal.AX_peakspefavg)/3;
    Ascent.AX_peakspefavg /= mean;
    Descent.AX_peakspefavg /= mean;
    Normal.AX_peakspefavg /= mean;
    
    New.AX_peakspefavg /= mean;

    mean = (Ascent.AX_peakspefavg+Descent.AX_peakspefavg+Normal.AX_peakspefavg)/3;
    Ascent.AX_peakspefavg -= mean;
    Descent.AX_peakspefavg -= mean;
    Normal.AX_peakspefavg -= mean;
    
    New.AX_peakspefavg -= mean;
    
    
    //1. percentage error to normal
    //2. which difference is less
    if((fabs(New.AX_absavg-Ascent.AX_absavg) > fabs(New.AX_absavg-Normal.AX_absavg)) &&
            (fabs(New.AX_absavg-Descent.AX_absavg) > fabs(New.AX_absavg-Normal.AX_absavg)))
    { //could also do same thing with GZ
        printf("Normal\n");
    }
    
    else
    {
        
        printf("Ascent: %f\n", Ascent.AX_peakspefavg);
        printf("Descent: %f\n", Descent.AX_peakspefavg);
        printf("Normal: %f\n", Normal.AX_peakspefavg);
        printf("New: %f\n", New.AX_peakspefavg);
        
        if((fabs(New.AX_peakspefavg - Ascent.AX_peakspefavg)) <
           (fabs(New.AX_peakspefavg - Descent.AX_peakspefavg)))
        {
            printf("Ascent\n");
        }
        
        else
        {
            printf("Descent\n");
        }
    }
    
    return 0;
}


//------------------------------FUNCTION INITALIZATION-----------------------------------------

int extract(char* filename, struct Motion *motionptr)
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
                    motionptr->AX_vals[count] = num;
                    break;
                    
                case 2:
                    motionptr->GY_vals[count] = num;
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
    
    for(int r = 0; r < arraylength; r++)
    {
        absum += fabs(motionptr->AX_vals[r]);
    }
    
    double absavg = absum/arraylength;
    
    for(int r = 0; r < arraylength; r++)
    {
        motionptr->AX_vals[r] /= absavg;
        motionptr->AX_vals[r] -= Stand.AX_avg;
    }
}

void analyze(struct Motion *motionptr)
{
    double sum = 0;
    double absum = 0;
    
    for(int r = 0; r < arraylength; r++)
    {
        sum += motionptr->AX_vals[r];
        absum += fabs(motionptr->AX_vals[r]);
    }
    
    motionptr->AX_avg = sum/arraylength;
    motionptr->AX_absavg = absum/arraylength;
}

void findPeaks(char* axis, struct Motion *motionptr)
{
    double *ptr;
    
    if(!strcmp(axis, "AX"))
    {
        ptr = motionptr->AX_vals;
    }
    
    else if(!strcmp(axis, "GY"))
    {
        ptr = motionptr->GY_vals;
    }
    
    else
    {
        printf("INVALID AXIS PROVIDED TO FINDPEAK FUNCTION");
        return;
    }
    
    double temppeakmax = -10000000000000;
    double peaksum = 0;
    
    for(int r = 0; r < arraylength; r++)
    {
        if(ptr[r] > temppeakmax)
        {
            temppeakmax = ptr[r];
        }
        
        if( ((r+1)%dataps) == 0)
        {
            peaksum += temppeakmax;
            temppeakmax = -10000000000;
        }
    }
    
    motionptr->AX_peakspefavg = peaksum/(TOTAL_TIME/1000);
}
