function dy=RayleighOsc(t,y,flag,rParam)
%Rayleigh oscillator
%y0=[0.1 0];
%for Fourier analysis fs=4; vTimeRange=[0:1/fs:150];

%parameters
eps=0.1;
a=0.56946;
b=5e-4;%5e-2;
k=rParam;%0.5;%1.5;%2.5
OMEGA=1.3946;

%nonlinearity
nonlin=-(-y(1))*(1-(-y(1))^2);

%initialisation
omega=k*OMEGA;
dy=zeros(2,1);

%ODE
dy(1)=(1/eps)*(y(2)+nonlin);
dy(2)=-y(1)-a-b*sin(omega*t);