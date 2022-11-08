function [thetas, J4, J5, q_dot] = process_velocities(angle, v, w, config)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[x,y,z] = circleCoordinates(angle);

% Obtain joint angles for phi = 2
[~, ~, thetas_1_rad, thetas_2_rad] = jointAnglesCalculation(x,y,z);

if config == 1
    % Compute jacobian for phi = 2
    [J4, J5] = JacobianMatrix(thetas_1_rad(:,1), thetas_1_rad(:,2), thetas_1_rad(:,3), thetas_1_rad(:,4));

    % Inverse velocity calculation: As Jacobian matrix is not squared, the
    % inverse of the jacobian will be computed as: (J'*J)^-1 * J'
    J4_inv = (J4'*J4)^-1 * J4';
    q_dot = J4_inv * [v; w];
    thetas = thetas_1_rad;

elseif config == 2
    [J4, J5] = JacobianMatrix(thetas_2_rad(:,1), thetas_2_rad(:,2), thetas_2_rad(:,3), thetas_2_rad(:,4));

    % Inverse velocity calculation: As Jacobian matrix is not squared, the
    % inverse of the jacobian will be computed as: (J'*J)^-1 * J'
    J4_inv = (J4'*J4)^-1 * J4';
    q_dot = J4_inv * [v; w];
    thetas = thetas_2_rad;

else
    print("Error in configuration number, select 1 or 2")
end

end