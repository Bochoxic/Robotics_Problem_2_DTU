function [position] = direct_kinematics(thetas)

[~, ~, T04, ~] = JacobianMatrix(thetas(1),thetas(2), thetas(3), thetas(4));
position = T04(1:3,4);
end