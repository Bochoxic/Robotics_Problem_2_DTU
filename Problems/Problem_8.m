clear all; clc; close all;
% if call = 1 script run from here. if call>1 script is called 
stack=dbstack; call = size(stack,1);

% Select config
config = 2;

% Get results from Problem 3
Problem_3; close all;

% Set-up thetas 
if config == 1
    thetas_P3 = thetas_1_rad;
elseif config == 2
    thetas_P3 = thetas_2_rad;
end

cond_num_P3 = getCondNumPath(thetas_P3);

% Plot P3 trajectory with conditional number
figure
t = tiledlayout(5,2)
nexttile([4 2])
plot3(x,y,z)
grid on
xlim([min(x)-30 max(x)+30])
xlabel("X (mm)")
ylim([min(y)-30 max(y)+30])
ylabel("Y (mm)")
zlim([min(z)-30 max(z)+30])
zlabel("Z(mm)")
title("Condition numbers P3")
legend("Circle trajectory")
L_P6 = strsplit(sprintf('%.1f\n', cond_num_P3(:)), '\n');
text(x, y, z, L_P6(1:length(x)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom','FontSize',5)

nexttile('south')
plot(rad2deg(angle), cond_num_P3, 'b-')
ylim([0 max(cond_num_P3)+30])
xlabel("Circle trajectory (Deg)")
ylabel("Conditional number")
grid on

% Get results from Problem 7
Problem_7;

% Set-up thetas P7
thetas_P7 = [q1, q2, q3, q4];

% Get conditional number along the path from P7
cond_num_P7 = getCondNumPath(thetas_P7);

if string(mfilename) == string(stack(end).name)
    % Plot P7 trajectory with conditional number
    figure
    t = tiledlayout(5,2)
    nexttile([4 2])
    plot3(x_int,y_int,z_int)
    grid on
    xlim([min(x_int)-30 max(x_int)+30])
    xlabel("X (mm)")
    ylim([min(y_int)-30 max(y_int)+30])
    ylabel("Y (mm)")
    zlim([min(z_int)-30 max(z_int)+30])
    zlabel("Z(mm)")
    title("Condition numbers P7")
    legend("Interpolated trajectory")
    L_P7 = strsplit(sprintf('%.1f\n', cond_num_P7(:)), '\n');
    text(x_int, y_int, z_int, L_P7(1:length(x_int)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom','FontSize',5)
    
    nexttile('south')
    plot(rad2deg(angle_circle), cond_num_P7, 'b-')
    ylim([0 max(cond_num_P7)+30])
    xlabel("Circle trajectory (Deg)")
    ylabel("Conditional number")
    grid on
end
