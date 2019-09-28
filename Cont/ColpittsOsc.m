function dy=ColpittsOsc(t,y,flag,rParam)
%Colpitts oscillator
%y0=[0.1 0 0];
%for Fourier analysis fs=10; vTimeRange=[0:1/fs:50];

%parameters
alpha=1;
betaF=200;
gama=-20/3;
delta=5.5;
epsilon=20/3;
rho=2;
r=rParam;%0.25

%nonlinearity
if y(2)<=1
   nonlin=0;
else
   nonlin=y(2)-1;
end
   
%initialisation
dy=zeros(3,1);

%ODE
dy(1)=y(3)-betaF*nonlin;
dy(2)=alpha*(-r*(y(2)+gama)-y(3)-nonlin);
dy(3)=delta*(-y(1)+y(2)+epsilon)-rho*y(3);      
