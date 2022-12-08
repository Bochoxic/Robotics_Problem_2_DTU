%% Initialize Robot
disp("Initializing robot")
robot = initializeRobot()
cam = webcam("C270 HD WEBCAM")
%% Take pictures
first_picture = [82,0,-78];
second_picture = [82,0,-70];

disp("Taking first picture")
movementrobot(robot, first_picture)
pause(2)
imshow(snapshot(cam),[])

img_1 = snapshot(cam);

disp("Taking second picture")
movementrobot(robot, second_picture)
pause(2)
imshow(snapshot(cam),[])
img_2 = snapshot(cam);


%% Try first picture
% la posición original es la de 78
% y es el tercero y no se cambia el signo -24
% x es el segundo y se cambia al signo y (dividir 10)

runPython
size(smarties_position,1)

disp("Touching smarties")
for i = 1:size(smarties_position,1)
    smarty_position = first_picture + smarties_position(i,:);
    smarty_position(1) = 12;
    movementrobot(robot, smarty_position)
    pause(2)
    movementrobot(robot, first_picture)
    pause(1)
end