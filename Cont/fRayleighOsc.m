function dy=fRayleighOsc(t,y,flag,rParam)
%Rayleigh oscillator with physical parameters
%y0=[0.1 0] [V];
%for Fourier analysis fs=200e3; vTimeRange=[0:1/fs:1e-3];

%parameters
E1=1;%[V]
E2=878e-6;%[V]
g1=1.542;
g3=0.5;
L=10e-6;%[H]
C=2.377e-6;%[F]
OMEGA=60.3e3;%[rad/s]

%nonlinearity
nonlin=-g1*(-y(1))+g3*(-y(1))^3;

%initialisation
dy=zeros(2,1);

%ODE
dy(1)=(1/C)*(y(2)+nonlin);
dy(2)=(1/L)*(-y(1)-E1-E2*sin(OMEGA*t));