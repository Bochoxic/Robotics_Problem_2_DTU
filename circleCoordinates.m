function [x, y, z] = circleCoordinates(angle)
    n_angles = length(angle);
    p_0 = [150*ones(1,n_angles); zeros(1,n_angles); 120*ones(1,n_angles)]' ...
           +32*[zeros(1,n_angles); cos(angle)'; sin(angle)']';
    x = p_0(:,1);
    y = p_0(:,2);
    z = p_0(:,3);
end