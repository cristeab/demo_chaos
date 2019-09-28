function dy=fChuaCirc(t,y,flag,rParam)
%Chua's autonomous circuit with physical parameters
%y0=[1 0.2 0];[V]
%for Fourier analysis fs=30e6; vTimeRange=[0:1/fs:10e-6];

%parameters
C1=10e-12;%[F]
C2=100e-12;%[F]
R=1224.7;%[ohms]
L=10e-6;%[H]
Ga=-1.1e-3;%[S]
Gb=-0.57157e-3;%[S]
Vp=1;%[V]

%nonlinearity
nonlin=Gb*y(1)+0.5*(Ga-Gb)*(abs(y(1)+Vp)-abs(y(1)-Vp));

%initialisation
dy=zeros(3,1);

%ODE
dy(1)=(1/C1)*(-(1/R)*y(1)+(1/R)*y(2)-nonlin);
dy(2)=(1/C2)*((1/R)*y(1)-(1/R)*y(2)+y(3));
dy(3)=-(1/L)*y(2);      
   
