function dy=fRC_Colpitts(t,y,flag,rParam)
%simple RC chaotic generator with physical parapeters
%his attractor resembles with chaotic Colpitts attractor
%y0=[0.1 0 0];[V]
%for Fourier analysis fs=20e6; vTimeRange=[0:1/fs:50e-6];

%parameters
k=2;
C1=400e-12;%F
C2=200e-12;%F
C3=200e-12;%F
R1=700;%ohms
RX=70;%ohms
Rj=750;%ohms
Vth=-0.7;%V

%nonlinearity
if y(3)-y(2)>=Vth,
   nonlin=(1/Rj)*(y(3)-y(2));
else
   nonlin=Vth/Rj;
end

%initialisation
dy=zeros(3,1);

%ODE
dy(1)=(1/C1)*(k*(y(1)-y(3))/RX-y(1)/R1);
dy(2)=(1/C2)*nonlin;
dy(3)=(1/C3)*((y(1)-y(3))/RX-nonlin);