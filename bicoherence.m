function bicoherence(action)
%
%Bicoherence - grafical interface for power spectrum and bicoherence ploting
%
%	Click "Start" button in order to begin the simulation.
%   Using the "New plot" button a new figure is displayed with the obtained
%   bicoherence.
%   "Help" button displays this message.
%   Use "Exit" button in order to close the graphical interface and clear
%   all used variables.
%
%   A time continuous chaotic generator can be selected in the upper part of the graphical
%   interface. Use the "..." (browse) button in order to select a
%   specific chaotic generator from the list.
%
%   From the graphical interface the following parameters can be modified:
%   - Parameter value: value of the parameter of the chaotic generator;
%   - Sampling freq.: sampling frequency for state variables of the chaotic
%   generator;
%   - Select variable: state variable to use;
%   - Time range: time interval in which the state variable is computed.
%   - Initial cond: initial conditions for the chaotic generator;
%
%     FFT is calculated by removing the mean value of the time series. Thus the
%   DC component is removed.
%
%     You can improve the resolution of calculations by choosing a greater 
%   time range.
%
%   The available time continuous chaotic generators are:
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

if nargin==0
   %set paths 
   addpath([pwd '\Cont']);
   addpath([pwd '\Prvt']);
   %initialize GUI
   srtBicoherenceGUI;
   %set default generator (ColpittsOsc)
%    d=dir('Cont');
%    str = {d.name};
%    s=cell2struct(str(3),{'str'},1);
%    fcname=s.str(1:end-2);
   fcname = 'ColpittsOsc';
   hndf=gcf;
   set(findobj(hndf,'Tag','edtTitle'),'FontSize',10,'String',fcname)
   %set default values
   structData=BicInit(fcname);
   rParam=structData.ParamVal;
   rFsamp=structData.Fsamp;
   nSelVar=structData.SelVar;
   vTimeRange=structData.TimeRange;
   y0=structData.InitCond;
   if ~isempty(rParam) | ~isempty(rFsamp) | ~isempty(nSelVar) | ~isempty(vTimeRange) | ~isempty(y0)
       %display default values
       hndaxes(1)=findobj(hndf,'Tag','aPowSpec');
       hndaxes(2)=findobj(hndf,'Tag','aBicoher');
       axes(hndaxes(1));cla
       axes(hndaxes(2));cla
       set(findobj(hndf,'Tag','edtParVal'),'String',num2str(rParam,4));
       set(findobj(hndf,'Tag','edtSampFreq'),'String',num2str(rFsamp,2));
       set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(nSelVar));
       set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange,5));
       set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0,2));
       set(findobj(hndf,'Tag','txtVal'),'String',[])
   end
elseif strcmp(action,'Start')
   hndf=gcf;
   %disable buttons
   set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnExit'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'off');
   %get current values
   fcname=get(findobj(hndf,'Tag','edtTitle'),'String');
   rParam=str2num(get(findobj(hndf,'Tag','edtParVal'),'String')); 
   rFsamp=str2num(get(findobj(hndf,'Tag','edtSampFreq'),'String')); 
   nSelVar=str2num(get(findobj(hndf,'Tag','edtSelVar'),'String'));
   vTimeRange=str2num(get(findobj(hndf,'Tag','edtTimeRange'),'String')); 
   y0=str2num(get(findobj(hndf,'Tag','edtInitCond'),'String'));
   hndaxes(1)=findobj(hndf,'Tag','aPowSpec');
   hndaxes(2)=findobj(hndf,'Tag','aBicoher');
   
   %clear axes and display status
   axes(hndaxes(1));cla
   axes(hndaxes(2));cla
   set(findobj(hndf,'Tag','txtVal'),'String','Computing...');
   drawnow
   
   vTimeRange=[vTimeRange(1):1/rFsamp:vTimeRange(2)];
    [T,Y]=ode45(fcname,vTimeRange,y0,[],rParam);

	[waxis,Pyy,bic]=m_bicoher(Y(:,nSelVar));

	axes(hndaxes(1));
	bidonstr=get(hndaxes(1),'Tag');
	%select the nonredundant region
   vIndf1=find(waxis>=0);
   %plot commands
	plot(waxis(vIndf1),Pyy(vIndf1));
	set(hndaxes(1),'XLim',[0 0.5],'XTick',0:0.05:0.5,'Tag',bidonstr);
   grid on
   title('Power spectrum');xlabel('f_1/f_s');ylabel('Power');
	drawnow

	axes(hndaxes(2));
	clear bidonstr
	bidonstr=get(hndaxes(2),'Tag');
   %select the nonredundant region
   vIndf2=find(waxis>=0 & waxis<=0.25);
   %plot commmands
	contour(waxis(vIndf1),waxis(vIndf2),bic(vIndf2,vIndf1),8);
	axis([0 0.5 0 0.25]);
	patch([0 0 0.25],[0 0.25 0.25],[1 1 1],'EdgeColor','none','EraseMode','none'); 
	patch([0.5 0.5 0.25],[0 0.25 0.25],[1 1 1],'EdgeColor','none','EraseMode','none');
	set(hndaxes(2),'Layer','top','XTick',0:0.05:0.5,'Tag','aBicoher');
   grid on
   title('Bicoherence');xlabel('f_1/f_s');ylabel('f_2/f_s');
   
   %store data for new plot
   matData=[bic(vIndf2,vIndf1);waxis(vIndf1)';Pyy(vIndf1)'];
   matData=[matData [waxis(vIndf2);0;0]];
   set(hndf,'UserData',matData);
   
   %display FFT length
   set(findobj(hndf,'Tag','txtVal'),'String',['FFT length : ' num2str(length(Pyy))]);
   
   %enable buttons
   set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnExit'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'on');

elseif strcmp(action,'NewPlot')
   hndf=gcf;
   matData=get(hndf,'UserData');
   vf1=matData(end-1,1:end-1);
   vf2=matData(1:end-2,end);
   vPyy=matData(end,1:end-1);
   matBic=matData(1:end-2,1:end-1);
   fcname=get(findobj(hndf,'Tag','edtTitle'),'String');
   
   h0 = figure('Units','normalized','Color',[1 1 1],'Name','Bicoherence - new plot', ...
      'ToolBar','none','Numbertitle','off','Position',[0.175 0.07 0.65 0.85]);
   
    subplot('Position',[0.13 0.615 0.775 0.28]);
	plot(vf1,vPyy);
	set(gca,'XLim',[0 0.5],'XTick',0:0.05:0.5);
    grid on
	title('Power spectrum');xlabel('f/f_s');ylabel('Power');
	drawnow

	subplot('Position',[0.13 0.11 0.775 0.3839]);
	contour(vf1,vf2,matBic,8);
	axis([0 0.5 0 0.25]);
	patch([0 0 0.25],[0 0.25 0.25],[1 1 1],'EdgeColor','none','EraseMode','none');
	patch([0.5 0.5 0.25],[0 0.25 0.25],[1 1 1],'EdgeColor','none','EraseMode','none');
    set(gca,'Layer','top','XTick',0:0.05:0.5);
    grid on
    title('Bicoherence');xlabel('f_1/f_s');ylabel('f_2/f_s');
   
   %Text : axes title
	uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 0],'Position',[0.27 0.93 0.5 0.05],'Style','text', ...
   'String',fcname,'FontSize',15);
elseif strcmp(action,'Browse')
    d=dir('Cont');
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
	   	structData=BicInit(fcname);
		rParam=structData.ParamVal;
		rFsamp=structData.Fsamp;
		nSelVar=structData.SelVar;
		vTimeRange=structData.TimeRange;
	   	y0=structData.InitCond;
   		if ~isempty(rParam) | ~isempty(rFsamp) | ~isempty(nSelVar) | ~isempty(vTimeRange) | ~isempty(y0)
			%display default values 
			hndaxes(1)=findobj(hndf,'Tag','aPowSpec');
    		hndaxes(2)=findobj(hndf,'Tag','aBicoher');
    		axes(hndaxes(1));cla
    		axes(hndaxes(2));cla
   			set(findobj(hndf,'Tag','edtParVal'),'String',num2str(rParam,4));
   			set(findobj(hndf,'Tag','edtSampFreq'),'String',num2str(rFsamp,2));
   			set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(nSelVar));
   			set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange,5));
			set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0,2));
			set(findobj(hndf,'Tag','txtVal'),'String',[])
        end
        set(findobj(hndf,'Tag','btnStart'), 'Enable', 'on')
        set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'off')
        set(findobj(hndf,'Tag','btnExit'), 'Enable', 'on')
    end
elseif strcmp(action,'Exit')
	%clear global variables
	clear global
   	%clear paths 
  	rmpath([pwd '\Cont']);
  	rmpath([pwd '\Prvt']);
	%close figure
	close(gcf)

end

%---------------- subroutine -----------------
function srtBicoherenceGUI
%creates a GUI for power spectrum and bicoherence drawing

%Callback strings
cbstrStart='bicoherence(''Start'')';
cbstrNewPlot='bicoherence(''NewPlot'')';
cbstrHelp='helpwin(''bicoherence'','''',''Bicoherence Help Window'')';
cbstrBrowse='bicoherence(''Browse'')';
cbstrExit='bicoherence(''Exit'')';

WinWidth=0.75;		%Window width
WinHeight=0.85;   %Window height
BtnWidth=0.15;		%Button width
BtnHeight=0.05;   %Button height
xPos=0.835;       %X-position of buttons

h0 = figure('Units','normalized','Color',[1 1 1],'Name','Bicoherence','NumberTitle','off', ...
   'Position',[0.125 0.05 WinWidth WinHeight],'MenuBar','none','ToolBar','none', ...
   'Resize','off','Visible','off');

%Frame : left
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[0.82 0 0.2 1],'Style','frame');
%Frame : bottom
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[0 0 0.82 0.0676],'Style','frame');
%Button : start
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.92 BtnWidth BtnHeight], ...
   'String','Start','Tag','btnStart','Callback',cbstrStart, 'Enable', 'on');
%Button : new plot
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.85 BtnWidth BtnHeight], ...
   'String','New plot','Tag','btnNewPlot','Callback',cbstrNewPlot, ...
   'Enable', 'off');
%Text : parameter value
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.72 BtnWidth BtnHeight],'String','Parameter value','Style','text');
%Edit : parameter value
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.69 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtParVal');
%Text : sampling frequency
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.6 BtnWidth BtnHeight],'String','Sampling freq.(fs)','Style','text');
%Edit : sampling frequency
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.57 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtSampFreq');
%Text : select variable
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.48 BtnWidth BtnHeight],'String','Select variable','Style','text');
%Edit : select variable
edtInitTime = uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.45 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtSelVar');
%Text : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.36 BtnWidth BtnHeight],'String','Time range','Style','text');
%Edit : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.33 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtTimeRange');
%Text : initial conditions
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.24 BtnWidth BtnHeight],'String','Initial conditions','Style','text');
%Edit : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.21 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtInitCond');
%Button : help
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.1 BtnWidth BtnHeight], ...
   'String','Help','Tag','btnHelp','Callback',cbstrHelp, 'Enable', 'on');
%Button : exit
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.03 BtnWidth BtnHeight], ...
   'String','Exit','Tag','btnExit','Callback',cbstrExit, 'Enable', 'on');
%Axes : power spectrum
axes('Parent',h0,'Position',[0.1 0.64 0.68 0.255],'Tag','aPowSpec');
box
title('Power spectrum');xlabel('f_1/f_s');ylabel('Power');
%Axes : bicoherence
axes('Parent',h0,'Position',[0.1 0.15 0.68 0.37],'Tag','aBicoher');
box
title('Bicoherence');xlabel('f_1/f_s');ylabel('f_2/f_s');
%Edit : axes title
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 0],'Position',[0.291 0.94 0.3 0.05],'Style','edit', ...
   'Tag','edtTitle');
%Button : browse
uicontrol('Parent',h0,'Units','normalized','Position',[0.593 0.946 0.03 0.04], ...
    'Style','pushbutton','String','...','Callback',cbstrBrowse, ...
    'Tag', 'btnBrowse', 'Enable', 'on');
%Text : current values and time
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[0.0057 0.01 0.81 0.045],'Style','text', ...
   'Tag','txtVal');

set(h0,'Visible','on');
