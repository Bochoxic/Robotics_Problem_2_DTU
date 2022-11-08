clc; clear all;
% Problem 5: Compute the joint velocities q_ at 'phi=2, along the path from Problem 3, so
% that the stylus tip velocity is v04 = [0; 0; 3]mm/s and x_dot 4 = [?; ?; 0].
% Hint: the last quantity x_ 4, you have not seen it as such in the course before, so you need to
% think about how to interpret it in terms of angular velocities.

phi = pi/2;
v04 = [0; -3; 0];
w4 = [0; 0; 0];

% Obtain coordinates for phi = 2
[x,y,z] = circleCoordinates(phi);

% Obtain joint angles for phi = 2
[thetas_1_deg, thetas_2_deg, thetas_1_rad, thetas_2_rad] = jointAnglesCalculation(x,y,z);

% Compute jacobian for phi = 2
[J4_1, J5_1] = JacobianMatrix(thetas_1_rad(:,1), thetas_1_rad(:,2), thetas_1_rad(:,3), thetas_1_rad(:,4));
[J4_2, J5_2] = JacobianMatrix(thetas_2_rad(:,1), thetas_2_rad(:,2), thetas_2_rad(:,3), thetas_2_rad(:,4));

% Inverse velocity calculation: As Jacobian matrix is not squared, the
% inverse of the jacobian will be computed as: (J'*J)^-1 * J'
J4_1_inv = (J4_1'*J4_1)^-1 * J4_1';
J4_2_inv = (J4_2'*J4_2)^-1 * J4_2';

% Joint velocities are calculated as q_dot = J_inv * [v_dot; w_dot]
q_1_dot = J4_1_inv * [v04; w4];
q_2_dot = J4_2_inv * [v04; w4];

fprintf("Joint velocities for phi = pi/2 - Conf1: \n")
fprintf(" q1_dot = %f\n q2_dot = %f\n q3_dot = %f\n q4_dot = %f\n ", ...
    q_1_dot(1), q_1_dot(2), q_1_dot(3), q_1_dot(4));

fprintf("Joint velocities for phi = pi/2 - Conf2: \n")
fprintf(" q1_dot = %f\n q2_dot = %f\n q3_dot = %f\n q4_dot = %f\n ", ...
    q_2_dot(1), q_2_dot(2), q_2_dot(3), q_2_dot(4));
