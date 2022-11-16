function [sol] = interpolation_functions(qin, vin, ain, qa, va, aa, tin, ta)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
x = [1 tin tin^2 tin^3 tin^4 tin^5;
    0 1 2*tin 3*tin^2 4*tin^3 5*tin^4;
    0 0 2 6*tin 12*tin^2 20*tin^3;
    1 ta ta^2 ta^3 ta^4 ta^5;
    0 1 2*ta 3*ta^2 4*ta^3 5*ta^4;
    0 0 2 6*ta 12*ta^2 20*ta^3];

y = [qin, vin, ain, qa, va, aa]';

sol = x\y;

end