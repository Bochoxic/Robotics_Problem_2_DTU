function [J4, J5, T04, T05] = JacobianMatrix(theta1,theta2, theta3, theta4)

[T01, T12, T23, T34, T45] = homogeneousTransformationMatrices(theta1, theta2, theta3, theta4);

%% Computes T0i

T02 = T01*T12;
T03 = T02*T23;
T04 = T03*T34;
T05 = T04*T45;

%% Extract Parameters from T0i

z0 = [0 0 1]';
z1 = T01(1:3,3);
z2 = T02(1:3,3);
z3 = T03(1:3,3);
z4 = T04(1:3,3);
z5 = T05(1:3,3);

O0 = [0 0 0]';
O1 = T01(1:3,4);
O2 = T02(1:3,4);
O3 = T03(1:3,4);
O4 = T04(1:3,4);
O5 = T05(1:3,4);

%% Compute J4vi and J4wi for J4

J4v0 = cross(z0,(O4-O0));
J4w0 = z0;
J4v1 = cross(z1,(O4-O1));
J4w1 = z1;
J4v2 = cross(z2,(O4-O2));
J4w2 = z2;
J4v3 = cross(z3,(O4-O3));
J4w3 = z3;

%% Compute J4
J4 = [J4v0 J4v1 J4v2 J4v3; J4w0 J4w1 J4w2 J4w3];

%% Compute J5vi and J5wi for J5

J5v0 = cross(z0,(O5-O0));
J5w0 = z0;
J5v1 = cross(z1,(O5-O1));
J5w1 = z1;
J5v2 = cross(z2,(O5-O2));
J5w2 = z2;
J5v3 = cross(z3,(O5-O3));
J5w3 = z3;

%% Compute J5
J5 = [J5v0 J5v1 J5v2 J5v3; J5w0 J5w1 J5w2 J5w3];
end