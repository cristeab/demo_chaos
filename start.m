function start

%by Bogdan Cristea
%e-mail: cristeab@gmail.com
%modified 27.10.2001
%tested under Matlab 6.0
%modified 21.07.2005
%tested under Matlab 7.0
%modified 27.08.2005
%extended help added

imgpath=[pwd '/Prvt/'];%path to images

winXPos=0.15;
winYPos=0.5;
winWidth=0.72;
winHeight=0.17;

btnXPos=0.005;
btnYPos=0.03;
btnWidth=0.194;
btnHeight=0.93;


h0=figure('MenuBar','none','ToolBar','none','Units','normalized','Position',[winXPos winYPos winWidth winHeight], ...
	'Resize','off','NumberTitle','off','Name','Chaotic generators demo');

drawnow

%Toggle : Attractor
[X,map]=imread([imgpath 'att.bmp']);
RGB=ind2rgb(X,map);
uicontrol('Parent',h0,'Style','PushButton','Units','normalized', ...
	'Position',[btnXPos btnYPos btnWidth btnHeight], ...
	'TooltipString','2D Attractor','CData',RGB, ...
	'Callback','attractor')

drawnow

%Toggle : TimeFreq
[X,map]=imread([imgpath 'TF.bmp']);
RGB=ind2rgb(X,map);
uicontrol('Parent',h0,'Style','PushButton','Units','normalized', ...
	'Position',[2*btnXPos+btnWidth btnYPos btnWidth btnHeight], ...
	'TooltipString','Time/Frequency Domain','CData',RGB, ...
	'Callback','timefreq')

drawnow

%Toggle : Bifurcation
[X,map]=imread([imgpath 'Bif.bmp']);
RGB=ind2rgb(X,map);
uicontrol('Parent',h0,'Style','PushButton','Units','normalized', ...
	'Position',[3*btnXPos+2*btnWidth btnYPos btnWidth btnHeight], ...
	'TooltipString','Bifurcation Diagram','CData',RGB, ...
	'Callback','bifurcation')

drawnow

%Toggle : Histogram
[X,map]=imread([imgpath 'Hist.bmp']);
RGB=ind2rgb(X,map);
uicontrol('Parent',h0,'Style','PushButton','Units','normalized', ...
	'Position',[4*btnXPos+3*btnWidth btnYPos btnWidth btnHeight], ...
	'TooltipString','Histogram','CData',RGB, ...
	'Callback','histogram')

drawnow

%Toggle : Bicoherence
[X,map]=imread([imgpath 'Bic.bmp']);
RGB=ind2rgb(X,map);
uicontrol('Parent',h0,'Style','PushButton','Units','normalized', ...
	'Position',[5*btnXPos+4*btnWidth btnYPos btnWidth btnHeight], ...
	'TooltipString','Bicoherence','CData',RGB, ...
	'Callback','bicoherence')
