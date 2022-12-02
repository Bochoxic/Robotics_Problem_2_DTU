function thetas = movementrobot(robot, position)
    thetas_1_deg = inversekinematics(position(1), position(2), position(3));
    %thetas = robot.inverse(position(1), position(2), position(3),0);
    robot.move_j(thetas_1_deg(1), thetas_1_deg(2), thetas_1_deg(3), (thetas_1_deg(4)))
    thetas = thetas_1_deg;
    % Angle 1 : servo 1 goes -130 to 130
    % Angle 2: servo 2 goes -110 to 0
    % Angle 3: servo 3 goes -100 to 100
    % Angle 4: servo 4 goes -100 to 100