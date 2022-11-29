% if call = 1 script run from here. if call>1 script is called 
stack=dbstack; call = size(stack,1);

%% Robot parameters
robotParameters;

%% Problem 3 parameters
angle = linspace(0,2*pi,37)';

[x, y, z] =circleCoordinates(angle);

%% Joint angles calculation from stilus tip coordinates. (last link horizontal)
[thetas_1_deg, thetas_2_deg, thetas_1_rad, thetas_2_rad] = jointAnglesCalculation(x,y,z);

% Plot only if this script is run
if string(mfilename) == string(stack(end).name)
    figure
    plot3(x,y,z)
    grid on
    title("Problem 3")
end