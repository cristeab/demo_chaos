function dy=fColpittsOsc(t,y,flag,rParam)
%Colpitts oscillator with physical parameters
%y0=[0.1 0 0];
%for Fourier analysis fs=0.5e6; vTimeRange=[0:1/fs:1e-3];

%parameters
betaF=200;
Vth=0.75;%[V]
Ron=100;%[ohmi]
L=98.5e-6;%[H]
Rl=35;%[ohms]
C1=54e-9;%[F]
C2=54e-9;%[F]
Ree=400;%[ohms]
Vcc=5;%[V]
Vee=-5;%[V]

%nonlinearity
if y(2)<=Vth
   nonlin=0;
else
   nonlin=(y(2)-Vth)/Ron;
end
   
%initialisation
dy=zeros(3,1);

%ODE
dy(1)=(1/C1)*(y(3)-betaF*nonlin);
dy(2)=(1/C2)*(-(Vee+y(2))/Ree-y(3)-nonlin);
dy(3)=(1/L)*(Vcc-y(1)+y(2)-y(3)*Rl);      
