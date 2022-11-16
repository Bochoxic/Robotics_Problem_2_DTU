clear all; clc;
Problem_6;

t = [0; ta; ta^2; ta^3; ta^4; ta^5];

%q = zeros(length(knot_points)-1,4);
position = zeros(length(knot_points)-1,3);
for i = 1: length(knot_points)-1
    q= A(:,:,i)*t;
    position(i,:) = direct_kinematics(q);
end

px = position(:,1);
py = position(:,2);
pz = position(:,3);

plot3(px,py,pz)
plot(px,pz)
