clear all; clc;
% P3 parameters
knot_points = [0,9,18,27,36];

% Run Problem 3 to get 5 knot-points:
Problem_3;


vA0 = [0; 0; 0];
qddA0 = [0; 0; 0; 0];
vA2 = [0; -25; 0];
qddA2 = qddA0;
vB0 = vA2;
qddB0 = qddA2;
vB2 = [0; 0; -25];
qddB2 = qddB0;
vC0 =vB2;
qddC0 = qddB2;
vC2 = [0; 25; 0];
qddC2 = qddC0;
vD0 = vC2;
qddD0 = qddC2;
vD2 = [0; 0; 0];
qddD2 = qddD0; 