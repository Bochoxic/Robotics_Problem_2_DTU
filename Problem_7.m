clear all; clc; close all;
Problem_6;

n_interpolations = 50;  % Number of intermolations made through each segment

n_segments = size(A,3);
x_range = linspace(0,2,n_interpolations);
A = fliplr(A);  % 1st coefficient need to be the independent one for the poly2sym function
figure
t = tiledlayout(2,2);   % Divide the figure in subplots
timer = linspace(0,n_segments*length(x_range),n_segments*length(x_range)+1);

q1 = []; q2 = []; q3 = []; q4 = []; x_int = []; y_int = []; z_int = [];

for i=1:n_segments
    % Convert coefficients to symbolic equations
    q1_sym = poly2sym(-A(1,:,i));
    q2_sym = poly2sym(-A(2,:,i));
    q3_sym = poly2sym(-A(3,:,i));
    q4_sym = poly2sym(-A(4,:,i));
    
    for j=1:length(x_range)
        % Compute interpolated values of each joint for each segment
        q1 = [q1; double(subs(q1_sym,x_range(j)))];
        q2 = [q2; double(subs(q2_sym,x_range(j)))];
        q3 = [q3; double(subs(q3_sym,x_range(j)))];
        q4 = [q4; double(subs(q4_sym,x_range(j)))];
        
        % Compute forward kinematics to obtain position of the end-effector
        T04 = forwardKinematicsEndEffector(q1(end), q2(end), q3(end), q4(end));
        x_int = [x_int; T04(1,end)]; 
        y_int = [y_int; T04(2,end)];
        z_int = [z_int; T04(3,end)];

    end
end

% Plot joint angles for each segment
nexttile(1)
plot(rad2deg(q1),'b');
title("theta 1")
hold on

nexttile(2)
plot(rad2deg(q2),'b');
title("theta 2")
hold on

nexttile(3)
plot(rad2deg(q3),'b');
title("theta 3")
hold on

nexttile(4)
plot(rad2deg(q4),'b');
title("theta 4")
hold on

title(t,"Interpolated joint trajectory")

% Plot interpolated end effector position vs perfect circle
figure
plot3(x,y,z)
hold on
plot3(x_int,y_int, z_int)
legend("Desired trajectory", "Interpolated trajectory")
title("End effector trajectory")
