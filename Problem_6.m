clear all; clc;
% P3 parameters
knot_points = [0,9,18,27,36];
n_parameters = 6;
% Run Problem 3 to get 5 knot-points:
Problem_3;
angle = linspace(0,2*pi,37)';
config = 2;

w = [0; 0; 0];
vA0 = [0; 0; 0]; qddA0 = [0; 0; 0; 0]; vA2 = [0; -25; 0]; qddA2 = qddA0;
vB0 = vA2; qddB0 = qddA2; vB2 = [0; 0; -25]; qddB2 = qddB0;
vC0 =vB2; qddC0 = qddB2; vC2 = [0; 25; 0]; qddC2 = qddC0;
vD0 = vC2; qddD0 = qddC2; vD2 = [0; 0; 0]; qddD2 = qddD0; 

v = [vA0' vA2'; vB0' vB2'; vC0' vC2'; vD0' vD2'];
qdd = [qddA0' qddA2'; qddB0' qddB2'; qddC0' qddC2'; qddD0' qddD2'];

tin = 0; ta = 2;
A = zeros([length(qddA0) n_parameters length(knot_points)-1]);
for i = 1: length(knot_points)-1
    [q_0, ~, ~, q_0_dot] = process_velocities(angle(knot_points(i)+1), v(i,1:3)', w, config);
    [q_1, ~, ~, q_1_dot] = process_velocities(angle(knot_points(i+1)+1), v(i,4:6)', w, config);
   
    for k= 1:length(q_0)
        A(k,:,i) = interpolation_functions(q_0(k), q_0_dot(k), qdd(i,k), q_1(k), q_1_dot(k), qdd(i,k+4), tin, ta);
        
    end
end



