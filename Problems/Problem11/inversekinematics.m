function thetas = inversekinematics(x,y,z)

l1 = 50; l2 = 93; l3 = 93; l4 = 17;

thetaref = -deg2rad(175);

theta1 = atan(y/x);
z3 = z + l4*sin(thetaref);
x3 = x - l4*cos(thetaref)*cos(theta1);
y3 = x3*tan(theta1);

r = sqrt((x3^2)+(y3^2));
s = z3-l1;
theta3 = -acos(((r^2)+(s^2)-(l2^2)-(l3^2))/(2*l2*l3));
theta2 = -(atan2(r,s)-atan2(l2+l3*cos(theta3),l3*sin(theta3)));
theta4 = thetaref-theta2-theta3;

thetas_rad = [theta1, theta2, theta3, theta4];
thetas = rad2deg(thetas_rad);

end