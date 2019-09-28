function attractor(action)
%
%Attractor - grafical interface for 2D attractors plotting
%
%	Click "Start" button in order to begin the simulation.
%   You can stop the simulation at any time by pressing the "Stop"
%   button.
%   Using the "New plot" button a new figure is displayed with the obtained
%   2D attrator.
%   "Help" button displays this message.
%   Use "Exit" button in order to close the graphical interface and clear
%   all used variables.
%
%   A chaotic generator can be selected in the upper part of the graphical
%   interface. Select first the chaotic generator type, "time continuous" or
%   "time discrete" and then use the "..." (browse) button in order to select a
%   specific chaotic generator from the list.
%
%   From the graphical interface the following parameters can be modified:
%   a) time continuous
%   - Select variables: two different state variables can be selected from
%   all available state variables that describe the chaotic generator;
%   - Initial cond: initial conditions for the chaotic generator;
%   - Parameter value: value of the parameter of the chaotic generator;
%   - Time range: time interval in which the state variables are computed.
%   b) time discrete
%   - Plotting style: "0" use dots and "1" use a continuous line for plotting
%   the attractor;
%   - Initial cond: initial conditions for the chaotic generator;
%   - Parameter value: value of the parameter of the chaotic generator;
%   - Iterations: number of iterations used for plotting the attractor.
%
%	In the bottom of the figure are displayed current values of the state
%	variables and, in brackets, current time or (iteration).
%
%   The available chaotic generators are:
%   a) time continuous
%      - Autonomous4DCirc: four dimensional autonomous chaotic circuit
%           /
%           | dx/dt = delta*(x+gamma*y)-z-f_d1(x)
%           | dy/dt = beta*(delta*(x+gamma*y)-w-gamma*f_d2(y))
%           | dz/dt = x
%           | dw/dt = alpha*y
%           \
%           where f_dk(x)=0.5*(|x-1|+x-1)/epsilon_k, k=1,2
%                 alpha = 2, beta arbitrary, gamma = 3, delta = 0.27,
%                 epsilon_1 = 0.8, epsilon_2 = 0.2
%      - ChuaCirc: Chua's autonomous circuit
%           /
%           | dx/dt = alpha*(-x+y-h(x))
%           | dy/dt = x-y+z
%           | dz/dt = -beta*y
%           \
%           where h(x) = bx+0.5*(a-b)*(|x+1|-|x-1|)
%                 alpha arbitrary, beta = 15, a = -1.3, b = -0.7
%      - ChuaCircCN: Chua's circuit with a cubic nonlinearity - normalized
%      parameters 
%           /
%           | dx/dt = alpha*(-x+y-h(x))
%           | dy/dt = x-y+z
%           | dz/dt = -beta*y
%           \
%           where h(x) = cx+d*x^3
%                 alpha arbitrary, beta = 15, a = -1.3, b = 0.07
%      - ColpittsOsc: Colpitts oscillator
%           /
%           | dx/dt = z-beta_F*f(y)
%           | dy/dt = alpha*(-r*(y+gamma)-z-f(y))
%           | dz/dt = delat*(-x+y+epsilon)-rho*z
%           \
%                        /
%           where f(y) = | 0  , y<=1
%                        | y-1, otherwise
%                        \
%                 alpha = 1, betaF = 200, gamma = -20/3, delta = 5.5,
%                 epsilon = 20/3, rho = 2, r arbitrary
%      - fAutonomous4DCirc: four dimensional autonomous chaotic circuit
%      with physical parameters
%           /
%           | C_1*dv_1/dt = g*(v_1+v_2)-i_1-i_d1(v_1)
%           | C_2*dv_2/dt = g*(v_1+v_2)-i_2-i_d2(v_2)
%           | L_1*di_1/dt = v_1
%           | L_2*di_2/dt = v_2
%           \
%           where i_dk(v_k)=0.5*G_k*(|v_k-E_k|+v_k-E_k), k=1,2
%                 L_1 = 0.2 H, L_2 = 0.3 H, C_1 = 10 pF, C_2 = 19.6 pF, E_1
%                 = 0.7 V, E_2 = 2.1 V, g = 1.9092 uS, G_1 = 8.8388 uS, G_2
%                 = 35.355 uS
%      - fChuaCirc: Chua's autonomous circuit with physical parameters
%           /
%           | C_1*dv_C1/dt = -v_C1/R+v_C2/R-g(v_C1)
%           | C_2*dv_C2/dt = v_C1/R-v_C2/R+i_L
%           | L*di_L/dt = -v_C2
%           \
%           where g(v_C1) = G_b*v_C1+0.5*(G_a-G_b)*(|v_C1+V_P|-|v_C1-V_P|)
%                 C_1 = 10 pF, C_2 = 100 pF, R = 1224.7 Ohms, L = 10 uH,
%                 G_a = -1.1 mS, G_b = -0.57157 mS, V_p = 1 V
%      - fColpittsOsc: Colpitts oscillator with physical parameters
%           /
%           | C_1*dv_CE/dt = i_L-beta_F*i_B(v_BE)
%           | C_2*dv_BE/dt = (V_EE+v_BE)/R_EE-i_L-i_B(v_BE)
%           | L*di_L/dt = V_CC-v_CE+v_BE-i_L*R_L
%           \
%                             /
%           where i_B(v_BE) = | 0               , v_BE<=V_TH
%                             | (v_BE-V_TH)/R_ON, otherwise
%                             \
%                 beta_F = 200, V_TH = 0.75 V, R_ON = 100 Ohms, L = 98.5
%                 uH, R_1 = 35 Ohms, C_1 = 54 nF, C_2 = 54 nF, R_EE = 400,
%                 V_CC = 5 V, V_EE = -5 V
%      - fRayleighOsc: Rayleigh oscillator with physical parameters
%           /
%           | C*dv/dt = i+i_d(-v)
%           | L*di/dt = -v-E_1-E_2*sin(Omega*t)
%           \
%           where i_d(v) = -g_1*v+g_3*v^3
%                 E_1 = 1 V, E_2 = 878 uV, g_1 = 1.542, g_3 = 0.5, L = 10
%                 uH, C = 2.377 uF, Omega = 60.3e3 rad/s
%      - fRC_Colpitts: simple RC chaotic generator with physical parameters
%           /
%           | C_1*dv_C1/dt = K*(v_C1-v_C3)/R_X-v_C1/R_1
%           | C_2*dv_C2/dt = i_J(v_C2, v_C3)
%           | C_3*dv_C3/dt = (v_C1-v_C3)/R_X-i_J(v_C2, v_C3)
%           \
%                                           /
%           where i_J(v_C2, v_C3) = (1/R_J)*| v_C3-v_C2, if v_C3-v_C2>=V_TH
%                                           | V_TH     , otherwise
%                                           \
%                 K = 2, C_1 = 400 pF, C_2 = 200 pF, C_3 = 200 pF, R_1 =
%                 700 Ohms, R_X = 70 Ohms , R_J = 750 Ohms, V_TH = -0.7 V, 
%      - fRC_Hysteresis: RC OTA hysteresis chaos generator with physical
%      parameters
%           /
%           | C_1*dv_1/dt = -(v_1+v_2)/R_1
%           | C_2*dv_2/dt = -(v_1+v_2)/R_1-v_2/R_2+G*(v_1+v_2)+i_h(v_1)
%           \
%                            /
%           where i_h(v_1) = | I_0 , if v_1<=V
%                            | -I_0, if v_1>=V
%                            \
%                 R = 1 kOhm, C = 1 nF, G = 3.02 mS, V = 1V, I_0 = 1 mA
%      - fRC_NonlinCirc: third order RC ladder phase shift oscillator with
%      physical parameters
%           /
%           | C*dv_1/dt = (f(v_3)-v_1)/R+(v_2-v_1)/R
%           | C*dv_2/dt = (v_1-v_2)/R+(v_3-v_2)/R
%           | C*dv_3/dt = (v_2-v_3)/R
%           \
%                          /
%                          | m_b*v_3+(m_b-m_a)*V_P, if v_3<-V_P
%           where f(v_3) = | m_a*v_3              , if -V_P<=v_3<=V_P
%                          | m_b*v_3-(m_b-m_a)*V_P, otherwise
%                          \      
%                 R = 1 kOhm, C = 1 nF, V_P = 1 mV, m_a = -33.03, m_b = 250
%      - fSimpleChaoticCirc: simple dissipative nonautonomous chaotic
%      circuit with physical parameters
%           /
%           | C*dv_C/dt = i_L-g(v_C)
%           | L*di_L/dt = -R*i_L-v_C+A*sin(Omega*t)
%           \
%           where g(v_C) = G_b*v_C+0.5*(G_a-G_b)*(|v_C+B_P|-|v_C-B_P|)
%                 R = 1 kOhm, G_a = -1.27 mS, G_b = -0.68 mS, L = 10 uH, C
%                 = 10 pF, Omega = 60e6 rad/s, B_P = 1 V, A = 0.25 V
%      - Lorenz: Lorenz system
%           /
%           |dx/dt=sigma*(y-x);
%           |dy/dt=rho*x-y-x*z;
%           |dz/dt=x*y-beta*z;
%           \
%           where sigma arbitrary, rho = 28, beta = 8/3
%      - RayleighOsc: Rayleigh oscillator
%           /
%           | epsilon*dx/dt = y+f(-x)
%           | dy/dt = -x-a-b*sin(omega*t)
%           \
%           where f(x) = -x*(1-x^2)
%                 epsilon = 0.1, a = 0.56946, b = 5e-4, k arbitrary, omega
%                 = 1.3946
%      - RC_Colpitts: simple RC chaotic generator
%           /
%           | dx/dt = K*K_1*(x-z)-x
%           | dy/dt = 2*K_2*f(y,z)
%           | dz/dt = 2*K_1*(x-z)-2*K_2*f(y,z)
%           \
%                          /
%           where f(y,z) = | z-y, if z-y<=1
%                          | 1  , otherwise
%                          \
%                 k arbitrary, K_1 = 11, K_2 = 0.9
%      - RC_Hysteresis: RC OTA hysteresis chaos generator
%           /
%           | dx/dt = -x-y
%           | dy/dt = 2*(delta+1)*x+(2*delta+1)*y+p*h(x)
%           \
%                        /
%           where h(x) = | p , if x<=1
%                        | -p, if x>=-1
%                        \
%                 p = 1, delta arbitrary
%      - RC_NonlinCirc: third order RC ladder phase shift oscillator
%           /
%           | dx/dt = -2*x+y+f(z)
%           | dy/dt = x-2*y+z
%           | dz/dt = y-z
%           \
%                        /
%                        | m_b*z+m_b-m_a, if z<-1
%           where f(z) = | m_a*z        , if -1<=z<=1
%                        | m_b*z-m_b+m_a, otherwise
%                        \  
%                 m_a = -33.03, m_b arbitrary
%      - SimpleChaoticCirc: simple dissipative nonautonomous chaotic
%      circuit
%           /
%           | dx/dt = y-g(x)
%           | dy/dt = -beta*y-beta*x+F*sin(omega*t)
%           \
%           where g(x) = b*x+0.5*(a-b)*(|x+1|-|x-1|)
%                 beta = 1, omega = 0.6, F arbitrary, a = -1.27, b = -0.68
%   b) time discrete
%      - BernoulliMap: Bernoulli map
%           x[n] = mod(k*x[n-1], 1)
%           where k arbitrary
%      - genhaos: chaos generator with a recursive structure
%           x[n] = f(k[1]*x[n-1]+k[2]*x[n-2]+k[3]*x[n-3])
%           where f(x) = x-2*floor((x+1)/2), k[1] arbitrary, k[2] = k[3] = 1
%      - henonmap: Henon map
%           x[n] = 1-alpha*x[n-1]^2+y[n-1];
%           y[n] = beta*x[n-1];
%           where alpha arbitrary, beta = 0.3
%      - logisticmap1: logistic like map 1
%           x[n] = (k^2)*x[n-1]*(1-x[n-1])*((1-2*x[n-1])^2);
%           where k arbitrary
%      - logisticmap2: logistic like map 2
%           x[n] = k*x[n-1]*(0.75-(x[n-1]^2))
%           where k arbitrary
%      - logisticmap3: logistic like map 3
%           x[n] = k*x[n-1]*(1.25-(5*(x[n-1]^2))+(4*(x[n-1]^4)))
%           where k arbitrary
%      - logisticmap: logistic map
%           x[n] = k*x[n-1]*(1-x[n-1])
%           where k arbitrary
%      - miramap: Mira map
%           x[n] = y[n-1]
%                          /
%                          | -a*x[n-1]                 , if x[n-1]<6
%           y[n] = y[n-1]+ |
%                          | lambda*x[n-1]-6*(a+lambda), otherwise
%                          \
%           where a arbitrary, lambda = 2
%      - PWAMmap1: piece wise affine Markov map 1
%                  /
%                  | B*(D-abs(x[n-1]))   , if abs(x[n-1])<=D
%           x[n] = |
%                  | B*(abs(x[n-1])-2*D) , otherwise
%                  \
%           where B arbitrary, D = 1
%      - PWAMmap2: piece wise affine Markov map 2
%                  /
%                  | -B*abs(x[n-1])       , if abs(x[n-1])<=D
%           x[n] = |
%                  | -B*(abs(x[n-1])-2*D) , otherwise
%                  \
%           where B arbitrary, D = 1
%      - PWAMmap3: piece wise affine Markov map 3
%                  /
%           x[n] = | -B*x[n-1]                   , if abs(x[n-1])<=D
%                  | B*(x[n-1]-2*D*sign(x[n-1])) , otherwise
%                  \
%           where B arbitrary, D = 1           
%      - PWAMmap4: piece wise affine Markov map 4
%                  /
%                  | B*(-x[n-1]+D*sign(x[n-1]))  , if abs(x[n-1])<=D
%           x[n] = |
%                  | B*(x[n-1]-2*D*sign(x[n-1])) , otherwise
%                  \
%           where B arbitrary, D = 1           
%      - TailedTentMap: tailed tent map
%           x[n] = 1-2*abs(x[n-1]-((1-k)/2))+max(x[n-1]-1+k,0)
%           where k arbitrary
%      - tentmap1: tent like map 1
%                  /
%                  | k*x[n-1]       , if (0<=x[n-1]) & (x[n-1]<1/3)
%           x[n] = | k*(2/3-x[n-1]) , if (1/3<=x[n-1]) & (x[n-1]<2/3)
%                  | k*(-2/3+x[n-1]), otherwise
%                  \
%           where k arbitrary
%      - tentmap2: tent like map 2
%                  /
%                  | k*x[n-1]             , if (0<=x[n-1]) & (x[n-1]<1/4)
%           x[n] = | sqrt(k)*(1-2*x[n-1]) , if (1/4<=x[n-1]) & (x[n-1]<1/2)
%                  | sqrt(k)*(2*x[n-1]-1) , if (1/2<=x[n-1]) & (x[n-1]<3/4)
%                  | k*(1-x[n-1])         , otherwise
%                  \
%           where k arbitrary
%      - tentmap: tent map
%           x[n] = k*(1-abs(1-2*x[n-1]))
%           where k arbitrary

if nargin==0
	
   %set paths 
   addpath([pwd '/Cont']);
   addpath([pwd '/Discr']);
   addpath([pwd '/Prvt']);
   %initialize GUI
   srtAttractorGUI;
   %set default generator (ChuaCirc)
%    d=dir('Cont');
%    str = {d.name};
%    s=cell2struct(str(3),{'str'},1);
%    fcname=s.str(1:end-2);
   hndf=gcf;
   set(findobj(hndf,'Tag','popupGT'), 'Value', 1);
   fcname = 'ChuaCirc';
   set(findobj(hndf,'Tag','edtTitle'),'FontSize',10,'String',fcname)
   %set default values
   structData=AttInit(fcname);
   vSelVar=structData.SelVar;
   y0=structData.InitCond;
   rParam=structData.ParamVal;
   vTimeRange=structData.TimeRange;
   if ~isempty(vSelVar) | ~isempty(y0) | ~isempty(rParam) | ~isempty(vTimeRange)
       %display default values
       cla
       set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(vSelVar,2));
       set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0,2));
       set(findobj(hndf,'Tag','edtParamVal'),'String',num2str(rParam));
       set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange,2));
       set(findobj(hndf,'Tag','txtVal'),'String',[])
   end
elseif strcmp(action,'Start')
   hndf=gcf;
   %set buttons
   set(findobj(hndf,'Tag','btnStop'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnExit'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'off');
   set(findobj(hndf,'Tag','popupGT'), 'Enable', 'off');
   %get current values
   fcname=get(findobj(hndf,'Tag','edtTitle'),'String');
   vSelVar=str2num(get(findobj(hndf,'Tag','edtSelVar'),'String'));
   y0=str2num(get(findobj(hndf,'Tag','edtInitCond'),'String'));
   rParam=str2num(get(findobj(hndf,'Tag','edtParamVal'),'String'));
   vTimeRange=str2num(get(findobj(hndf,'Tag','edtTimeRange'),'String'));
   nVal=get(findobj(hndf,'Tag','popupGT'),'Value');
   %select solver
   if nVal==1
   	   options=odeset('OutputFcn','m_odephas2','OutputSel',vSelVar);
       ode45(fcname,vTimeRange,y0,options,rParam);
   elseif nVal==2
	   m_dre(fcname,vTimeRange,y0,rParam)
   end
   %set buttons
   set(findobj(hndf,'Tag','btnStop'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnExit'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'on');
   set(findobj(hndf,'Tag','popupGT'), 'Enable', 'on');
elseif strcmp(action,'Stop')
   hndf=gcf;
   %set buttons
   set(findobj(hndf,'Tag','btnStart'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnStop'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnExit'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'on');
   set(findobj(hndf,'Tag','popupGT'), 'Enable', 'on');
   %set flag
   ud=get(hndf,'UserData');
   ud.stop=1;
   set(hndf,'UserData',ud);
elseif strcmp(action,'NewPlot')
   hndf=gcf;
   ud=get(hndf,'UserData');
   fcname=get(findobj(hndf,'Tag','edtTitle'),'String');
   h0 = figure('Units','normalized','Color',[1 1 1],'Name','2D Attractor - new plot', ...
   		'ToolBar','none','Numbertitle','off','Position',[0.15 0.15 0.65 0.7]);
   axes('Parent',h0,'Position',[0.07 0.07 0.87 0.85]);
   box
   if get(findobj(hndf,'Tag','popupGT'),'Value')==2 & ...
	  ~str2num(get(findobj(hndf,'Tag','edtSelVar'),'String'))
  		plot(ud.y(:,1),ud.y(:,2),'.')
   else
   		plot(ud.y(:,1),ud.y(:,2))
   end
   axis tight
   %Text : axes title
	uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 0],'Position',[0.255 0.925 0.5 0.05],'Style','text', ...
   'String',fcname,'FontSize',15);
elseif strcmp(action,'GT')
    nVal=get(findobj(gcf,'Tag','popupGT'),'Value');%get generator type {Cont, Discr}
   	hndf=gcf;
	%modify GUI
	cla
	set(findobj(hndf,'Tag','edtTitle'),'String',[])
	set(findobj(hndf,'Tag','edtSelVar'),'String',[])
	set(findobj(hndf,'Tag','edtInitCond'),'String',[])
	set(findobj(hndf,'Tag','edtParamVal'),'String',[])
	set(findobj(hndf,'Tag','edtTimeRange'),'String',[])
	set(findobj(hndf,'Tag','txtVal'),'String',[])
    set(findobj(hndf,'Tag','btnStart'),'Enable','off')
    set(findobj(hndf,'Tag','btnStop'),'Enable','off')
    set(findobj(hndf,'Tag','btnNewPlot'),'Enable','off')
    set(findobj(hndf,'Tag','btnBrowse'),'Enable','on')
    if nVal==1 %Cont
		set(findobj(hndf,'Tag','txtSelVar'),'String','Select variables');
		set(findobj(hndf,'Tag','txtTimeRange'),'String','Time range');
    elseif nVal==2 %Discr
		set(findobj(hndf,'Tag','txtSelVar'),'String','Plotting style');
		set(findobj(hndf,'Tag','txtTimeRange'),'String','Iterations');
    end	
elseif strcmp(action,'Browse')
    nVal=get(findobj(gcf,'Tag','popupGT'),'Value');%get generator type {Cont, Discr}
    if nVal==1
        d=dir('Cont');
    elseif nVal==2
        d=dir('Discr');
    end
    str = {d.name};
    [Selection,ok] = listdlg('PromptString','Select a file:',...
                'SelectionMode','single',...
                'ListString',str(3:end));
    if ok
        s=cell2struct(str(2+Selection),{'str'},1);
        fcname=s.str(1:end-2);
		hndf=gcf;
		set(findobj(hndf,'Tag','edtTitle'),'FontSize',10,'String',fcname)
		%set default values
	   	structData=AttInit(fcname);
		vSelVar=structData.SelVar;
	   	y0=structData.InitCond;
	   	rParam=structData.ParamVal;
	   	vTimeRange=structData.TimeRange;
   		if ~isempty(vSelVar) | ~isempty(y0) | ~isempty(rParam) | ~isempty(vTimeRange)
			%display default values 
			cla
   			set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(vSelVar,2));
   			set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0,2));
   			set(findobj(hndf,'Tag','edtParamVal'),'String',num2str(rParam));
   			set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange,2));
			set(findobj(hndf,'Tag','txtVal'),'String',[]);
        end
        %set buttons
        set(findobj(hndf,'Tag','btnStart'), 'Enable', 'on');
        set(findobj(hndf,'Tag','btnStop'), 'Enable', 'off');
        set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'off');
    end
elseif strcmp(action,'Exit')
	%clear global variables
	clear global
   	%clear paths 
  	rmpath([pwd '\Cont']);
   	rmpath([pwd '\Discr']);
  	rmpath([pwd '\Prvt']);
	%close figure
	close(gcf)
	
end

%---------------- subroutine -----------------
function srtAttractorGUI
%creates a GUI for attractors drawing

%Callback strings
cbstrStart='attractor(''Start'')';
cbstrStop='attractor(''Stop'')';
cbstrNewPlot='attractor(''NewPlot'')';
cbstrHelp='helpwin(''attractor'','''',''2D Attractor Help Window'')';
cbstrGT='attractor(''GT'')';
cbstrBrowse='attractor(''Browse'')';
cbstrExit='attractor(''Exit'')';

WinWidth=0.8;		%Window width
WinHeight=0.78;   %Window height
BtnWidth=0.12;		%Button width
BtnHeight=0.05;   %Button height
xPos=0.865;       %X-position of buttons

h0 = figure('Units','normalized','Color',[1 1 1],'Name','2D Attractor','NumberTitle','off', ...
   'Position',[0.1 0.1 WinWidth WinHeight],'MenuBar','none','ToolBar','none', ...
   'Resize','off','Visible','off');

%Frame : left
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[0.85 0 0.15 1],'Style','frame');
%Frame : bottom
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[0 0 0.85 0.0676],'Style','frame');
%Button : start
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.94 BtnWidth BtnHeight], ...
   'String','Start','Tag','btnStart','Callback',cbstrStart,'Enable','on');
%Button : stop
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.88 BtnWidth BtnHeight], ...
   'String','Stop','Tag','btnStop','Callback',cbstrStop,'Enable','off');
%Button : new plot
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.82 BtnWidth BtnHeight], ...
   'String','New plot','Tag','btnNewPlot','Callback',cbstrNewPlot,'Enable','off');
%Text : select variables
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.68 BtnWidth BtnHeight],'String','Select variables','Style','text', ...
   'Tag','txtSelVar');
%Edit : select variables
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.64 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtSelVar');
%Text : initial conditions
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.56 BtnWidth BtnHeight],'String','Initial cond.','Style','text');
%Edit : initial conditions
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.52 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtInitCond');
%Text : parameter value
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.44 BtnWidth BtnHeight],'String','Parameter value','Style','text');
%Edit : parameter value
edtInitTime = uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.4 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtParamVal');
%Text : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.32 BtnWidth BtnHeight],'String','Time range','Style','text', ...
   'Tag','txtTimeRange');
%Edit : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.28 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtTimeRange');
%Button : help
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.12 BtnWidth BtnHeight], ...
   'String','Help','Tag','btnHelp','Callback',cbstrHelp,'Enable','on');
%Button : exit
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.06 BtnWidth BtnHeight], ...
   'String','Exit','Tag','btnExit','Callback',cbstrExit,'Enable','on');
%Axes
axes('Parent',h0,'Position',[0.07 0.15 0.75 0.75]);
box
%Popup : generator type
uicontrol('Parent',h0,'Units','normalized','Position',[0.14 0.912 0.16 0.05], ...
    'BackgroundColor',[1 1 1],'ForegroundColor',[0 0 0],'Style','popup', ...
    'String','Time continuous|Time discrete','Value',1,'Tag','popupGT','Callback',cbstrGT,'Enable','on');
%Edit : axes title
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 0],'Position',[0.3 0.915 0.3 0.05],'Style','edit', ...
   'Tag','edtTitle');
%Button : browse
uicontrol('Parent',h0,'Units','normalized','Position',[0.603 0.92 0.03 0.04], ...
    'Style','pushbutton','String','...','Callback',cbstrBrowse, ...
    'Tag', 'btnBrowse','Enable','on');
%Text : current values and time
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[0.0057 0.01 0.835 0.045],'Style','text', ...
   'Tag','txtVal');

set(h0,'Visible','on');
