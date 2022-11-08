%% Robot parameters
robotParameters;

%% Problem 3 parameters
angle = linspace(0,2*pi,37)';

[x, y, z] =circleCoordinates(angle);

%% Joint angles calculation from stilus tip coordinates. (last link horizontal)
[thetas_1_deg, thetas_2_deg, thetas_1_rad, thetas_2_rad] = jointAnglesCalculation(x,y,z);