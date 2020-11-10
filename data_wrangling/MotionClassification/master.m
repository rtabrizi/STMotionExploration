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
data = load('normalTrim.csv'); %import dataset
data2 = load('ascentTrim.csv'); %import dataset


time = data(:, 1);
AX = data(:, 2);
AY = data(:, 3);
AZ = data(:, 4);
GX = data(:, 5);
GY = data(:, 6);
GZ = data(:, 7);
time2 = data2(:, 1);
AX2 = data2(:, 2);
AY2 = data2(:, 3);
AZ2 = data2(:, 4);
GX2 = data2(:, 5);
GY2 = data2(:, 6);
GZ2 = data2(:, 7);
%from walkF.txt, dedicate each column to a variable
figure 
plot(time, AX); 
hold on
plot(time2, AX2); 
hold on
title('AccelX ALL vs Time')

%{
figure;
plot(time, AX); 
title('AccelX vs Time')
 
figure;
plot(time2, AX2); 
title('AccelX2 vs Time')

%}

%{


figure 
plot(time, AY); 
hold on
plot(time2, AY2); 
hold on
title(['AccelY' ...
    ' ALL vs Time'])

figure;
plot(time, AY);
title('AccelY vs Time')


figure;
plot(time2, AY2);
title('AccelY2 vs Time')
%}
figure 
plot(time, AZ); 
hold on
plot(time2, AZ2); 
hold on
title(['AccelZ' ...
    ' ALL vs Time'])
%{

figure;
plot(time, AZ);
title('AccelZ vs Time')


figure;
plot(time2, AZ2);
title('AccelZ2 vs Time')
%}


% Plot Gyro Data
%{
figure 
plot(time, GX); 
hold on
plot(time2, GX2); 
hold on
title(['GyroX' ...
    ' ALL vs Time'])

figure;
plot(time, GX);
title('GryoX vs Time')


figure;
plot(time2, GX2);
title('GryoX2 vs Time')


figure 
plot(time, GY); 
hold on
plot(time2, GY2); 
hold on
title(['GyroY' ...
    ' ALL vs Time'])


figure;
plot(time, GY);
title('GyroY vs Time')



figure;
plot(time2, GY2);
title('GyroY2 vs Time')
 
%}

figure 
plot(time, GZ); 
hold on
plot(time2, GZ2); 
hold on
title(['GyroZ' ...
    ' ALL vs Time'])


%{

figure;
plot(time, GZ);
title('GyroZ vs Time')



figure;
plot(time2, GZ2);
title('GyroZ2 vs Time')

%}

%{
%Printing All
figure;

%plot(time, AX);
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

%plot(time, AX);
%hold on



%plot(time, AY);
%hold on



%plot(time, AZ);
%hold on


% Plot Gyro Data



plot(time2, GX2);
hold on




plot(time2, GY2);
hold on


plot(time2, GZ2);
hold on
title('All Ascent vs Time')


%hold on allows you to graph multiple things






%}


