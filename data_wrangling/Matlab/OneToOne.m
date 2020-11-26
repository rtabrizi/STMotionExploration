%% Machine Learning Online Class - Exercise 1: Linear Regression

% Instructions
% ------------
%
% This file contains code that helps you get started on the
% linear exercise. You will need to complete the following functions
% in this exericse:
%
% warmUpExercise.m
% plotData.m
% gradientDescent.m
% computeCost.m
% gradientDescentMulti.m
% computeCostMulti.m
% featureNormalize.m
% normalEqn.m
%
% For this exercise, you will not need to change any code in this file,
% or any other files other than those mentioned above.
%
% x refers to the population size in 10,000s
% y refers to the profit in $10,000s
%


%% Initialization
clear ; close all; clc
% clear anything you might have

%% ==================== Part 1: Basic Function ====================
% Complete warmUpExercise.m






fprintf('Program paused. Starting MCS Press enter to continue.\n');
pause;

%makes sure nothing half-loads

fprintf('Plotting Test Data ...\n')
data = load('master3.csv'); %import dataset


AscentAccelX = data(:, 1);
DescentAccelX = data(:, 2);
NormalAccelX = data(:, 3);
AscentAccelY = data(:, 4);
DescentAccelY = data(:, 5);
NormalAccelY = data(:, 6);
AscentAccelZ = data(:, 7);
DescentAccelZ = data(:, 8);
NormalAccelZ = data(:, 9);
AscentGyroX = data(:, 10);
DescentGyroX = data(:, 11);
NormalGyroX = data(:, 12);
AscentGyroY = data(:, 13);
DescentGyroY = data(:, 14);
NormalGyroY = data(:, 15);
AscentGyroZ = data(:, 16);
DescentGyroZ = data(:, 17);
NormalGyroZ = data(:, 18);
time = data(:, 19);
%from walkF.txt, dedicate each column to a variable
figure 
plot(time, NormalAccelX); 
hold on
plot(time, AscentAccelX); 
hold on
plot(time, DescentAccelX); 
title('AccelX ALL vs Time')

DescentAccelXRange = max(DescentAccelX(:)) - min(DescentAccelX(:));
m03 = (DescentAccelX - min(DescentAccelX(:))) / DescentAccelXRange;
mOut3 = 2 * m03 - 1; %descent
AscentAccelXRange = max(AscentAccelX(:)) - min(AscentAccelX(:));
m02 = (AscentAccelX - min(AscentAccelX(:))) / max(DescentAccelX(:));

 %ascent

figure
plot(time, mOut3);
title('Descent AccelZ [-1 to 1]');

figure
plot(time, m02);
hold on
plot(time, mOut3);
title('AccelX [-1 to 1]');



%{
AX2New = highpass(mOut,0.2,200)
figure;
plot(time, AX2New);
title('test2');

figure;
plot(time, mOut);
hold on
plot(time, AX2New);
title('combined');
%}
%{
figure;
plot(time, NormalAccelX); 
title('AccelX vs Time')
 
figure;
plot(time, AscentAccelX); 
title('AccelX2 vs Time')

%}

%{


figure 
plot(time, AY); 
hold on
plot(time, AY2); 
hold on
title(['AccelY' ...
    ' ALL vs Time'])

figure;
plot(time, AY);
title('AccelY vs Time')


figure;
plot(time, AY2);
title('AccelY2 vs Time')

figure 
plot(time, AZ); 
hold on
plot(time, AZ2); 
hold on
plot(time, AZ3); 
title(['AccelZ' ...
    ' ALL vs Time'])

%}

%{

figure;
plot(time, AZ);
title('AccelZ vs Time')


figure;
plot(time, AZ2);
title('AccelZ2 vs Time')
%}


% Plot Gyro Data
%{
figure 
plot(time, GX); 
hold on
plot(time, GX2); 
hold on
title(['GyroX' ...
    ' ALL vs Time'])

figure;
plot(time, GX);
title('GryoX vs Time')


figure;
plot(time, GX2);
title('GryoX2 vs Time')


figure 
plot(time, GY); 
hold on
plot(time, GY2); 
hold on
title(['GyroY' ...
    ' ALL vs Time'])


figure;
plot(time, GY);
title('GyroY vs Time')



figure;
plot(time, GY2);
title('GyroY2 vs Time')
 

figure 
plot(time, GZ); 
hold on
plot(time, GZ2); 
hold on
plot(time, GZ3); 
title(['GyroZ' ...
    ' ALL vs Time'])

%}



%{

figure;
plot(time, GZ);
title('GyroZ vs Time')



figure;
plot(time, GZ2);
title('GyroZ2 vs Time')

%}

%{
%Printing All
figure;

%plot(time, NormalAccelX);
%hold on



%plot(time, AY);
%hold on



%plot(time, AZ);
%hold on


% Plot Gyro Data



plot(time, GX);
hold on


plot(time, GY);
hold on


plot(time, GZ);
hold on
title('All Normal vs Time')

%**************************SECOND HALF***********************

% Plot Gyro Data

%Printing All
figure;

%plot(time, NormalAccelX);
%hold on



%plot(time, AY);
%hold on



%plot(time, AZ);
%hold on


% Plot Gyro Data



plot(time, GX2);
hold on




plot(time, GY2);
hold on


plot(time, GZ2);
hold on
title('All Ascent vs Time')


%hold on allows you to graph multiple things






%}


