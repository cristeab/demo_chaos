function dy=RC_Colpitts(t,y,flag,rParam)
%simple RC chaotic generator
%his attractor resembles with chaotic Colpitts attractor
%initial condition
%y0=[0 0.5 1.5]

%parameters
k=rParam;%2
k1=11;
k2=0.9;

%nonlinearity
if y(3)-y(2)<=1,
   nonlin=y(3)-y(2);
else
   nonlin=1;
end

%initialisation
dy=zeros(3,1);

%ODE
dy(1)=k*k1*(y(1)-y(3))-y(1);
dy(2)=2*k2*nonlin;
dy(3)=2*k1*(y(1)-y(3))-2*k2*nonlin;