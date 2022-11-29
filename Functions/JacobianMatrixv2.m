function [J1, J2, J3, J4, J5] = JacobianMatrixv2(theta1,theta2, theta3, theta4)
%UNTITLED2 Function that computes de Jacobian Matrix
%   Detailed explanation goes here
%% Define some variables
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
J1 = [J4v0; J4w0];

J2 = [J4v0 J4v1 ; J4w0 J4w1 ];

J3= [J4v0 J4v1 J4v2 ; J4w0 J4w1 J4w2];

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