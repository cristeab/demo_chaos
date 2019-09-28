function dy=Lorenz(t,y,flag,rParam)
%Lorenz system

%parameters
sigma=rParam;%10
rho=28;
beta=8/3;

%initialisation
dy=zeros(3,1);

%ODE
dy(1)=sigma*(y(2)-y(1));
dy(2)=rho*y(1)-y(2)-y(1)*y(3);
dy(3)=y(1)*y(2)-beta*y(3);      
   
