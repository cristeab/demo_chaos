function timefreq(action)
%timefreq - time and frequency domain for a chaotic signal
%
%	Click "Start" button in order to begin the simulation.
%   Using the "New plot" button a new figure is displayed with the obtained
%   temporal plot and spectrum plot in separate windows.
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
%   - Parameter value: value of the parameter of the chaotic generator;
%   - Sampling freq.: sampling frequency for the state variable used to
%   plot the signal spectrum;
%   - Select variable: selection of the state variable to represent;
%   - Time range: time interval in which the state variables are computed;
%   - Int. range for FFT: integration range for the FFT;
%   - Initial conditions: initial conditions for the chaotic generator.
%   b) time discrete
%   - Parameter value: value of the parameter of the chaotic generator;
%   - Sampling freq.: not used in this case;
%   - Select variable: selection of the state variable to represent;
%   - Time range: time interval in which the state variables are computed;
%   - Int. range for FFT: integration range for the FFT;
%   - Initial conditions: initial conditions for the chaotic generator.
%
%     In the time domain the signal is computed with the default sampling
%   frequency, given by the ode solver (ode45).
%     The power spectrum is computed with the given sampling frequency,
%   or with the default sampling frequency, when the edit box for sampling
%   frequency is empty. So the sampling frequency, when is given,
%   affects only the signal used to compute the power spectrum.
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
   srtTimeFreqGUI;
   %set default generator (RC_Colpitts)
%    d=dir('Cont');
%    str = {d.name};
%    s=cell2struct(str(3),{'str'},1);
%    fcname=s.str(1:end-2);
   hndf=gcf;
   set(findobj(hndf,'Tag','popupGT'), 'Value', 1);
   fcname = 'RC_Colpitts';
   set(findobj(hndf,'Tag','edtTitle'),'FontSize',10,'String',fcname)
   %set default values
   structData=TFInit(fcname);
   rParam=structData.ParamVal;
   rFsamp=structData.fsamp;
   nSelVar=structData.SelVar;
   vTimeRange=structData.TimeRange;
   vIntRange=structData.IntRange;
   y0=structData.InitCond;
   if ~isempty(rParam) | ~isempty(rFsamp) | ~isempty(nSelVar) | ~isempty(vTimeRange) ...
           | ~isempty(vIntRange) | ~isempty(y0)
       %display default values
       hndaxes(1)=findobj(hndf,'Tag','aTimeDom');
       hndaxes(2)=findobj(hndf,'Tag','aFreqDom');
       axes(hndaxes(1));cla
       axes(hndaxes(2));cla;set(gca,'xlim',[0 0.5])
       set(findobj(hndf,'Tag','edtParVal'),'String',num2str(rParam))
       set(findobj(hndf,'Tag','edtSampFreq'),'String',num2str(rFsamp))
       set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(nSelVar))
       set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange))
       set(findobj(hndf,'Tag','edtIntRange'),'String',num2str(vIntRange))
       set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0))
       set(findobj(hndf,'Tag','txtVal'),'String',[])
   end
elseif strcmp(action,'Start')
   hndf=gcf;
   %disable buttons
   set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnExit'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'off');
   set(findobj(hndf,'Tag','popupGT'), 'Enable', 'off');
   
   %get current values
   fcname=get(findobj(hndf,'Tag','edtTitle'),'String');
   rParam=str2num(get(findobj(hndf,'Tag','edtParVal'),'String')); 
   rFsamp=str2num(get(findobj(hndf,'Tag','edtSampFreq'),'String')); 
   nSelVar=str2num(get(findobj(hndf,'Tag','edtSelVar'),'String'));
   vTimeRange=str2num(get(findobj(hndf,'Tag','edtTimeRange'),'String')); 
   vIntRange=str2num(get(findobj(hndf,'Tag','edtIntRange'),'String')); 
   y0=str2num(get(findobj(hndf,'Tag','edtInitCond'),'String'));
   
   %clear axes and display status
   hndaxes(1)=findobj(hndf,'Tag','aTimeDom');
   hndaxes(2)=findobj(hndf,'Tag','aFreqDom');
   axes(hndaxes(1));cla
   axes(hndaxes(2));cla;set(gca,'xlim',[0 0.5])
   set(findobj(hndf,'Tag','txtVal'),'String','Computing...');
   drawnow
   
   %select solver and plot commands
   nVal=get(findobj(hndf,'Tag','popupGT'),'Value');%get generator type {Cont, Discr}
   axes(hndaxes(1));
   bidonstr=get(gca,'Tag');
   if nVal==1 %Cont
	    if ~isempty(rFsamp)
        	vIntRange=[vIntRange(1):1/rFsamp:vIntRange(2)];
        end
   		[T_time,Y_time]=ode45(fcname,vTimeRange,y0,[],rParam);%time domain
		plot(T_time,Y_time(:,nSelVar))
   		[T_freq,Y_freq]=ode45(fcname,vIntRange,y0,[],rParam);%frequency domain
   elseif nVal==2 %Discr
	    [T_time,Y_time]=m_dreTF(fcname,vTimeRange,y0,rParam);%time domain
		stem(T_time,Y_time(:,nSelVar))
        [T_freq,Y_freq]=m_dreTF(fcname,vIntRange,y0,rParam);%frequency domain
   end
   set(gca,'Tag',bidonstr)
   title('Time domain');xlabel('Time');ylabel('Magnitude');
   grid on
   [waxis,Pyy]=m_powerspec(Y_freq(:,nSelVar));
   vInd=find(waxis>=0);%select the nonredundant region
   axes(hndaxes(2));
   clear bidonstr
   bidonstr=get(gca,'Tag');
   plot(waxis(vInd),10*log10(Pyy(vInd)))
   set(gca,'Tag',bidonstr)
   title('Frequency domain');xlabel('Normalized frequency f/f_s');ylabel('Power [dB]');
   grid on
   set(hndaxes(2),'XTick',0:0.05:0.5);
   
   %estimate a sampling frequency
   fsamp=1/mean(diff(T_freq));
   
   %display sampling frequency used to compute FT
   set(findobj(hndf,'Tag','txtVal'),'String',['Sampling frequency: ' num2str(fsamp)]);
   
   %store data for new plot
   ud.T_time=T_time;
   ud.Y_time=Y_time(:,nSelVar);
   ud.fsamp=fsamp;
   ud.waxis=waxis;
   ud.Pyy=Pyy;
   set(hndf,'UserData',ud);
   
   %enable buttons
   set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnExit'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'on');
   set(findobj(hndf,'Tag','popupGT'), 'Enable', 'on');

elseif strcmp(action,'NewPlot')
   %get data
   hndf=gcf;
   ud=get(hndf,'UserData');
   fcname=get(findobj(hndf,'Tag','edtTitle'),'String');
   nVal=get(findobj(hndf,'Tag','popupGT'),'Value');%get generator type {Cont, Discr}
   %Time domain
   figure('Color',[1 1 1],'Name','Time domain - new plot','NumberTitle','off');
   if nVal==1
   		plot(ud.T_time,ud.Y_time);
   elseif nVal==2
	    stem(ud.T_time,ud.Y_time)
   end
   grid on
   title(fcname);xlabel(['Time']);ylabel('Magnitude');
   %Frequency domain
   figure('Color',[1 1 1],'Name','Frequency domain - new plot','NumberTitle','off');
   vInd=find(ud.waxis>=0);
   plot(ud.waxis(vInd),10*log10(ud.Pyy(vInd)));
   grid on
   set(gca,'XTick',0:0.05:0.5);
   title(fcname);
   xlabel(['Normalized frequency f/f_s(f_s=' num2str(ud.fsamp,'%3g') ')']);
   ylabel('Power [dB]');
elseif strcmp(action,'GT')
   	hndf=gcf;
    nVal=get(findobj(hndf,'Tag','popupGT'),'Value');%get generator type {Cont, Discr}
	%modify GUI
	hndaxes(1)=findobj(hndf,'Tag','aTimeDom');
    hndaxes(2)=findobj(hndf,'Tag','aFreqDom');
    axes(hndaxes(1));cla
    axes(hndaxes(2));cla;set(gca,'xlim',[0 0.5])
	set(findobj(hndf,'Tag','edtTitle'),'String',[])
	set(findobj(hndf,'Tag','edtParVal'),'String',[])
	set(findobj(hndf,'Tag','edtSampFreq'),'String',[])
	set(findobj(hndf,'Tag','edtSelVar'),'String',[])
	set(findobj(hndf,'Tag','edtTimeRange'),'String',[])
	set(findobj(hndf,'Tag','edtIntRange'),'String',[])
	set(findobj(hndf,'Tag','edtInitCond'),'String',[])
	set(findobj(hndf,'Tag','txtVal'),'String',[])
    if nVal==1 %Cont
		set(findobj(hndf,'Tag','edtSampFreq'),'Enable','on');
    elseif nVal==2 %Discr
		set(findobj(hndf,'Tag','edtSampFreq'),'Enable','off');
    end	
    set(findobj(hndf,'Tag','btnBrowse'),'Enable','on');
    set(findobj(hndf,'Tag','btnStart'),'Enable','off');
    set(findobj(hndf,'Tag','btnNewPlot'),'Enable','off');
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
	    structData=TFInit(fcname);
	    rParam=structData.ParamVal;
	    rFsamp=structData.fsamp;
	    nSelVar=structData.SelVar;
	    vTimeRange=structData.TimeRange;
	    vIntRange=structData.IntRange;
	    y0=structData.InitCond;
		if ~isempty(rParam) | ~isempty(rFsamp) | ~isempty(nSelVar) | ~isempty(vTimeRange) ...
				| ~isempty(vIntRange) | ~isempty(y0)
			%display default values
			hndaxes(1)=findobj(hndf,'Tag','aTimeDom');
    		hndaxes(2)=findobj(hndf,'Tag','aFreqDom');
    		axes(hndaxes(1));cla
    		axes(hndaxes(2));cla;set(gca,'xlim',[0 0.5])
   			set(findobj(hndf,'Tag','edtParVal'),'String',num2str(rParam))
   			set(findobj(hndf,'Tag','edtSampFreq'),'String',num2str(rFsamp))
   			set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(nSelVar))
   			set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange))
   			set(findobj(hndf,'Tag','edtIntRange'),'String',num2str(vIntRange))
   			set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0))
			set(findobj(hndf,'Tag','txtVal'),'String',[])
        end
        set(findobj(hndf,'Tag','btnStart'), 'Enable', 'on')
        set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'off')
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
function srtTimeFreqGUI
%creates a GUI for time evolution and power spectrum drawing

%Callback strings
cbstrStart='timefreq(''Start'')';
cbstrNewPlot='timefreq(''NewPlot'')';
cbstrHelp='helpwin(''timefreq'','''',''Time and Frequency Domain Help Window'')';
cbstrGT='timefreq(''GT'')';
cbstrBrowse='timefreq(''Browse'')';
cbstrExit='timefreq(''Exit'')';

WinWidth=0.75;		%Window width
WinHeight=0.85;   %Window height
BtnWidth=0.15;		%Button width
BtnHeight=0.05;   %Button height
xPos=0.835;       %X-position of buttons

h0 = figure('Units','normalized','Color',[1 1 1],'Name','Time/Frequency Domain','NumberTitle','off', ...
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
   'String','Start','Tag','btnStart','Callback',cbstrStart,'Enable','on');
%Button : new plot
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.85 BtnWidth BtnHeight], ...
   'String','New plot','Tag','btnNewPlot','Callback',cbstrNewPlot,'Enable','off');
%Text : parameter value
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.77 BtnWidth BtnHeight],'String','Parameter value','Style','text');
%Edit : parameter value
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.74 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtParVal');
%Text : sampling frequency
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.66 BtnWidth BtnHeight],'String','Sampling freq.(fs)','Style','text');
%Edit : sampling frequency
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.63 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtSampFreq');
%Text : select variable
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.55 BtnWidth BtnHeight],'String','Select variable','Style','text');
%Edit : select variable
edtInitTime = uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.52 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtSelVar');
%Text : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.44 BtnWidth BtnHeight],'String','Time range','Style','text', ...
   'Tag','txtTimeRange');
%Edit : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.41 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtTimeRange');
%Text : integration range for FFT
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.33 BtnWidth BtnHeight],'String','Int. range for FFT','Style','text', ...
   'Tag','txtIntRange');
%Edit : integration range for FFT
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.3 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtIntRange');
%Text : initial conditions
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.22 BtnWidth BtnHeight],'String','Initial conditions','Style','text');
%Edit : initial conditions
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.19 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtInitCond');
%Button : help
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.1 BtnWidth BtnHeight], ...
   'String','Help','Tag','btnHelp','Callback',cbstrHelp,'Enable','on');
%Button : exit
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.03 BtnWidth BtnHeight], ...
   'String','Exit','Tag','btnExit','Callback',cbstrExit,'Enable','on');
%Axes : time domain
axes('Parent',h0,'Position',[0.1 0.64 0.68 0.255],'Tag','aTimeDom');
box
title('Time domain');xlabel('Time');ylabel('Magnitude');
%Axes : power spectrum
axes('Parent',h0,'Position',[0.1 0.15 0.68 0.37],'Tag','aFreqDom');
box
title('Frequency domain');xlabel('Normalized frequency f/f_s');ylabel('Power [dB]');
%Popup : generator type
uicontrol('Parent',h0,'Units','normalized','Position',[0.125 0.935 0.165 0.05], ...
    'BackgroundColor',[1 1 1],'ForegroundColor',[0 0 0],'Style','popup', ...
    'String','Time continuous|Time discrete','Value',1,'Tag','popupGT','Callback',cbstrGT,'Enable','on');
%Edit : axes title
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 0],'Position',[0.29 0.94 0.3 0.05],'Style','edit', ...
   'Tag','edtTitle');
%Button : browse
uicontrol('Parent',h0,'Units','normalized','Position',[0.59 0.946 0.03 0.04], ...
    'Style','pushbutton','String','...','Callback',cbstrBrowse, ...
    'Tag', 'btnBrowse','Enable','on');
%Text : current values and time
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[0.0057 0.01 0.81 0.045],'Style','text', ...
   'Tag','txtVal');

set(h0,'Visible','on');
