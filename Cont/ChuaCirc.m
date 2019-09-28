function dy=ChuaCirc(t,y,flag,rParam)
%Chua's autonomous circuit
%y0=[1 0.2 0];

%parameters
alpha=rParam;%10
beta=15;
a=-1.3;
b=-0.7;

%nonlinearity
nonlin=b*y(1)+0.5*(a-b)*(abs(y(1)+1)-abs(y(1)-1));

%initialisation
dy=zeros(3,1);

%ODE
dy(1)=-alpha*y(1)+alpha*y(2)-alpha*nonlin;
dy(2)=y(1)-y(2)+y(3);
dy(3)=-beta*y(2);      
   
