clear all; close all; clc;
py.importlib.import_module('numpy');
img_1 = imread("robot_photos/5.jpeg");
img_2 = imread("robot_photos/6.jpeg");


r_p1 = py.numpy.array(img_1(:,:,1));
g_p1 = py.numpy.array(img_1(:,:,2));
b_p1 = py.numpy.array(img_1(:,:,3));

r_p2 = py.numpy.array(img_2(:,:,1));
g_p2 = py.numpy.array(img_2(:,:,2));
b_p2 = py.numpy.array(img_2(:,:,3));
d_mean = double(pyrunfile("smartiesDetector.py","d_mean", r1 = r_p1, g1 = g_p1, b1 = b_p1, ...
                                                                     r2 = r_p2, g2 = g_p2, b2 = b_p2, ...
                                                                     baseline = 10))



