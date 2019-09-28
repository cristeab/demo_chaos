function histogram(action)
%
%Histogram - grafical interface for 2D attractors ploting
%
%	Click "Start" button in order to begin the simulation.
%   Using the "New plot" button a new figure is displayed with the obtained
%   histogram.
%   "Help" button displays this message.
%   Use "Exit" button in order to close the graphical interface and clear
%   all used variables.
%
%   A time discrete chaotic generator can be selected in the upper part of the graphical
%   interface. Use the "..." (browse) button in order to select a
%   specific chaotic generator from the list.
%
%   From the graphical interface the following parameters can be modified:
%   - Nb. of intervals: number of intervals on the x-axix used to plot the
%   histogram;
%   - Parameter value: value of the parameter of the chaotic generator;
%   - Time range: temporal range for the state variable of the chaotic
%   generator;
%   - Initial cond: initial conditions for the chaotic generator;
%   - Select variables: select the state variable to be used for histogram
%
%   The available time discrete chaotic generators are:
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
   addpath([pwd '\Discr']);
   addpath([pwd '\Prvt']);
   %initialize GUI
   srtHistogramGUI;
   %set default generator (genhaos)
%    d=dir('Discr');
%    str = {d.name};
%    s=cell2struct(str(3),{'str'},1);
%    fcname=s.str(1:end-2);
   fcname = 'genhaos';
   hndf=gcf;
   set(findobj(hndf,'Tag','edtTitle'),'FontSize',10,'String',fcname)
   %set default values
   structData=HistInit(fcname);
   nbins=structData.Nbins;
   rParam=structData.ParamVal;
   vTimeRange=structData.TimeRange;
   y0=structData.InitCond;
   rSelVar=structData.SelVar;
   if  ~isempty(nbins) | ~isempty(rParam) | ~isempty(vTimeRange) | ~isempty(y0) | ~isempty(rSelVar)
       %display default values
       cla
       set(findobj(hndf,'Tag','edtNbins'),'String',num2str(nbins))
       set(findobj(hndf,'Tag','edtParamVal'),'String',num2str(rParam))
       set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange))
       set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0,2))
       set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(rSelVar,2))
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
   nbins=str2num(get(findobj(hndf,'Tag','edtNbins'),'String'));
   rParam=str2num(get(findobj(hndf,'Tag','edtParamVal'),'String'));
   vTimeRange=str2num(get(findobj(hndf,'Tag','edtTimeRange'),'String'));
   y0=str2num(get(findobj(hndf,'Tag','edtInitCond'),'String'));
   rSelVar=str2num(get(findobj(hndf,'Tag','edtSelVar'),'String'));
   cla; 
   set(findobj(hndf,'Tag','txtVal'),'String','Computing ...')
   drawnow
   %solver
   [T,Y] = m_dreTF(fcname,vTimeRange,y0,rParam);
   %histogram
   if isempty(nbins)
	   nbins=ceil(sqrt(vTimeRange(2)-vTimeRange(1)+1));
   end
   hist(Y(:,rSelVar),nbins)
   xlabel('magnitude');ylabel('number of samples');
   %statistics
   rMean=mean(Y(:,rSelVar));
   rStdDev=std(Y(:,rSelVar));
   rSkew=skewness(Y(:,rSelVar));
   rKurt=kurtosis(Y(:,rSelVar));
   str=sprintf('mean=%-8.3f; std. dev.=%-8.3f; skewness=%-8.3f; kurtosis=%-8.3f',rMean,rStdDev,rSkew,rKurt);
   set(findobj(hndf,'Tag','txtVal'),'String',str)
   %keep Y(:,rSelVar) for new plot
   set(hndf,'UserData',Y(:,rSelVar))
   
    %enable buttons
    set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'on');
    set(findobj(hndf,'Tag','btnExit'), 'Enable', 'on');
    set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'on');

elseif strcmp(action,'NewPlot')
   hndf=gcf;
   samps=get(hndf,'UserData');
   fcname=get(findobj(hndf,'Tag','edtTitle'),'String');
   nbins=str2num(get(findobj(hndf,'Tag','edtNbins'),'String'));
   h0 = figure('Units','normalized','Color',[1 1 1],'Name','Histogram - new plot', ...
   		'ToolBar','none','Numbertitle','off','Position',[0.15 0.15 0.65 0.7]);
   axes('Parent',h0,'Position',[0.07 0.07 0.87 0.85]);
   hist(samps,nbins)
   xlabel('magnitude');ylabel('number of samples');
   %Text : axes title
	uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 0],'Position',[0.255 0.925 0.5 0.05],'Style','text', ...
   'String',fcname,'FontSize',15);
elseif strcmp(action,'Browse')
    d=dir('Discr');
    str={d.name};
    [Selection,ok] = listdlg('PromptString','Select a file:',...
                'SelectionMode','single','ListString',str(3:end));
    if ok
        s=cell2struct(str(2+Selection),{'str'},1);
        fcname=s.str(1:end-2);
        hndf=gcf;
        set(findobj(hndf,'Tag','edtTitle'),'FontSize',10,'String',fcname)		
		%set default values
	   	structData=HistInit(fcname);
		nbins=structData.Nbins;
	   	rParam=structData.ParamVal;
	   	vTimeRange=structData.TimeRange;
	   	y0=structData.InitCond;
		rSelVar=structData.SelVar;
   		if  ~isempty(nbins) | ~isempty(rParam) | ~isempty(vTimeRange) | ~isempty(y0) | ~isempty(rSelVar)
			%display default values 
			cla
			set(findobj(hndf,'Tag','edtNbins'),'String',num2str(nbins))
   			set(findobj(hndf,'Tag','edtParamVal'),'String',num2str(rParam))
   			set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange))
   			set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0,2))
   			set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(rSelVar,2))
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
   	rmpath([pwd '\Discr']);
  	rmpath([pwd '\Prvt']);
	%close figure
	close(gcf)

end

%---------------- subroutine -----------------
function srtHistogramGUI
%creates a GUI for attractors drawing

%Callback strings
cbstrStart='histogram(''Start'')';
cbstrNewPlot='histogram(''NewPlot'')';
cbstrHelp='helpwin(''histogram'','''',''2D Attractor Help Window'')';
cbstrBrowse='histogram(''Browse'')';
cbstrExit='histogram(''Exit'')';

WinWidth=0.8;		%Window width
WinHeight=0.78;   %Window height
BtnWidth=0.12;		%Button width
BtnHeight=0.05;   %Button height
xPos=0.865;       %X-position of buttons

h0 = figure('Units','normalized','Color',[1 1 1],'Name','Histogram','NumberTitle','off', ...
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
   'String','Start','Tag','btnStart','Callback',cbstrStart, 'Enable', 'on');
%Button : new plot
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.88 BtnWidth BtnHeight], ...
   'String','New plot','Tag','btnNewPlot','Callback',cbstrNewPlot, ...
   'Enable', 'off');
%Text : number of intervals
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.76 BtnWidth BtnHeight],'String','Nb. of intervals','Style','text');
%Edit : number of intervals
edtInitTime = uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.72 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtNbins');
%Text : parameter value
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.64 BtnWidth BtnHeight],'String','Parameter value','Style','text');
%Edit : parameter value
edtInitTime = uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.6 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtParamVal');
%Text : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.52 BtnWidth BtnHeight],'String','Time range','Style','text', ...
   'Tag','txtTimeRange');
%Edit : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.48 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtTimeRange');
%Text : initial conditions
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.4 BtnWidth BtnHeight],'String','Initial cond.','Style','text');
%Edit : initial conditions
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.36 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtInitCond');
%Text : select variables
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.28 BtnWidth BtnHeight],'String','Select variables','Style','text', ...
   'Tag','txtSelVar');
%Edit : select variables
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.24 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtSelVar');
%Button : help
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.14 BtnWidth BtnHeight], ...
   'String','Help','Tag','btnHelp','Callback',cbstrHelp, 'Enable', 'on');
%Button : exit
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.08 BtnWidth BtnHeight], ...
   'String','Exit','Tag','btnExit','Callback',cbstrExit, 'Enable', 'on');
%Axes
axes('Parent',h0,'Position',[0.07 0.15 0.75 0.75]);
box
%Edit : axes title
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 0],'Position',[0.3 0.915 0.29 0.05],'Style','edit', ...
   'Tag','edtTitle');
%Button : browse
uicontrol('Parent',h0,'Units','normalized','Position',[0.593 0.92 0.03 0.04], ...
    'Style','pushbutton','String','...','Callback',cbstrBrowse, ...
    'Tag', 'btnBrowse', 'Enable', 'on');
%Text : mean, std. dev., skewness, kurtosis
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[0.0057 0.01 0.835 0.045],'Style','text', ...
   'Tag','txtVal');

set(h0,'Visible','on');
