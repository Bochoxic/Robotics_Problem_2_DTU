condition_numbers_pb3 = zeros(37, 1);
length(q1)
condition_numbers_pb6 = zeros(length(q1), 1);
for k=1:37
    [J4_ J5_] = JacobianMatrix(thetas_2_rad(k,1), thetas_2_rad(k,2), thetas_2_rad(k,3), thetas_2_rad(k,4));
    condition_numbers_pb3(k,1) = cond(J4_);
end

figure(1)
plot(condition_numbers_pb3)

for k=1:length(q1)
    [J4_ J5_] = JacobianMatrix(q1(1,k), q2(1,k), q3(1,k), q4(1,k));
    condition_numbers_pb6(k,1) = cond(J4_);
end

figure(2)
plot(condition_numbers_pb6)