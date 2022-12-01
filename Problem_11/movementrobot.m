function movementrobot(robot, position)
    angle = jointAnglesCalculation(position(1), position(2), position(3));
    robot.move_j(angle(4), angle(1), angle(2), angle(3))