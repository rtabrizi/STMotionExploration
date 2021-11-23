%% Initialization
clear ; close all; clc
% clear anything you might have


fprintf('Program paused. Starting MCS Press enter to continue.\n');
pause;

%makes sure nothing half-loads

fprintf('Plotting Test Data ...\n')
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
plot(time, AX2); 
hold on
lowpass(AX2,0.000000000000000000000000000001,200); %0.00001
title('AX2 (Old vs. lowpassfilter) vs Time')

figure
plot(time, AX3); 
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
