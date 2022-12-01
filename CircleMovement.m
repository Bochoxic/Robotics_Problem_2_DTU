angle = linspace(0,2*pi,100)';
[x, y, z] =circleCoordinates(angle);

while true
    for i=1:length(x)
        movementrobot(robot, [x(i), y(i), z(i)]);
    end
end