clc; clear all;
% if call = 1 script run from here. if call>1 script is called 
stack=dbstack; call = size(stack,1);

Problem_3;

F = [0; 0; -1; 0; 0; 0];
torque = [];

for i=1:length(angle)
    [J4, ~] = JacobianMatrix(thetas_2_rad(i,1), thetas_2_rad(i,2), thetas_2_rad(i,3), thetas_2_rad(i,4));
    torque = [torque; (J4' * F)'];
end

if string(mfilename) == string(stack(end).name)
    figure
    t = tiledlayout(5,2)
    nexttile([3 2])
    plot3(x,y,z)
    grid on
    xlim([min(x)-30 max(x)+30])
    xlabel("X (mm)")
    ylim([min(y)-30 max(y)+30])
    ylabel("Y (mm)")
    zlim([min(z)-30 max(z)+30])
    zlabel("Z(mm)")
    title("Trajectory P3")
    
    
    nexttile('south')
    plot(rad2deg(angle), torque)
    title("Joint torque")
    legend("T1", "t2", "t3", "t4")
    xlabel("Trajectory (Deg)")
    ylabel("Torque (N*mm)")
end