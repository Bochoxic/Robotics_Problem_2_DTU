function robot = initializeRobot()

robot = MyRobot()
robot.set_speed([0.1,0.1,0.1,0.2], true);
robot.set_torque_limit([1,1,1,1]);
robot.move_j(0,0,0,0)

end