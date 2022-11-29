function[R01, R02, R03, R04] = computeR(theta1, theta2, theta3, theta4)

c1 = cos(theta1); s1 = sin(theta1);
c2 = cos(theta2); s2 = sin(theta2);
c3 = cos(theta3); s3 = sin(theta3);
c4 = cos(theta4); s4 = sin(theta4);
%% Computes the Ti
R01 = [c1 0 s1 ;
    s1 0 -c1 ;
    0 1 0 ];

R12 = [c2 -s2 0 ;
    s2 c2 0 ;
    0 0 1 ];

R23 = [c3 -s3 0 ;
    s3 c3 0;
    0 0 1 ];

R34 = [c4 -s4 0;
    s4 c4 0 ;
    0 0 1 ];

R45 = [1 0 0 
    0 1 0 
    0 0 1];

%% Computes T0i

R02 = R01*R12;
R03 = R02*R23;
R04 = R03*R34;
R05 = R04*R45;
end