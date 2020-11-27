clear ; close all; clc

fprintf('Plotting Test Data ...\n')
data = load('master.csv'); %import dataset

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
%}


%{




%}

figure 
plot(time, NormalAccelZ); 
hold on
plot(time, AscentAccelZ); 
hold on
plot(time, DescentAccelZ); 
title(['AccelZ' ...
    ' ALL vs Time'])

figure 
plot(time, NormalGyroY); 
hold on
plot(time, AscentGyroY); 
hold on
plot(time, DescentGyroY); 
title(['GyroY' ...
    ' ALL vs Time'])
%figure;
%findpeaks(NormalAccelX,time,'MinPeakDistance',500)
normalAccelXPeaks = findpeaks(NormalAccelX,time,'MinPeakDistance',1000)
normalAccelXMean = (mean(normalAccelXPeaks))
AscentAccelXPeaks = findpeaks(AscentAccelX, time, 'MinPeakDistance', 1000)
AscentMean = (mean(AscentAccelXPeaks))
DescentAccelXPeaks = findpeaks(DescentAccelX, time, 'MinPeakDistance', 1000)
DescentMean = (mean(DescentAccelXPeaks))
AccelXMeanVector = [normalAccelXMean, AscentMean, DescentMean]
FixedAccelXMean = AccelXMeanVector / max(AccelXMeanVector(:))


normalGyroYPeaks = findpeaks(NormalGyroY,time,'MinPeakDistance',1000)
normalGyroYMean = (mean(normalGyroYPeaks))


%hold on 
%findpeaks(AscentAccelX, time, 'MinPeakDistance', 500)

AscentGyroYPeaks = findpeaks(AscentGyroY,time,'MinPeakDistance',1000)
AscentGyroYMean = (mean(AscentGyroYPeaks))
%hold on 
%findpeaks(DescentAccelX, time, 'MinPeakDistance', 500)

DescentGyroYPeaks = findpeaks(DescentGyroY,time,'MinPeakDistance',1000)
DescentGyroYMean = (mean(DescentGyroYPeaks))

GyroYMeanVector = [normalGyroYMean, AscentGyroYMean, DescentGyroYMean]

FixedGyroYMean = GyroYMeanVector / max(GyroYMeanVector(:))
%confusion matrix

%title('findpeaks test');

%{

figure;
plot(time, NormalAccelZ);
title('AccelZ vs Time')


figure;
plot(time, AscentAccelZ);
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





figure;
plot(time, GY);
title('GyroY vs Time')



figure;
plot(time, GY2);
title('GyroY2 vs Time')
 


%}


figure 
plot(time, NormalGyroZ); 
hold on
plot(time, AscentGyroZ); 
hold on
plot(time, DescentGyroZ); 
title(['GyroZ' ...
    ' ALL vs Time'])

%{

figure;
plot(time, NormalGyroZ);
title('GyroZ vs Time')



figure;
plot(time, AscentGyroZ);
title('GyroZ2 vs Time')

%}

%{
%Printing All
figure;

%plot(time, NormalAccelX);
%hold on



%plot(time, AY);
%hold on



%plot(time, NormalAccelZ);
%hold on


% Plot Gyro Data



plot(time, GX);
hold on


plot(time, GY);
hold on


plot(time, NormalGyroZ);
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



%plot(time, NormalAccelZ);
%hold on


% Plot Gyro Data



plot(time, GX2);
hold on




plot(time, GY2);
hold on


plot(time, AscentGyroZ);
hold on
title('All Ascent vs Time')


%hold on allows you to graph multiple things






%}


