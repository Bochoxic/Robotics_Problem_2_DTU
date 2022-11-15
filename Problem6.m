% s
syms A10 A11 A12 A13 A14 A15;
l0= [0;0;0;0;0;0];
l2 = [0;-4;0;0;0;0];
qdot0 = J4_1\l0;
qdot2 = J4_2\l2;
Y= [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 2 0 0 0; 1 2 4 8 16 32; 0 1 4 12 32 80; 0 0 2 12 48 160];
res = [thetas_2_rad(1,1); qdot0(1,1); 0; thetas_2_rad(10,1); qdot2(1,1); 0];
res = Y\res;
A10 = res(1,1);
A11 = res(2,1);
A12 = res(3,1);
A13 = res(4,1);
A14 = res(5,1);
A15 = res(6,1);

syms A20 A21 A22 A23 A24 A25;
res = [thetas_2_rad(1,2); qdot0(2,1); 0; thetas_2_rad(10,2); qdot2(2,1); 0];
res = Y\res;
A20 = res(1,1);
A21 = res(2,1);
A22 = res(3,1);
A23 = res(4,1);
A24 = res(5,1);
A25 = res(6,1);

syms A30 A31 A32 A33 A34 A35;
res = [thetas_2_rad(1,3); qdot0(3,1); 0; thetas_2_rad(10,3); qdot2(3,1); 0];
res = Y\res;
A30 = res(1,1);
A31 = res(2,1);
A32 = res(3,1);
A33 = res(4,1);
A34 = res(5,1);
A35 = res(6,1);

syms A40 A41 A42 A43 A44 A45;
res = [thetas_2_rad(1,4); qdot0(4,1); 0; thetas_2_rad(10,4); qdot2(4,1); 0];
res = Y\res;
A40 = res(1,1);
A41 = res(2,1);
A42 = res(3,1);
A43 = res(4,1);
A44 = res(5,1);
A45 = res(6,1);

A =[A10 A11 A12 A13 A14 A15; A20 A21 A22 A23 A24 A25; A30 A31 A32 A33 A34 A35; A40 A41 A42 A43 A44 A45]

%------B-------------------------------------------------------------------``

l2= [0;-4;0;0;0;0];
l4 = [0;0;-4;0;0;0];
qdot2 = J4_2\l2;
qdot4 = J4_pi\l4;
res = [thetas_2_rad(10,1); qdot2(1,1); 0; thetas_2_rad(19,1); qdot4(1,1); 0];
res = Y\res;
A10 = res(1,1);
A11 = res(2,1);
A12 = res(3,1);
A13 = res(4,1);
A14 = res(5,1);
A15 = res(6,1);

res = [thetas_2_rad(10,2); qdot2(2,1); 0; thetas_2_rad(19,2); qdot4(2,1); 0];
res = Y\res;
A20 = res(1,1);
A21 = res(2,1);
A22 = res(3,1);
A23 = res(4,1);
A24 = res(5,1);
A25 = res(6,1);

res = [thetas_2_rad(19,3); qdot2(3,1); 0; thetas_2_rad(19,3); qdot4(3,1); 0];
res = Y\res;
A30 = res(1,1);
A31 = res(2,1);
A32 = res(3,1);
A33 = res(4,1);
A34 = res(5,1);
A35 = res(6,1);

res = [thetas_2_rad(19,3); qdot2(4,1); 0; thetas_2_rad(19,3); qdot4(4,1); 0];
res = Y\res;
A40 = res(1,1);
A41 = res(2,1);
A42 = res(3,1);
A43 = res(4,1);
A44 = res(5,1);
A45 = res(6,1);

B =[A10 A11 A12 A13 A14 A15; A20 A21 A22 A23 A24 A25; A30 A31 A32 A33 A34 A35; A40 A41 A42 A43 A44 A45]

%-----------____C-------------------------------------------------------------------

l4= [0;0;-4;0;0;0];
l6 = [0;4;0;0;0;0];
qdot4 = J4_pi\l4;
qdot6 = J4_3\l6;
res = [thetas_2_rad(19,1); qdot4(1,1); 0; thetas_2_rad(28,1); qdot6(1,1); 0];
res = Y\res;
A10 = res(1,1);
A11 = res(2,1);
A12 = res(3,1);
A13 = res(4,1);
A14 = res(5,1);
A15 = res(6,1);

res = [thetas_2_rad(19,2); qdot4(2,1); 0; thetas_2_rad(28,2); qdot6(2,1); 0];
res = Y\res;
A20 = res(1,1);
A21 = res(2,1);
A22 = res(3,1);
A23 = res(4,1);
A24 = res(5,1);
A25 = res(6,1);

res = [thetas_2_rad(19,3); qdot4(3,1); 0; thetas_2_rad(28,3); qdot6(3,1); 0];
res = Y\res;
A30 = res(1,1);
A31 = res(2,1);
A32 = res(3,1);
A33 = res(4,1);
A34 = res(5,1);
A35 = res(6,1);

res = [thetas_2_rad(19,4); qdot4(4,1); 0; thetas_2_rad(28,4); qdot6(4,1); 0];
res = Y\res;
A40 = res(1,1);
A41 = res(2,1);
A42 = res(3,1);
A43 = res(4,1);
A44 = res(5,1);
A45 = res(6,1);

C =[A10 A11 A12 A13 A14 A15; A20 A21 A22 A23 A24 A25; A30 A31 A32 A33 A34 A35; A40 A41 A42 A43 A44 A45]

%---------------__D-----------------------------------------------------------

l6= [0;4;0;0;0;0];
l8 = [0;0;0;0;0;0];
qdot6 = J4_3\l6;
qdot8 = J4_1\l8;
res = [thetas_2_rad(28,1); qdot6(1,1); 0; thetas_2_rad(37,1); qdot8(1,1); 0];
res = Y\res;
A10 = res(1,1);
A11 = res(2,1);
A12 = res(3,1);
A13 = res(4,1);
A14 = res(5,1);
A15 = res(6,1);

res = [thetas_2_rad(28,2); qdot6(2,1); 0; thetas_2_rad(37,2); qdot8(2,1); 0];
res = Y\res;
A20 = res(1,1);
A21 = res(2,1);
A22 = res(3,1);
A23 = res(4,1);
A24 = res(5,1);
A25 = res(6,1);

res = [thetas_2_rad(28,3); qdot6(3,1); 0; thetas_2_rad(37,3); qdot8(3,1); 0];
res = Y\res;
A30 = res(1,1);
A31 = res(2,1);
A32 = res(3,1);
A33 = res(4,1);
A34 = res(5,1);
A35 = res(6,1);


res = [thetas_2_rad(28,4); qdot6(4,1); 0; thetas_2_rad(37,4); qdot8(4,1); 0];
res = Y\res;
A40 = res(1,1);
A41 = res(2,1);
A42 = res(3,1);
A43 = res(4,1);
A44 = res(5,1);
A45 = res(6,1);

D =[A10 A11 A12 A13 A14 A15; A20 A21 A22 A23 A24 A25; A30 A31 A32 A33 A34 A35; A40 A41 A42 A43 A44 A45]
