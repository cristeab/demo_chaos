function dy=SimpleChaoticCirc(t,y,flag,rParam)
%simple dissipative nonautonomous chaotic circuit
%for Fourier analysis fs=0.5;vTimeRange=[0:1/fs:500];
%y0=[0.1 0];

%parameters
beta=1;
omega=0.6;
F=rParam;%0.25;%0.68
a=-1.27;
b=-0.68;

%nonlinearity
nonlin=b*y(1)+0.5*(a-b)*(abs(y(1)+1)-abs(y(1)-1));

%initialisation
dy=zeros(2,1);

%ODE
dy(1)=y(2)-nonlin;
dy(2)=-beta*(y(1)+y(2))+F*sin(omega*t);
