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

//------------------------------GLOBAL VARIABLES-----------------------------------------

char *directory = "/Users/arunanelamaran/Desktop/STM_Project/DecisionTree/DecisionTree/";

struct Motion Stand;
struct Motion Normal;
struct Motion Ascent;
struct Motion Descent;
struct Motion New;


//------------------------------STRUCTS-----------------------------------------

struct Motion
{
    struct AvgInfo
    {
        double avg;
        double absavg;
        double peakavg;
        double troughavg;
    };

    struct AvgInfo AX;
    struct AvgInfo AY;
    struct AvgInfo AZ;
    struct AvgInfo GX;
    struct AvgInfo GY;
    struct AvgInfo GZ;
};



//------------------------------FUNCTIONS-----------------------------------
//void normalize(char* filename);
int analyze(char* filename, struct Motion *motionptr); //figures out basic avg
int analyzeInfo(char* filename, int place, struct AvgInfo *axisptr, struct AvgInfo still); //figures out peak and trough avg


//------------------------------MAIN METHOD---------------------------------------
int main(int argc, const char * argv[]) {
    
    /*normalize("StandStill.csv");
    normalize("Normal.csv");
    normalize("Ascent.csv");
    normalize("Descent.csv");
    normalize("New.csv");*/
    
    Stand.AX.avg = 1; //take out later
    
    int success;
    success = analyze("StandStill.csv", &Stand)
            *analyze("Normal1.csv", &Normal)
            *analyze("Ascent1.csv", &Ascent)
            *analyze("Descent1.csv", &Descent)
            *analyze("New.csv", &New);
    
    //if(success) { return 0; }
    
    printf("\nNormal Avg: %f\n", Normal.AX.absavg);
    printf("Ascent Avg: %f\n", Ascent.AX.absavg);
    printf("Descent: %f\n", Descent.AX.absavg);
    
    
    if (2==1)
    { //check if stand still
        
    }
    
    else if(//New.AX.absavg == Normal.AX.absavg ||
       (New.AX.absavg < Ascent.AX.absavg && New.AX.absavg < Descent.AX.absavg))
    { //could also do same thing with GZ
        printf("Normal\n");
    }
    
    else
    {
        analyzeInfo("New.csv", 3, &(New.AZ), Stand.AZ);
        analyzeInfo("Ascent1.csv", 3, &(Ascent.AZ), Stand.AZ);
        analyzeInfo("Descent1.csv", 3, &(Descent.AZ), Stand.AZ);
        
        printf("\nAscentPeak: %f\n", Ascent.AZ.peakavg);
        printf("DescentPeak: %f\n", Descent.AZ.peakavg);
        printf("AscentTrough: %f\n", Ascent.AZ.troughavg);
        printf("DescentTrough: %f\n\n", Descent.AZ.troughavg);
        
        if(New.AZ.peakavg > Ascent.AZ.peakavg &&
           New.AZ.troughavg > Ascent.AZ.troughavg)
        {
            printf("Descent\n");
        }
        
        else if(New.AZ.peakavg < Descent.AZ.peakavg &&
                New.AZ.troughavg < Descent.AZ.troughavg)
        {
            printf("Ascent\n");
        }
        
        else
        {
            printf("Unclassifiable motion performed\n");
        }
    }
    
    return 0;
}


//------------------------------FUNCTION INITALIZATION-----------------------------------------

/*void normalize(char* filename)
{
    
}*/

int analyze(char* filename, struct Motion *motionptr)
{
    int count = 0;
    int place = 0;
    
    double AXsum = 0, absAXsum = 0;
    double AYsum = 0, absAYsum = 0;
    double AZsum = 0, absAZsum = 0;
    double GXsum = 0, absGXsum = 0;
    double GYsum = 0, absGYsum = 0;
    double GZsum = 0, absGZsum = 0;
    
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
    
    while(fgets(line, sizeof(line), file))
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
                        num -= Stand.AX.avg;
                    AXsum += num;
                    absAXsum += fabs(num);
                    break;
                    
                case 2:
                    AYsum += num;
                    absAYsum += fabs(num);
                    break;
                
                case 3:
                    AZsum += num;
                    absAZsum += fabs(num);
                    break;
                    
                case 4:
                    GXsum += num;
                    absGXsum += fabs(num);
                    break;
                    
                case 5:
                    GYsum += num;
                    absGYsum += fabs(num);
                    break;
                    
                case 6:
                    GZsum += num;
                    absGZsum += fabs(num);
                    break;
            }
            
            
            token = strtok(NULL, ",");
            place += 1;
        }
        
        count += 1;
        place = 0;
    }
    
    motionptr->AX.avg = AXsum/count;
    motionptr->AY.avg = AYsum/count;
    motionptr->AZ.avg = AZsum/count;
    motionptr->GX.avg = GXsum/count;
    motionptr->GY.avg = GYsum/count;
    motionptr->GZ.avg = GZsum/count;
    
    motionptr->AX.absavg = absAXsum/count;
    motionptr->AY.absavg = absAYsum/count;
    motionptr->AZ.absavg = absAZsum/count;
    motionptr->GX.absavg = absGXsum/count;
    motionptr->GY.absavg = absGYsum/count;
    motionptr->GZ.absavg = absGZsum/count;
    
    return 1;
}

int analyzeInfo(char* filename, int place, struct AvgInfo *axisptr, struct AvgInfo still)
{
    double peaksum = 0;
    int peakcount = 0;
    double troughsum = 0;
    int troughcount = 0;
    
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
    
    while(fgets(line, sizeof(line), file))
    {
        char *token;
        token = strtok(line, ",");
        
        int spot = 0;
        while(token != NULL)
        {
            if (spot == place)
            {
                char *needtoconvert;
                double num = strtod(token, &needtoconvert); //convert token into num
                if(num > axisptr->avg)
                {
                    peaksum += num;
                    peakcount++;
                }
                
                else if(num < axisptr->avg)
                {
                    troughsum += num;
                    troughcount++;
                }
            }
            spot++;
            token = strtok(NULL, ",");
        }
    }
    
    axisptr->peakavg = peaksum/peakcount;
    axisptr->troughavg = troughsum/troughcount;
    
    return 1;
}





/*int avg_AXnormal; //AX averages all absolute value when calcing avg
int avg_AXascent;
int avg_AXdescent;


int avg_AZascent_peaks;
int avg_AZascent_troughs;
int avg_AZdescent_peaks;
int avg_AZdescent_troughs;

int avg_newAX;
int avg_newAZ_peaks;
int avg_newAZ_troughs;

if(avg_newAX == avg_AXnormal ||
   (avg_newAX < avg_AXascent && avg_newAX < avg_AXdescent))
{ //could also do same thing with GZ
    printf("Normal");
}

else
{
    if(avg_newAZ_peaks > avg_AZascent_peaks &&
       avg_newAZ_troughs > avg_AZascent_troughs)
    {
        printf("Descent");
    }
    
    else if(avg_newAZ_peaks < avg_AZdescent_peaks &&
       avg_newAZ_troughs < avg_AZdescent_troughs)
    {
        printf("Ascent");
    }
}*/
