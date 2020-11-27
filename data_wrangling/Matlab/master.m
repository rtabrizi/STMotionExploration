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

%========================================================%

figure 
plot(time, NormalAccelX); 
hold on
plot(time, AscentAccelX); 
hold on
plot(time, DescentAccelX); 
legend('NormalAccelX','AscentAccelX','DescentAccelX')
title('AccelX ALL vs Time')


%{
figure 
plot(time, NormalAccelY); 
hold on
plot(time, AscentAccelY); 
hold on
plot(time, DescentAccelY); 
legend('NormalAccelY','AscentAccelY','DescentAccelY')
title('AccelY ALL vs Time')
%}


figure 
plot(time, NormalAccelZ); 
hold on
plot(time, AscentAccelZ); 
hold on
plot(time, DescentAccelZ); 
legend('NormalAccelZ','AscentAccelZ','DescentAccelZ')
title(['AccelZ' ...
    ' AccelZ ALL vs Time'])


%{
figure 
plot(time, NormalGyroX); 
hold on
plot(time, AscentGyroX); 
hold on
plot(time, DescentGyroX); 
legend('NormalGyroX','AscentGyroX','DescentGyroX')
title('GyroX ALL vs Time')
%}
    
    
figure 
plot(time, NormalGyroY); 
hold on
plot(time, AscentGyroY); 
hold on
plot(time, DescentGyroY); 
legend('NormalGyroY','AscentGyroY','DescentGyroY')
title('GyroY ALL vs Time')


figure 
plot(time, NormalGyroZ); 
hold on
plot(time, AscentGyroZ); 
hold on
plot(time, DescentGyroZ); 
legend('NormalGyroZ','AscentGyroZ','DescentGyroZ')
title('GyroZ ALL vs Time')


