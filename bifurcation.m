function bifurcation(action)
%
%Bifurcation - grafical interface for bifurcation ploting
%
%	Click "Start" button in order to begin the simulation.
%   You can stop the simulation at any time by pressing the "Stop"
%   button.
%   Using the "New plot" button a new figure is displayed with the obtained
%   bifurcation.
%   "Help" button displays this message.
%   Use "Exit" button in order to close the graphical interface and clear
%   all used variables.
%
%   A time discrete chaotic generator can be selected in the upper part of the graphical
%   interface. Use the "..." (browse) button in order to select a
%   specific chaotic generator from the list.
%
%   From the graphical interface the following parameters can be modified:
%   - Param. range: range of the parameter of the chaotic generator ;
%   - Nb. of points: number of points used for each parameter value in
%   order to construct the bifurcation diagram;
%   - Plotting style: "0" use dots and "1" use a continuous line for plotting
%   the attractor;
%   - Time range: discrete time range for the state variable of the chaotic
%   generator;
%   - Select variable: state variable used to plot the bifurcation diagram;
%   - Initial cond: initial conditions for the chaotic generator;
%
%	In the bottom of the figure is displayed current value of the parameter
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
   addpath([pwd '/Discr']);
   addpath([pwd '/Prvt']);
   %initialize GUI
   srtBifurcationGUI;
   %set default generator (logisticmap)
%    d=dir('Discr');
%    str = {d.name};
%    s=cell2struct(str(3),{'str'},1);
%    fcname=s.str(1:end-2);
   fcname = 'logisticmap';
   hndf=gcf;
   set(findobj(hndf,'Tag','edtTitle'),'FontSize',10,'String',fcname)
   %set default values
   structData=BifInit(fcname);
   vParamRg=structData.ParamRg;
   nNbPts=structData.NbPts;
   vTimeRange=structData.TimeRange;
   nSelVar=structData.SelVar;
   y0=structData.InitCond;
   if ~isempty(vParamRg) | ~isempty(nNbPts) | ~isempty(vTimeRange) | ~isempty(nSelVar) | ~isempty(y0)
       %display default values
       plot(0.5,0.5)
       cla
       set(findobj(hndf,'Tag','edtParamRg'),'String',num2str(vParamRg,4));
       set(findobj(hndf,'Tag','edtNbPts'),'String',num2str(nNbPts));
       set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange,4));
       set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(nSelVar,2));
       set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0,3));
       set(findobj(hndf,'Tag','txtVal'),'String',[])
   end
elseif strcmp(action,'Start')
   hndf=gcf;
   %set buttons
   set(findobj(hndf,'Tag','btnStop'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnExit'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'off');
   %get current values
   fcname=get(findobj(hndf,'Tag','edtTitle'),'String');
   vParamRg=str2num(get(findobj(hndf,'Tag','edtParamRg'),'String'));
   nNbPts=str2num(get(findobj(hndf,'Tag','edtNbPts'),'String'));
   vTimeRange=str2num(get(findobj(hndf,'Tag','edtTimeRange'),'String'));
   nSelVar=str2num(get(findobj(hndf,'Tag','edtSelVar'),'String'));
   y0=str2num(get(findobj(hndf,'Tag','edtInitCond'),'String'));
   %bifurcation
   ud.xpts=[];
   ud.ypts=[];
   ud.stop=0;
   for k_var=vParamRg(1):(vParamRg(2)-vParamRg(1)+1)/nNbPts:vParamRg(2)
	    %solver
   		[T,Y]=m_dreTF(fcname,vTimeRange,y0,k_var);
		xutil=Y(1,nSelVar);
		%eliminate redundant points
		for n=2:length(Y(:,nSelVar))
			if xutil~=Y(n,nSelVar)
				xutil=[xutil;Y(n,nSelVar)];
			end
		end
		ud.xpts=[ud.xpts; k_var*ones(length(xutil),1)];
		ud.ypts=[ud.ypts; xutil];
		set(gcf,'UserData',ud)
		if k_var==vParamRg(1)
    		hpts=plot(ud.xpts,ud.ypts,'.','MarkerSize',1,'EraseMode','none');
			set(gca,'XLimMode','manual','YLimMode','manual')
			xmin=min(ud.xpts);
			xmax=max(ud.xpts)+0.1;
			ymin=min(ud.ypts)-0.1;
			ymax=max(ud.ypts)+0.1;
			axis([xmin xmax ymin ymax])
		else
			xlim = get(gca,'xlim');
    		ylim = get(gca,'ylim');
			%replot everything if out of axis range
			if (k_var < xlim(1)) | (xlim(2) < k_var) | (min(xutil) < ylim(1)) | (ylim(2) < max(xutil))
				xmin=xlim(1);
				xmax=xlim(2);
				ymin=ylim(1);
				ymax=ylim(2);
    			if k_var < xlim(1)
					xmin=k_var-0.1;
				elseif xlim(2) < k_var
					xmax=k_var+0.1;
					xmax=min(xmax,vParamRg(2));
				elseif min(xutil) < ylim(1)
					ymin=min(xutil)-0.1;
				elseif ylim(2) < max(xutil)
					ymax=max(xutil)+0.1;
				end
				axis([xmin xmax ymin ymax])
				set(hpts,'XData',ud.xpts,'YData',ud.ypts)
			else
				%plot only the new data.
      			set(hpts,'XData',k_var*ones(length(xutil),1),'YData',xutil); 
			end
			set(findobj(hndf,'Tag','txtVal'),'String',num2str(k_var))
    		drawnow
		end
		%check stop button
		ud=get(gcf,'UserData');
		if ud.stop, break; end
   end
   %set buttons
   set(findobj(hndf,'Tag','btnStop'), 'Enable', 'off');
   set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnExit'), 'Enable', 'on');
   set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'on');
elseif strcmp(action,'Stop')
    hndf=gcf;
    %set buttons
    set(findobj(hndf,'Tag','btnStop'), 'Enable', 'off');
    set(findobj(hndf,'Tag','btnNewPlot'), 'Enable', 'on');
    set(findobj(hndf,'Tag','btnExit'), 'Enable', 'on');
    set(findobj(hndf,'Tag','btnBrowse'), 'Enable', 'on');
    %set flag
    ud=get(hndf,'UserData');
    ud.stop=1;
    set(hndf,'UserData',ud);
elseif strcmp(action,'NewPlot')
   hndf=gcf;
   ud=get(hndf,'UserData');
   fcname=get(findobj(hndf,'Tag','edtTitle'),'String');
   h0 = figure('Units','normalized','Color',[1 1 1],'Name','Bifurcation - new plot', ...
   		'ToolBar','none','Numbertitle','off','Position',[0.15 0.15 0.65 0.7]);
   axes('Parent',h0,'Position',[0.07 0.07 0.87 0.85]);
   box
   plot(ud.xpts,ud.ypts,'.','MarkerSize',1)
   axis tight
   %Text : axes title
	uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 0],'Position',[0.255 0.925 0.5 0.05],'Style','text', ...
   'String',fcname,'FontSize',15);
elseif strcmp(action,'Browse')
    nVal=get(findobj(gcf,'Tag','popupGT'),'Value');%get generator type {Cont, Discr}
    d=dir('Discr');
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
	   	structData=BifInit(fcname);
	   	vParamRg=structData.ParamRg;
		nNbPts=structData.NbPts;
	   	vTimeRange=structData.TimeRange;
		nSelVar=structData.SelVar;
	   	y0=structData.InitCond;
   		if ~isempty(vParamRg) | ~isempty(nNbPts) | ~isempty(vTimeRange) | ~isempty(nSelVar) | ~isempty(y0)
			%display default values
			plot(0.5,0.5)
			cla
    		set(findobj(hndf,'Tag','edtParamRg'),'String',num2str(vParamRg,4));
			set(findobj(hndf,'Tag','edtNbPts'),'String',num2str(nNbPts));
    		set(findobj(hndf,'Tag','edtTimeRange'),'String',num2str(vTimeRange,4));
 			set(findobj(hndf,'Tag','edtSelVar'),'String',num2str(nSelVar,2));
   			set(findobj(hndf,'Tag','edtInitCond'),'String',num2str(y0,3));
			set(findobj(hndf,'Tag','txtVal'),'String',[])
        end
        set(findobj(hndf,'Tag','btnStart'), 'Enable', 'on')
        set(findobj(hndf,'Tag','btnStop'), 'Enable', 'off')
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
function srtBifurcationGUI
%creates a GUI for bifurcation drawing

%Callback strings
cbstrStart='bifurcation(''Start'')';
cbstrStop='bifurcation(''Stop'')';
cbstrNewPlot='bifurcation(''NewPlot'')';
cbstrHelp='helpwin(''bifurcation'','''',''Bifurcation Help Window'')';
cbstrBrowse='bifurcation(''Browse'')';
cbstrExit='bifurcation(''Exit'')';

WinWidth=0.8;		%Window width
WinHeight=0.78;   %Window height
BtnWidth=0.12;		%Button width
BtnHeight=0.05;   %Button height
xPos=0.865;       %X-position of buttons

h0 = figure('Units','normalized','Color',[1 1 1],'Name','Bifurcation','NumberTitle','off', ...
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
%Button : stop
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.88 BtnWidth BtnHeight], ...
   'String','Stop','Tag','btnStop','Callback',cbstrStop, 'Enable', 'off');
%Button : new plot
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.82 BtnWidth BtnHeight], ...
   'String','New plot','Tag','btnNewPlot','Callback',cbstrNewPlot,'Enable','off');
%Text : parameter range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.74 BtnWidth BtnHeight],'String','Param. range','Style','text');
%Edit : parameter range
edtInitTime = uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.7 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtParamRg');
%Text : number of points
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.62 BtnWidth BtnHeight],'String','Nb. of points','Style','text');
%Edit : number of points
edtInitTime = uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.58 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtNbPts');
%Text : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.5 BtnWidth BtnHeight],'String','Time range','Style','text', ...
   'Tag','txtTimeRange');
%Edit : time range
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.46 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtTimeRange');
%Text : select variable
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.38 BtnWidth BtnHeight],'String','Select variable','Style','text', ...
   'Tag','txtSelVar');
%Edit : select variable
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.34 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtSelVar');
%Text : initial conditions
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[0.513725 0.6 0.694118], ...
   'Position',[xPos 0.26 BtnWidth BtnHeight],'String','Initial cond.','Style','text');
%Edit : initial conditions
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[xPos 0.22 BtnWidth BtnHeight],'Style','edit', ...
   'Tag','edtInitCond');
%Button : help
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.12 BtnWidth BtnHeight], ...
   'String','Help','Tag','btnHelp','Callback',cbstrHelp, 'Enable', 'on');
%Button : exit
uicontrol('Parent',h0,'Units','normalized','Position',[xPos 0.06 BtnWidth BtnHeight], ...
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
    'Tag','btnBrowse', 'Enable', 'on');
%Text : current values and time
uicontrol('Parent',h0,'Units','normalized','BackgroundColor',[1 1 1], ...
   'ForegroundColor',[0 0 1],'Position',[0.0057 0.01 0.835 0.045],'Style','text', ...
   'Tag','txtVal');

set(h0,'Visible','on');
