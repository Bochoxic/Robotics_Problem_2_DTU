robot.move_j(0,-5,0,-95)
pause(3)
imshow(snapshot(cam),[])
%% 
name = strcat(int2str(i),'.png');
i=i+1;
imwrite(snapshot(cam),name)
