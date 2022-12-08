%clear all; close all; clc;
py.importlib.import_module('numpy');
% img_1 = imread("img_1.png");
% img_2 = imread("img_2.png");


r_p1 = py.numpy.array(img_1(:,:,1));
g_p1 = py.numpy.array(img_1(:,:,2));
b_p1 = py.numpy.array(img_1(:,:,3));

r_p2 = py.numpy.array(img_2(:,:,1));
g_p2 = py.numpy.array(img_2(:,:,2));
b_p2 = py.numpy.array(img_2(:,:,3));

smarties_coord_final = cell(pyrunfile("smartiesDetector.py","smarties_coord_final", r1 = r_p1, g1 = g_p1, b1 = b_p1, ...
                                                                     r2 = r_p2, g2 = g_p2, b2 = b_p2, ...
                                                                     baseline = 8))
smarties_position = [];

for i = 1:size(smarties_coord_final,2)
    
    smarties_position = [smarties_position; double(smarties_coord_final{1,i})];

end


