torque1_pb3 = zeros(37,1);
torque2_pb3 = zeros(37,1);
torque3_pb3 = zeros(37,1);
torque4_pb3 = zeros(37,1);

torque1_pb6 = zeros(length(q1),1);
torque2_pb6 = zeros(length(q1),1);
torque3_pb6 = zeros(length(q1),1);
torque4_pb6 = zeros(length(q1),1);

F = [0; 0; -1; 0; 0; 0];
for k=1:37
    [J_1, J_2, J_3, J_4, J_5] = JacobianMatrixv2(thetas_2_rad(k,1), thetas_2_rad(k,2), thetas_2_rad(k,3), thetas_2_rad(k,4));
    torque1_pb3(k,1) = (J_1')*F;
    torque2_pb3(k,1) = (J_2(:,2))'*F;
    torque3_pb3(k,1) = (J_3(:,3))'*F;
    torque4_pb3(k,1) = (J_4(:,4))'*F;
end

for k=1:length(q1)
    [J_1, J_2, j_3, J_4 J_5] = JacobianMatrixv2(q1(1,k), q2(1,k), q3(1,k), q4(1,k));
    torque1_pb6(k,1) = (J_1')*F;
    torque2_pb6(k,1) = (J_2(:,2))'*F;
    torque3_pb6(k,1) = (J_3(:,3))'*F;
    torque4_pb6(k,1) = (J_4(:,4))'*F;
end

torque_pb3 = [torque1_pb3, torque2_pb3, torque3_pb3, torque4_pb3];
torque_pb6 = [torque1_pb6, torque2_pb6, torque3_pb6, torque4_pb6];

figure(3)
plot(torque_pb3)
figure(4)
plot(torque_pb6)