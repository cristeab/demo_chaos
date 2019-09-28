function dy=Autonomous4DCirc(t,y,flag,rParam)
%four dimensional autonomous chaotic circuit
%y0=[0.1 0 0 0];
%beta variable parameter (0.17)
%eps1,eps2 seem to be very important
%for Fourier analysis fs=1.5, vTimeRange=[0 400]

%parameters
alfa=2;
beta=rParam;%0.16 and 0.17
gama=3;
delta=0.27;%0.27;%variable
eps1=0.8;
eps2=0.2;

%nonlinearity
nonlinX=(abs(y(1)-1)+y(1)-1)/(2*eps1);
nonlinY=(abs(y(2)-1)+y(2)-1)/(2*eps2);

%initialisation
dy=zeros(4,1);

%ODE
dy(1)=delta*(y(1)+gama*y(2))-y(3)-nonlinX;
dy(2)=beta*(delta*(y(1)+gama*y(2))-y(4)-gama*nonlinY);
dy(3)=y(1);
dy(4)=alfa*y(2);