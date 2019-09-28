function dy=fAutonomous4DCirc(t,y)
%four dimensional autonomous chaotic circuit with physical parameters
%y0=[0.1 0 0 0];
%C2 seem to be very important

%parameters
L1=200e-3;%[H]
L2=300e-3;%[H]
C1=10e-12;%[F]
C2=19.6e-12;%[F]
E1=0.7;%[V]
E2=2.1;%[V]
g=1.9092e-6;%[S]
G1=8.8388e-6;%[S]
G2=35.355e-6;%[S]

%nonlinearity
nonlin1=0.5*G1*(abs(y(1)-E1)+y(1)-E1);
nonlin2=0.5*G2*(abs(y(2)-E2)+y(2)-E2);

%initialisation
dy=zeros(4,1);

%ODE
dy(1)=(1/C1)*(g*(y(1)+y(2))-y(3)-nonlin1);
dy(2)=(1/C2)*(g*(y(1)+y(2))-y(4)-nonlin2);
dy(3)=(1/L1)*y(1);
dy(4)=(1/L2)*y(2);