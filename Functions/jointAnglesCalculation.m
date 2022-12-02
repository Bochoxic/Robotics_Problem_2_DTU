function [thetas_1_deg, thetas_2_deg, thetas_1_rad, thetas_2_rad] = jointAnglesCalculation(x,y,z)
    % Load robot parameters
    robotParameters;

    % Inverse kinematics
    theta_1 = atan2(y,x);
%   x_c = x - a4*cos(theta_1);
%   y_c = y - a4*sin(theta_1);
    x_c = x;
    y_c = y;
    r = sqrt(x_c.^2+y_c.^2);
    s = z - d1;
    c3 = (r.^2 + s.^2 - a2^2 - a3^2)/(2*a2*a3);
    theta_3_1 = atan2((sqrt(1 - c3.^2)),(c3));
    theta_3_2 = atan2((-sqrt(1 - c3.^2)),(c3));
    theta_2_1 = atan2(s,r) - atan2((a3.*sin(theta_3_1)),(a2+a3*cos(theta_3_1)));
    theta_2_2 = atan2(s,r) - atan2((a3.*sin(theta_3_2)),(a2+a3*cos(theta_3_2)));
    theta_4_1 = -(theta_3_1 + theta_2_1);
    theta_4_2 = -(theta_3_2 + theta_2_2);
    thetas_1_rad = [theta_1'; theta_2_1'; theta_3_1'; theta_4_1']';
    thetas_2_rad = [theta_1'; theta_2_2'; theta_3_2'; theta_4_2']';
    thetas_1_deg = rad2deg(thetas_1_rad);
    thetas_2_deg = rad2deg(thetas_2_rad);
end