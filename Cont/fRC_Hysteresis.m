function dy=fRC_Hysteresis(t,y,flag,rParam)
%RC OTA hysteresis chaos generator with physical parameters
%y0=[0 0] [V]
%global m_hystState={-I0,I0} must be set outside of the function 
%global m_hystState
%m_hystState=I0;
%ode45(...
%clear m_hystState

%parameters
R=1e3;%[ohms]
C=1e-9;%[F]
G=3.02e-3;%[S]
V=1;%[V]
I0=1e-3;%[A]

%nonlinearity
global m_hystState 
if (y(1)<=-V)&(m_hystState==-I0)
   m_hystState=I0;
elseif (y(1)>=V)&(m_hystState==I0)
   m_hystState=-I0;
end

%initialisation
dy=zeros(2,1);

%ODE
dy(1)=-(y(1)+y(2))/(R*C);
dy(2)=(1/C)*(-(y(1)+y(2))/R-y(2)/R+G*(y(1)+y(2))+m_hystState);