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

#define TOTAL_TIME     20000
#define INTERVAL       5

//------------------------------GLOBAL VARIABLES-----------------------------------------

char *directory = "/Users/arunanelamaran/Desktop/STM_Project/DecisionTree_copy/DecisionTree/";

struct Motion Stand;
struct Motion Normal;
struct Motion Ascent;
struct Motion Descent;
struct Motion New;

int arraylength = TOTAL_TIME/INTERVAL;
int dataps = 1000/INTERVAL;


//------------------------------STRUCTS-----------------------------------------

struct Motion
{
    double AX_vals[TOTAL_TIME/INTERVAL];
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
    success = extract("StandStill.csv", &Stand)
            *extract("Normal3.csv", &Normal)
            *extract("Ascent3.csv", &Ascent)
            *extract("Descent3.csv", &Descent)
            *extract("New.csv", &New);
    
    if(success) { return 0; }
    
    normalize(&Stand);
    normalize(&Normal);
    normalize(&Ascent);
    normalize(&Descent);
    normalize(&New);
    
    analyze(&Stand);
    analyze(&Normal);
    analyze(&Ascent);
    analyze(&Descent);
    analyze(&New);
    
    
    if (New.AX_peakavg > 1000000)
    {
        printf("Stand Still\n");
    }
    
    else if(New.AX_absavg == Normal.AX_absavg ||
       (New.AX_absavg < Ascent.AX_absavg && New.AX_absavg < Descent.AX_absavg))
    { //could also do same thing with GZ
        printf("Normal\n");
    }
    
    else
    {
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
                    if(strcmp(filename, "StandStill.csv"))
                        num -= 1; //num -= Stand.AX_avg;
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
