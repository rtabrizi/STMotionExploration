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


Fpass = 0.37; 
Fstop = 0.43;
Ap = 1;
Ast = 30;

%{
d = designfilt('lowpassfir','PassbandFrequency',Fpass,...
  'StopbandFrequency',Fstop,'PassbandRipple',Ap,'StopbandAttenuation',Ast);
hfvt = fvtool(d);

dk = designfilt('lowpassfir','PassbandFrequency',Fpass,...
  'StopbandFrequency',Fstop,'PassbandRipple',Ap,...
  'StopbandAttenuation',Ast, 'DesignMethod', 'kaiserwin');

addfilter(hfvt,dk);
legend(hfvt,'Equiripple design', 'Kaiser window design')
%}

figure
plot(time, AX); 
hold on
lowpass(AX,0.000000000000000000000000000001,200); %0.00001
title('AX (Old vs. lowpassfilter) vs Time')

figure
plot(time2, AX2); 
hold on
lowpass(AX2,0.000000000000000000000000000001,200); %0.00001
title('AX2 (Old vs. lowpassfilter) vs Time')

figure
plot(time3, AX3); 
hold on
lowpass(AX3,0.000000000000000000000000000001,200); %0.00001
title('AX3 (Old vs. lowpassfilter) vs Time')

%{
figure
plot(time, AX); 
hold on
highpass(AX,50,200);
title('AX (Old vs. highpassfilter) vs Time')

figure
plot(time, AX2); 
hold on
highpass(AX2,50,200);
title('AX2 (Old vs. highpassfilter) vs Time')
%}
