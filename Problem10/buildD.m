I0 = 16.25;
I1 = [I0, 0, 0; 0, 0.4*I0, 0; 0, 0, 0.9*I0];
I2 = [0.45*I0, 0, 0; 0, 1.4*I0, 0; 0, 0, 1.2*I0];
I3 = [0.45*I0, 0, 0; 0, 1.4*I0, 0; 0, 0, 1.2*I0];
I4 = [0.5*I0, 0, 0; 0, 0.5*I0, 0; 0, 0, 0.5*I0];

I = [I1, I2, I3 I4];

col0 = zeros(6,1);
m = [60; 80; 80; 40];

syms the1 the2 the3 the4

[R1, R2, R3, R4] = computeR(the1, the2, the3, the4);

R= [R1, R2, R3, R4];

[J1_pb10, J2_pb10, J3_pb10, J4_pb10, J5_pb10, Oc1, Oc2, Oc3, Oc4] = JacobianMatrixv4(the1, the2, the3, the4);
J1_pb10 = [J1_pb10, col0, col0, col0]; %Complete the Jacobian with zeros
J2_pb10 = [J2_pb10, col0, col0];
J3_pb10 = [J3_pb10, col0];

Jtot_pb10 = [J1_pb10, J2_pb10, J3_pb10, J4_pb10];
Jtot_pb10(:, 1);
D_pb10 = zeros(4,4);
for k=1:4
    Jg = [Jtot_pb10(:, 4*(k-1)+1), Jtot_pb10(:, 4*(k-1)+2), Jtot_pb10(:, 4*(k-1)+3), Jtot_pb10(:, 4*(k-1)+4)];
    Rtot =  [R(:, 3*(k-1)+1), R(:, 3*(k-1)+2), R(:, 3*(k-1)+3)];
    Itot =  [I(:, 3*(k-1)+1), I(:, 3*(k-1)+2), I(:, 3*(k-1)+3)];
    Jv = [Jg(1, :); Jg(2, :); Jg(3, :)];
    Jw = [Jg(4, :); Jg(5, :); Jg(6, :)];
    D_pb10 = D_pb10 + m(k,1)*(Jv')*Jv+(Jw')*Rtot*Itot*Rtot'*Jw;

end

D_pb10