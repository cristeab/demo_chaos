function dy=fRC_NonlinCirc(t,y,flag,rParam)
%third order RC ladder phase shift oscillator with physical parameters
%y0=[3e-3 0 -1e-3][V];
%for Fourier analysis fs=5e6; vTimeRange=[0:1/fs:0.1e-3];

%parameters
R=1e3;%[ohms]
C=1e-9;%[F]
Vp=1e-3;%[V]
ma=-33.03;
mb=250;

%nonlinearity
nonlin=mb*y(3)+0.5*(ma-mb)*(abs(y(3)+Vp)-abs(y(3)-Vp));

%initialisaton
dy=zeros(3,1);

%ODE
dy(1)=(-2*y(1)+y(2)+nonlin)/(R*C);
dy(2)=(y(1)-2*y(2)+y(3))/(R*C);
dy(3)=(y(2)-y(3))/(R*C);