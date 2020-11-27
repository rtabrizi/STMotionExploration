clear ; close all; clc
% clear anything you might have



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



AscentGyroYPeaks = findpeaks(AscentGyroY,time,'MinPeakDistance',1000)
AscentGyroYMean = (mean(AscentGyroYPeaks))


DescentGyroYPeaks = findpeaks(DescentGyroY,time,'MinPeakDistance',1000)
DescentGyroYMean = (mean(DescentGyroYPeaks))

GyroYMeanVector = [normalGyroYMean, AscentGyroYMean, DescentGyroYMean]

FixedGyroYMean = GyroYMeanVector / max(GyroYMeanVector(:))



