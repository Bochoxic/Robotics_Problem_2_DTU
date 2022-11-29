clear all; close all; clc;
py.importlib.import_module('numpy')

x_res = 640;
y_res = 480;
frame_middle = [x_res/2,y_res/2];
face_detect_bbox_rectangle = [x_res-2,y_res-2,x_res-2,y_res-2];
face_detect_bbox = reshape(bbox2points(face_detect_bbox_rectangle)', 1, []);

% Create the face detector object.
%faceDetector = vision.CascadeObjectDetector('MinSize',[100,100],'UseROI',true);
faceDetector = vision.CascadeObjectDetector('MinSize',[floor(x_res/6),floor(y_res/6)]);

% Create the webcam object.
webcamlist()
cam = webcam(1);

% Capture one frame to get its size.
videoFrame = snapshot(cam);
frameSize = size(videoFrame);

% Create the video player object.
videoPlayer = vision.VideoPlayer('Position', [200 200 [frameSize(2), frameSize(1)]+30]);

% Init Robot
robot = MyRobot();
assert(robot.is_robot_connected(),"Robot not connected properly");
robot.move_j(40,-90, 0, -70);
cw = 0;
pause(2);

while true
    try
        disp('here')
        img = snapshot(cam);

        r_p = py.numpy.array(img(:,:,1)');
        g_p = py.numpy.array(img(:,:,2)');
        b_p = py.numpy.array(img(:,:,3)');
        
        red_smart = double(pyrunfile("test.py","red_smart", r = r_p, g = g_p, b = b_p))
        
        if ~isempty(red_smart)
            x_smart = red_smart(:,:,1);
            y_smart = red_smart(:,:,2);
        end

        % Display the annotated video frame using the video player object.
        step(videoPlayer, img);
        % Check whether the video player window has been closed.
        runLoop = isOpen(videoPlayer);
        if ~runLoop
            break
        end
    end 
end