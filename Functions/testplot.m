tau1
tau2
tau3
tau4

tt1 = abs(tau1)/(10e+02);%*10e+08;
tt2 = abs(tau2)/(10e+02);%*10e+08;
tt3 = abs(tau3)/(10e+02);%*10e+08;
tt4 = abs(tau4)/(10e+02);%*10e+08;

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