function dy=RC_NonlinCirc(t,y,flag,rParam)
%third order RC ladder phase shift oscillator
%y0=[3 0 -1];
%for Fourier analysis vTimeRange=[0 150];fs=2.5
%around t=150 the circuit looses his chaotic state for mb=360

%parameters
ma=-33.03;
mb=rParam;%250

%nonlinearity
nonlin=mb*y(3)+0.5*(ma-mb)*(abs(y(3)+1)-abs(y(3)-1));

%initialisaton
dy=zeros(3,1);

%ODE
dy(1)=-2*y(1)+y(2)+nonlin;
dy(2)=y(1)-2*y(2)+y(3);
dy(3)=y(2)-y(3);