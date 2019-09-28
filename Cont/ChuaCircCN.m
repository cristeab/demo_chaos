function dy=ChuaCircCN(t,y,flag,rParam)
%Chua's circuit with a cubic nonlinearity - normalized parameters 

%parameters
alpha=rParam;%8.85 Chua's attractor;9 double scroll Chua's attractor
beta=15;
a=-1.3;
b=0.07;%0.08 a better aproximation for the piecewise linear case
		 %0.04 initial case

%nonlinearity
nonlin=a*y(1)+b*y(1)^3;

%initialisation
dy=zeros(3,1);

%ODE
dy(1)=-alpha*y(1)+alpha*y(2)-alpha*nonlin;
dy(2)=y(1)-y(2)+y(3);
dy(3)=-beta*y(2);      
