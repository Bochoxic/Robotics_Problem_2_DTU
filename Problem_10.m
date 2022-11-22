%% Define constants
syms q1 q2 q3 q4 m

l1 = 0.050; l2 = 0.093; l3 = 0.093; l4 = 0.050; % Unities in m
cm1 = 0.020; cm2 = 0.030; cm3 = cm2; cm4 = 0.025; % Unities in m
m1 = 0.060; m2 = 0.080; m3 = m2; m4 = 0.040; % Unities in kg
g = 9.810; % Unities in m/s^2

%% Define Potential energy and its differencies
P = g*(m1*(l1-cm1)+m2*(l1+(l2-cm2)*sin(q2))+m3*(l1+l2*sin(q2)+(l3-cm3)*sin(q2+q3))+m4*(l1+l2*sin(q2)+l3*sin(q2+q3)+(l4-cm4)*sin(q2+q3+q4)));
g1 = diff(P,q1);
g2 = diff(P,q2);
g3 = diff(P,q3);
g4 = diff(P,q4);

%% Define Inertial Matrix
b = 40; c = 50;
I0 = m*(b^2+c^2)/12;
D1 = [I0 0 0; 0 0.4*I0 0; 0 0 0.9*I0];
D2 = [0.45*I0 0 0; 0 1.4*I0 0; 0 0 1.2*I0];
D3 = D2;
D4 = [0.5*I0 0 0; 0 0.5*I0 0; 0 0 0.5*I0];

%% Define q dot dot 
q_dot_dot = [0 0 0 0]';

torque_1 = 
