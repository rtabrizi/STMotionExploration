%% Initialization
clear ; close all; clc
% clear anything you might have


fprintf('Program paused. Starting MCS Press enter to continue.\n');
pause;

%makes sure nothing half-loads

fprintf('Plotting Test Data ...\n')

time = data.get_time('master.csv'); %Common Time
[AX,AY,AZ,GX,GY,GZ] = data.get_data("Norm",'master.csv'); %NORMAL WALK
[AX2,AY2,AZ2,GX2,GY2,GZ2] = data.get_data("Ascent",'master.csv'); %ASCENT WALK
[AX3,AY3,AZ3,GX3,GY3,GZ3] = data.get_data("Descent",'master.csv'); %DESCENT WALK


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
plot(time, AX2);  
title('Ascent - AccelX vs Time')

figure 
plot(time, AY2); 
title('Ascent - AccelY vs Time')

figure 
plot(time, AZ2); 
title('Ascent - AccelZ vs Time')

figure 
plot(time, GX2); 
title('Ascent - GyroX vs Time')

figure 
plot(time, GY2); 
title('Ascent - GyroY vs Time')

figure 
plot(time, GZ2); 
title('Ascent - GyroZ vs Time')

figure
plot(time, AX2);
hold on
plot(time, AY2);
hold on
plot(time, AZ2);
title('Ascent - Accel ALL vs Time')

figure 
plot(time, GX2); 
hold on
plot(time, GY2); 
hold on
plot(time, GZ2); 
title('Ascent - Gyro ALL vs Time')

%--------------Descent WALK
figure 
plot(time, AX3);  
title('Descent - AccelX vs Time')

figure 
plot(time, AY3); 
title('Descent - AccelY vs Time')

figure 
plot(time, AZ3); 
title('Descent - AccelZ vs Time')

figure 
plot(time, GX3); 
title('Descent - GyroX vs Time')

figure 
plot(time, GY2); 
title('Descent - GyroY vs Time')

figure 
plot(time, GZ3); 
title('Descent - GyroZ vs Time')

figure
plot(time, AX3);
hold on
plot(time, AY3);
hold on
plot(time, AZ3);
title('Descent - Accel ALL vs Time')

figure 
plot(time, GX3); 
hold on
plot(time, GY3); 
hold on
plot(time, GZ3); 
title('Descent - Gyro ALL vs Time')



%--------------Individual Feature Comparisons

figure 
plot(time, AX); 
hold on
plot(time, AX2);
hold on
plot(time, AX3);
title('AccelX vs Time')

figure 
plot(time, AY); 
hold on
plot(time, AY2);
hold on
plot(time, AY3);
title('AccelY vs Time')

figure 
plot(time, AZ); 
hold on
plot(time, AZ2);
hold on
plot(time, AZ3);
title('AccelZ vs Time')

figure 
plot(time, GX); 
hold on
plot(time, GX2);
hold on
plot(time, GX3);
title('GyroX vs Time')

figure 
plot(time, GY); 
hold on
plot(time, GY2);
hold on
plot(time, GY3);
title('GyroY vs Time')

figure 
plot(time, GZ); 
hold on
plot(time, GZ2);
hold on
plot(time, GZ3);
title('GyroZ vs Time')

%--------------Miscellaneous Feature Comparisons (compare anything to
%anything)


%hold on allows you to graph multiple features on the same graph


