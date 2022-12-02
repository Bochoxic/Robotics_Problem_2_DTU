%% Initialize Robot
robot = initializeRobot()
cam = webcam("C270 HD WEBCAM")
%% Move to first position
first_angle = [0, -40, -40, -80]';
robot.move_j(first_angle(1),first_angle(2),first_angle(3),first_angle(4)) 
first_position = direct_kinematics(first_angle);
pause(5)
img_1 = snapshot(cam);
% movementrobot(robot, [-first_position(1), first_position(2), first_position(3)])
%% Try first picture