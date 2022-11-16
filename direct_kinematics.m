function [position] = direct_kinematics(thetas)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[~, ~, T04, ~] = JacobianMatrix(thetas(1),thetas(2), thetas(3), thetas(4));
A04 = T04*thetas;
position = A04(1:3);
end