function dy=fSimpleChaoticCirc(t,y,flag,rParam)
%simple dissipative nonautonomous chaotic circuit with physical parameters
%y0=[0.1 0] [V]
%for Fourier analysis fs=50e6; vTimeRange=[0:1/fs:5e-6];

%parameters
R=1e3;%[ohms]
Ga=-1.27e-3;%[S]
Gb=-0.68e-3;%[S]
L=10e-6;%[H]
C=10e-12;%[F]
OMEGA=60e6;%[rad/s]
Bp=1;%[V]
A=0.25;%[V]

%nonlinearity
nonlin=Gb*y(1)+0.5*(Ga-Gb)*(abs(y(1)+Bp)-abs(y(1)-Bp));

%initialisation
dy=zeros(2,1);

%ODE
dy(1)=(1/C)*(y(2)-nonlin);
dy(2)=(1/L)*(-y(1)-R*y(2)+A*sin(OMEGA*t));
