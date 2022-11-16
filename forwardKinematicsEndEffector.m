function T04 = forwardKinematicsEndEffector(theta1, theta2, theta3, theta4)
    [T01, T12, T23, T34, T45] = homogeneousTransformationMatrices(theta1, theta2, theta3, theta4);
    T04 = T01*T12*T23*T34*T45;
end