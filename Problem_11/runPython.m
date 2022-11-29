clear all; close all; clc;
py.importlib.import_module('numpy');
img = imread("13.jpeg");

r_p = py.numpy.array(img(:,:,1)');
g_p = py.numpy.array(img(:,:,2)');
b_p = py.numpy.array(img(:,:,3)');

red_smart = double(pyrunfile("test.py","x_red_smarties", r = r_p, g = g_p, b = b_p))



