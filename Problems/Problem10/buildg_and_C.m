g = [0;0;-9.81];
P1= m(1,1)*g'*Oc1;
P2= m(2,1)*g'*Oc2;
P3= m(3,1)*g'*Oc3;
P4= m(4,1)*g'*Oc4;

P= P1+P2+P3+P4;

g1 = diff(P, the1)
g2 = diff(P, the2)
g3 = diff(P, the3)
g4 = diff(P, the4)

gtot=[g1;g2;g3;g4];

C_pb10 = sym(zeros(4,4));
C_pb10(:,:,2) = sym(zeros(4,4));
C_pb10(:,:,3) = sym(zeros(4,4));
C_pb10(:,:,4) = sym(zeros(4,4));

Thetas = sym([the1, the2, the3, the4]);

for i=1:4
    for j=1:4
        for k=1:4    
           C_pb10(i,j,k) = 1/2*(diff(D_pb10(k,j), Thetas(i)) + diff(D_pb10(k,i), Thetas(j)) - diff(D_pb10(i,j), Thetas(k)));
        end
    end
end

C1 = C_pb10;
g1 = gtot;
