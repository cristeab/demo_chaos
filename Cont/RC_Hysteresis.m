function dy=RC_Hysteresis(t,y,flag,rParam)
%RC OTA hysteresis chaos generator
%y0=[0 0]
%for Fourier analysis vTimeRange=[0 400];fs=0.5
%for delta=0.03 an instable state
%global m_hystState={-1,1} must be set outside of the function 
%global m_hystState
%m_hystState=1;
%ode45(...
%clear m_hystState

%parameters
p=1;
delta=rParam;%0.01;%very important

%nonlinearity
global m_hystState 
if (y(1)<=-1)&(m_hystState==-1)
   m_hystState=1;
elseif (y(1)>=1)&(m_hystState==1)
   m_hystState=-1;
end

%initialisation
dy=zeros(2,1);

%ODE
dy(1)=-y(1)-y(2);
dy(2)=(2*delta+2)*y(1)+(2*delta+1)*y(2)+p*m_hystState;