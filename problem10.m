lq1 = length(q1);

tau1 = zeros(lq1,1);
tau2 = zeros(lq1,1);
tau3 = zeros(lq1,1);
tau4 = zeros(lq1,1);

for k=1:length(q1)
    for i=1:4
        for j=1:4
            test = k
            g2 = subs(g1,the1,q1(k));
            g3 = subs(g2,the2,q2(k));
            g4 = subs(g3,the3,q3(k));
            g5 = subs(g4,the4,q4(k));

            C2 = subs(C1,the1,q1(k));
            C3 = subs(C2,the2,q2(k));
            C4 = subs(C3,the3,q3(k));
            C5 = subs(C4,the4,q4(k));

            D2 = subs(D_pb10,the1,q1(k));
            D3 = subs(D2,the2,q2(k));
            D4 = subs(D3,the3,q3(k));
            D5 = subs(D4,the4,q4(k));
           
            tau1(k) = C5(i,j,1)*qdotot(i,k)*qdotot(j,k) + g5(1);
            tau2(k) = C5(i,j,2)*qdotot(i,k)*qdotot(j,k) + g5(2);
            tau3(k) = C5(i,j,3)*qdotot(i,k)*qdotot(j,k) + g5(3);
            tau4(k) = C5(i,j,4)*qdotot(i,k)*qdotot(j,k) + g5(4);
%         
%             tau1(k) = D5(1,j)*qdotdot(j,k)+C5(i,j,1)*qdotot(i,k)*qdotot(j,k) + g5(1);
%             tau2(k) = D5(2,j)*qdotdot(j,k)+C5(i,j,2)*qdotot(i,k)*qdotot(j,k) + g5(2);
%             tau3(k) = D5(3,j)*qdotdot(j,k)+C5(i,j,3)*qdotot(i,k)*qdotot(j,k) + g5(3);
%             tau4(k) = D5(4,j)*qdotdot(j,k)+C5(i,j,4)*qdotot(i,k)*qdotot(j,k) + g5(4);
        end
    end
end


tt1 = abs(tau1)/(10e+02);
tt2 = abs(tau2)/(10e+02);
tt3 = abs(tau3)/(10e+02);
tt4 = abs(tau4)/(10e+02);

figure(5)
plot(tt1)
hold on 
plot(tt2)
hold on 
plot(tt3)
hold on 
plot(tt4)
legend('tau1', 'tau2', 'tau3','tau4')
ylim([-10 130])
ylabel('Torques in N/mm')


