clear all; clc; close all;
Problem_6;
close all;

n_interpolations = 100;  % Number of intermolations made through each segment

% Prepare variables for the for loop
n_segments = size(A,3);
x_range = linspace(tin,ta,n_interpolations);
A = fliplr(A);  % 1st coefficient need to be the independent one for the poly2sym function
n_points = n_segments*length(x_range);
timer = linspace(0,n_points,n_points);

q1 = []; q2 = []; q3 = []; q4 = []; x_int = []; y_int = []; z_int = [];

for i=1:n_segments
    % Convert coefficients to symbolic equations
    q1_sym = poly2sym(A(1,:,i));
    q2_sym = poly2sym(A(2,:,i));
    q3_sym = poly2sym(A(3,:,i));
    q4_sym = poly2sym(A(4,:,i));
    
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

% Obtain same number of circle coordinates as the ones interpolated
angle_circle = linspace(0,2*pi,n_points)';
[x_c, y_c, z_c] = circleCoordinates(angle_circle);

interpolated_error = sqrt((x_int-x_c).^2+(y_int-y_c).^2+(z_int-z_c).^2);

% Plot joint angles for each segment
figure
t = tiledlayout(2,2);   % Divide the figure in subplots

nexttile(1)
plot(rad2deg(q1),'b');
title("theta 1")
hold on
grid on

nexttile(2)
plot(rad2deg(q2),'b');
title("theta 2")
hold on
grid on

nexttile(3)
plot(rad2deg(q3),'b');
title("theta 3")
hold on
grid on

nexttile(4)
plot(rad2deg(q4),'b');
title("theta 4")
hold on
grid on

title(t,"Interpolated joint trajectory")

% Plot interpolated end effector position vs perfect circle
figure
t = tiledlayout(5,2)

nexttile([4 2])
plot3(x,y,z)
hold on
plot3(x_int,y_int, z_int)
grid on
xlim([min(x_int)-30 max(x_int)+30])
xlabel("X (mm)")
ylim([min(y_int)-30 max(y_int)+30])
ylabel("Y (mm)")
zlim([min(z_int)-30 max(z_int)+30])
zlabel("Z(mm)")
hl = legend("Desired trajecotry", "Interpolated trajectory")
hl.Layout.Tile = 'east'
title("Interpolated trajectory vs Perfect circle")

nexttile('south')
plot(rad2deg(angle_circle),interpolated_error,'k-')
xlabel("Circle trajectory (Deg)")
ylabel("Error (mm)")
xlim([0 max(rad2deg(angle_circle))])
grid on
title("Interpolated trajectory error")