function [T01, T12, T23, T34, T45] = homogeneousTransformationMatrices(theta1, theta2, theta3, theta4)
    % Define some variables
    c1 = cos(theta1); s1 = sin(theta1);
    c2 = cos(theta2); s2 = sin(theta2);
    c3 = cos(theta3); s3 = sin(theta3);
    c4 = cos(theta4); s4 = sin(theta4);
    %% Computes the Ti
    T01 = [c1 0 s1 0;
        s1 0 -c1 0;
        0 1 0 50
        0 0 0 1];
    
    T12 = [c2 -s2 0 93*c2;
        s2 c2 0 93*s2;
        0 0 1 0;
        0 0 0 1];
    
    T23 = [c3 -s3 0 93*c3;
        s3 c3 0 93*s3;
        0 0 1 0;
        0 0 0 1];
    
    T34 = [c4 -s4 0 50*c4;
        s4 c4 0 50*s4;
        0 0 1 0;
        0 0 0 1];
    
    T45 = [1 0 0 -15
        0 1 0 45
        0 0 1 0
        0 0 0 1];
end