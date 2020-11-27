%% Initialization
clear ; close all; clc
% clear anything you might have


fprintf('Program paused. Starting MCS Press enter to continue.\n');
pause;

%makes sure nothing half-loads

fprintf('Plotting Test Data ...\n')
data = load('normalTrim.csv'); %import dataset
data2 = load('ascentTrim.csv'); %import dataset
data3 = load('descentTrim.csv');

%normalTrim
time = data(:, 1);
AX = data(:, 2);
AY = data(:, 3);
AZ = data(:, 4);
GX = data(:, 5);
GY = data(:, 6);
GZ = data(:, 7);

%ascent
time2 = data2(:, 1);
AX2 = data2(:, 2);
AY2 = data2(:, 3);
AZ2 = data2(:, 4);
GX2 = data2(:, 5);
GY2 = data2(:, 6);
GZ2 = data2(:, 7);

%descent
time3 = data3(:, 1);
AX3 = data3(:, 2);
AY3 = data3(:, 3);
AZ3 = data3(:, 4);
GX3 = data3(:, 5);
GY3 = data3(:, 6);
GZ3 = data3(:, 7);


%experiment
%{
figure
D = horzcat(GX,GY,GZ); 
%D = horzcat(GZ,AX,GX); 
%D = horzcat(GZ,GY,GX); 
mesh(D)

figure
E = horzcat(GX2,GY2,GZ2); 
mesh(E)

figure
F = horzcat(GX3,GY3,GZ3); 
mesh(F)
%}
%{
figure
D = horzcat(GX,GY,GZ); 
imagesc(D)

figure
E = horzcat(GX2,GY2,GZ2); 
imagesc(E)

figure
F = horzcat(GX3,GY3,GZ3); 
imagesc(F)
%}

figure
area(time,GX)

figure
area(time2,GX2)

figure
area(time3,GX3)