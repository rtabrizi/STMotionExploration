%% Initialization
clear ; close all; clc
% clear anything you might have


fprintf('Program paused. Starting MCS Press enter to continue.\n');
pause;

%makes sure nothing half-loads

fprintf('Plotting Test Data ...\n')

%--------------MASTER 1--------------

data = load('master.csv'); %import dataset
%common time
time = data(:, 19);

%Normal Walk
AX = data(:, 3);
AY = data(:, 6);
AZ = data(:, 9);
GX = data(:, 12);
GY = data(:, 15);
GZ = data(:, 18);


%Ascent
AX2 = data(:, 1);
AY2 = data(:, 4);
AZ2 = data(:, 7);
GX2 = data(:, 10);
GY2 = data(:, 13);
GZ2 = data(:, 16);

%Descent
AX3 = data(:, 2);
AY3 = data(:, 5);
AZ3 = data(:, 8);
GX3 = data(:, 11);
GY3 = data(:, 14);
GZ3 = data(:, 17);

%--------------MASTER 2--------------
data = load('master2.csv');

%common time
second_time = data(:, 19);

%Normal Walk
second_AX = data(:, 3);
second_AY = data(:, 6);
second_AZ = data(:, 9);
second_GX = data(:, 12);
second_GY = data(:, 15);
second_GZ = data(:, 18);


%Ascent
second_AX2 = data(:, 1);
second_AY2 = data(:, 4);
second_AZ2 = data(:, 7);
second_GX2 = data(:, 10);
second_GY2 = data(:, 13);
second_GZ2 = data(:, 16);

%Descent
second_AX3 = data(:, 2);
second_AY3 = data(:, 5);
second_AZ3 = data(:, 8);
second_GX3 = data(:, 11);
second_GY3 = data(:, 14);
second_GZ3 = data(:, 17);

%hold on allows you to graph multiple features on the same graph

%--------------Graph Comparisons--------------

figure 
plot(time, AX); 
title('AccelX-1')

figure
plot(second_time, second_AX); 
title('AccelX-2')





