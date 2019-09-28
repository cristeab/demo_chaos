function structData=AttInit(fcname)
%initialization function for 2D attractor plotting

structData.SelVar=[];
structData.InitCond=[];
structData.ParamVal=[];
structData.TimeRange=[];

switch lower(fcname)
	%Cont
case 'autonomous4dcirc',
	structData.SelVar=[1 2];
	structData.InitCond=[0.1 0 0 0];
	structData.ParamVal=0.17;
	structData.TimeRange=[0 1e6];
case 'chuacirc',
	structData.SelVar=[1 2];
	structData.InitCond=[1 0.2 0];
	structData.ParamVal=10;
	structData.TimeRange=[0 1e6];
case 'chuacirccn',
	structData.SelVar=[1 2];
	structData.InitCond=[1 0.2 0];
	structData.ParamVal=8.85;
	structData.TimeRange=[0 1e6];
case 'colpittsosc',
	structData.SelVar=[1 2];
	structData.InitCond=[0.1 0 0];
	structData.ParamVal=0.25;
	structData.TimeRange=[0 1e6];
case 'fautonomous4dcirc',
	structData.SelVar=[1 2];
	structData.InitCond=[0.1 0 0 0];
	structData.ParamVal=[];
	structData.TimeRange=[0 1e6];
case 'fchuacirc',
	structData.SelVar=[1 2];
	structData.InitCond=[1 0.2 0];
	structData.ParamVal=[];
	structData.TimeRange=[0 1e6];
case {'fcolpittsosc','frc_colpitts'},
	structData.SelVar=[1 2];
	structData.InitCond=[0.1 0 0];
	structData.ParamVal=[];
	structData.TimeRange=[0 1e6];
case {'frayleighosc','fsimplechaoticcirc'},
	structData.SelVar=[1 2];
	structData.InitCond=[0.1 0];
	structData.ParamVal=[];
	structData.TimeRange=[0 1e6];
case 'frc_hysteresis',
	global m_hystState
	m_hystState=1e-3;
	structData.SelVar=[1 2];
	structData.InitCond=[0 0];
	structData.ParamVal=[];
	structData.TimeRange=[0 1e6];
case 'frc_nonlincirc',
	structData.SelVar=[1 2];
	structData.InitCond=[3e-3 0 -1e-3];
	structData.ParamVal=[];
	structData.TimeRange=[0 1e6];
case 'rayleighosc',
	structData.SelVar=[1 2];
	structData.InitCond=[0.1 0];
	structData.ParamVal=0.5;
	structData.TimeRange=[0 1e6];
case 'rc_colpitts',
	structData.SelVar=[1 2];
	structData.InitCond=[0 0.5 1.5];
	structData.ParamVal=2;
	structData.TimeRange=[0 1e6];
case 'rc_hysteresis',
	global m_hystState
	m_hystState=1;
	structData.SelVar=[1 2];
	structData.InitCond=[0 0];
	structData.ParamVal=0.01;
	structData.TimeRange=[0 1e6];
case 'rc_nonlincirc',
	structData.SelVar=[1 2];
	structData.InitCond=[3 0 -1];
	structData.ParamVal=250;
	structData.TimeRange=[0 1e6];
case 'simplechaoticcirc',
	structData.SelVar=[1 2];
	structData.InitCond=[0.1 0];
	structData.ParamVal=0.25;
	structData.TimeRange=[0 1e6];
case 'lorenz'
	structData.SelVar=[1 2];
	structData.InitCond=[0.1 0 0];
	structData.ParamVal=10;
	structData.TimeRange=[0 1e6];	
	
	%Discr
case 'genhaos',
	structData.SelVar=0;%stands for plotting style
	structData.InitCond=[0.1 0 0];
	structData.ParamVal=2;
	structData.TimeRange=1e6;%stands for iterations
case 'henonmap',
	structData.SelVar=0;%stands for plotting style
	structData.InitCond=[0.1 0];
	structData.ParamVal=1.4;
	structData.TimeRange=1e6;%stands for iterations
case {'logisticmap','logisticmap1','logisticmap2','logisticmap3'},
	structData.SelVar=1;%stands for plotting style
	structData.InitCond=0.1;
	structData.ParamVal=4;
	structData.TimeRange=1e6;%stands for iterations
case {'pwammap1','pwammap2','pwammap3'},
	structData.SelVar=1;%stands for plotting style
	structData.InitCond=0.1;
	structData.ParamVal=3;
	structData.TimeRange=1e6;%stands for iterations
case 'pwammap4',
	structData.SelVar=1;%stands for plotting style
	structData.InitCond=0.1;
	structData.ParamVal=2.1;
	structData.TimeRange=1e6;%stands for iterations
case 'tentmap',
	structData.SelVar=1;%stands for plotting style
	structData.InitCond=0.1;
	structData.ParamVal=0.99;
	structData.TimeRange=1e6;%stands for iterations
case 'tentmap1',
	structData.SelVar=1;%stands for plotting style
	structData.InitCond=0.1;
	structData.ParamVal=3;
	structData.TimeRange=1e6;%stands for iterations
case 'tentmap2',
	structData.SelVar=1;%stands for plotting style
	structData.InitCond=0.1;
	structData.ParamVal=3.99;
	structData.TimeRange=1e6;%stands for iterations
case 'tailedtentmap',
	structData.SelVar=1;%stands for plotting style
	structData.InitCond=0.1;
	structData.ParamVal=0.1;
	structData.TimeRange=1e6;%stands for iterations
case 'miramap',
	structData.SelVar=0;%stands for plotting style
	structData.InitCond=[6 0];
	structData.ParamVal=1.05;
	structData.TimeRange=1e6;%stands for iterations
case 'bernoullimap',
	structData.SelVar=1;%stands for plotting style
	structData.InitCond=0.1;
	structData.ParamVal=1.99;
	structData.TimeRange=1e6;%stands for iterations
otherwise
	warndlg(['The "' fcname '.m"' ' file has no default parameters.'],'Warning');
end


	



	



	
	



