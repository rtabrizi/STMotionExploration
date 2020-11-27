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

%from walkF.txt, dedicate each column to a variable

%--------------NORMAL WALK
figure 
plot(time, AX);  
title('Norm - AccelX vs Time')

figure 
plot(time, AY); 
title('Norm - AccelY vs Time')

figure 
plot(time, AZ); 
title('Norm - AccelZ vs Time')

figure 
plot(time, GX); 
title('Norm - GyroX vs Time')

figure 
plot(time, GY); 
title('Norm - GyroY vs Time')

figure 
plot(time, GZ); 
title('Norm - GyroZ vs Time')

figure
plot(time, AX);
hold on
plot(time, AY);
hold on
plot(time, AZ);
title('Norm - Accel ALL vs Time')

figure 
plot(time, GX); 
hold on
plot(time, GY); 
hold on
plot(time, GZ); 
title('Norm - Gyro ALL vs Time')

%--------------ASCENT WALK
figure 
plot(time2, AX2);  
title('Ascent - AccelX vs Time')

figure 
plot(time2, AY2); 
title('Ascent - AccelY vs Time')

figure 
plot(time2, AZ2); 
title('Ascent - AccelZ vs Time')

figure 
plot(time2, GX2); 
title('Ascent - GyroX vs Time')

figure 
plot(time2, GY2); 
title('Ascent - GyroY vs Time')

figure 
plot(time2, GZ2); 
title('Ascent - GyroZ vs Time')

figure
plot(time2, AX2);
hold on
plot(time2, AY2);
hold on
plot(time2, AZ2);
title('Ascent - Accel ALL vs Time')

figure 
plot(time2, GX2); 
hold on
plot(time2, GY2); 
hold on
plot(time2, GZ2); 
title('Ascent - Gyro ALL vs Time')

%--------------Descent WALK
figure 
plot(time3, AX3);  
title('Descent - AccelX vs Time')

figure 
plot(time3, AY3); 
title('Descent - AccelY vs Time')

figure 
plot(time3, AZ3); 
title('Descent - AccelZ vs Time')

figure 
plot(time3, GX3); 
title('Descent - GyroX vs Time')

figure 
plot(time2, GY2); 
title('Descent - GyroY vs Time')

figure 
plot(time3, GZ3); 
title('Descent - GyroZ vs Time')

figure
plot(time3, AX3);
hold on
plot(time3, AY3);
hold on
plot(time3, AZ3);
title('Descent - Accel ALL vs Time')

figure 
plot(time3, GX3); 
hold on
plot(time3, GY3); 
hold on
plot(time3, GZ3); 
title('Descent - Gyro ALL vs Time')



%--------------Individual Feature Comparisons

figure 
plot(time, AX); 
hold on
plot(time2, AX2);
hold on
plot(time3, AX3);
title('AccelX vs Time')

figure 
plot(time, AY); 
hold on
plot(time2, AY2);
hold on
plot(time3, AY3);
title('AccelY vs Time')

figure 
plot(time, AZ); 
hold on
plot(time2, AZ2);
hold on
plot(time3, AZ3);
title('AccelZ vs Time')

figure 
plot(time, GX); 
hold on
plot(time2, GX2);
hold on
plot(time3, GX3);
title('GyroX vs Time')

figure 
plot(time, GY); 
hold on
plot(time2, GY2);
hold on
plot(time3, GY3);
title('GyroY vs Time')

figure 
plot(time, GZ); 
hold on
plot(time2, GZ2);
hold on
plot(time3, GZ3);
title('GyroZ vs Time')

%--------------Miscellaneous Feature Comparisons (compare anything to
%anything)


%hold on allows you to graph multiple features on the same graph


