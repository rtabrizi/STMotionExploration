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

%{
figure 
scatter(NormalAccelX, NormalAccelY);
hold on
scatter(AscentAccelX, AscentAccelY);
title('AccelX vs AccelY ');

%}
%{
figure 
scatter(NormalAccelX, AscentAccelX);
%legend('AccelX');
%blue
hold on
scatter(NormalAccelY, AscentAccelY);
%legend('AccelY');
%orange
hold on
scatter(NormalAccelZ, AscentAccelZ);
%legend('AccelZ');
%yellow
title('AccelX, AccelY, AccelZ [X axis == Normal Gait]');



%}

figure
scatter(NormalAccelX, NormalAccelY);
hold on
scatter(AscentAccelX, AscentAccelY);
title('AccelX vs Y; Blue = normal');

figure
scatter(NormalAccelX, NormalAccelZ);
hold on
scatter(AscentAccelX, AscentAccelZ);
title('AccelX vs Z; BLUE = Normal');

figure
scatter(NormalAccelY, NormalAccelZ);
hold on
scatter(AscentAccelY, AscentAccelZ);
title('AccelY vs Z; BLUE = Normal');



%%%%%%%%%%%%%%% GYRO VALUES %%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
figure
scatter(NormalGyroX, NormalGyroY);
hold on
scatter(AscentGyroX, AscentGyroY);
title('GyroX vs Y; Blue = normal');

figure
scatter(NormalGyroX, NormalGyroZ);
hold on
scatter(AscentGyroX, AscentGyroZ);
title('GyroX vs Z; BLUE = Normal');

figure
scatter(NormalGyroY, NormalGyroZ);
hold on
scatter(AscentGyroY, AscentGyroZ);
title('GyroY vs Z; BLUE = Normal');
%}

%%%%%%%%%%%%%%AccelX vs All%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
figure
scatter(NormalAccelX, NormalGyroX);
hold on
scatter(AscentAccelX, AscentGyroX);
title('AccelX vs GyroX; Blue = normal');

figure
scatter(NormalAccelX, NormalGyroY);
hold on
scatter(AscentAccelX, AscentGyroY);
title('AccelX vs GyroY; BLUE = Normal');

figure
scatter(NormalAccelX, NormalGyroZ);
hold on
scatter(AscentAccelX, AscentGyroZ);
title('AccelX vs GyroZ; BLUE = Normal');
%}
%%%%%%%%%%%%%%AccelY vs All%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
figure
scatter(NormalAccelY, NormalGyroX);
hold on
scatter(AscentAccelY, AscentGyroX);
title('AccelY vs GyroX; Blue = normal');

figure
scatter(NormalAccelY, NormalGyroY);
hold on
scatter(AscentAccelY, AscentGyroY);
title('AccelY vs GyroY; BLUE = Normal');

figure
scatter(NormalAccelY, NormalGyroZ);
hold on
scatter(AscentAccelY, AscentGyroZ);
title('AccelY vs GyroZ; BLUE = Normal');
%}
%%%%%%%%%%%%%%AccelZ vs All%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
figure
scatter(NormalAccelZ, NormalGyroX);
hold on
scatter(AscentAccelZ, AscentGyroX);
title('AccelZ vs GyroX; Blue = normal');

figure
scatter(NormalAccelZ, NormalGyroY);
hold on
scatter(AscentAccelZ, AscentGyroY);
title('AccelZ vs GyroY; BLUE = Normal');

figure
scatter(NormalAccelZ, NormalGyroZ);
hold on
scatter(AscentAccelZ, AscentGyroZ);
title('AccelZ vs GyroZ; BLUE = Normal');
%}
%{
scatter(NormalAccelX, NormalAccelZ);
hold on
scatter(AscentAccelX, AscentAccelZ);
hold on
%}


%{
figure
scatter(NormalAccelX, NormalAccelZ, NormalAccelY);
title('test');
%}
%{
figure 
scatter(NormalGyroX, NormalGyroZ);
hold on
scatter(AscentGyroX, AscentGyroZ);
title('GyroZ Ascent vs Normal');
%}
%{
figure;
plot(AscentAccelX(idx==1,1),AscentAccelZ(idx==1,2),'r.','MarkerSize',12)
hold on
plot(NormalA(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off

%}