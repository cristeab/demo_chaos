function structData=TFInit(fcname)
%initialization function for Time/Frequency plotting

structData.ParamVal=[];
structData.fsamp=[];
structData.SelVar=[];
structData.TimeRange=[];
structData.IntRange=[];
structData.InitCond=[];

switch lower(fcname)
	%Cont
case 'autonomous4dcirc',
	structData.ParamVal=0.27;
	structData.fsamp=1.5;
	structData.SelVar=1;
	structData.TimeRange=[0 200];
	structData.IntRange=[0 400];
	structData.InitCond=[0.1 0 0 0];
case 'chuacirc',
	structData.ParamVal=10;
	structData.fsamp=1.5;
	structData.SelVar=1;
	structData.TimeRange=[0 200];
	structData.IntRange=[0 400];
	structData.InitCond=[1 0.2 0];
case 'chuacirccn',
	structData.ParamVal=8.85;
	structData.fsamp=1.5;
	structData.SelVar=1;
	structData.TimeRange=[0 200];
	structData.IntRange=[0 400];
	structData.InitCond=[1 0.2 0];
case 'colpittsosc',
	structData.ParamVal=0.25;
	structData.fsamp=10;
	structData.SelVar=1;
	structData.TimeRange=[0 25];
	structData.IntRange=[0 50];
	structData.InitCond=[0.1 0 0];
case 'fautonomous4dcirc',
	structData.ParamVal=[];
	structData.fsamp=2e6;
	structData.SelVar=1;
	structData.TimeRange=[0 0.3e-3];
	structData.IntRange=[0 0.6e-3];
	structData.InitCond=[0.1 0 0 0];
case 'fchuacirc',
	structData.ParamVal=[];
	structData.fsamp=30e6;
	structData.SelVar=1;
	structData.TimeRange=[0 5e-6];
	structData.IntRange=[0 10e-6];
	structData.InitCond=[1 0.2 0];
case 'fcolpittsosc',
	structData.ParamVal=[];
	structData.fsamp=0.5e6;
	structData.SelVar=1;
	structData.TimeRange=[0 0.5e-3];
	structData.IntRange=[0 1e-3];
	structData.InitCond=[0.1 0 0];
case 'frayleighosc',
	structData.ParamVal=[];
	structData.fsamp=0.2e6;
	structData.SelVar=1;
	structData.TimeRange=[0 0.5e-3];
	structData.IntRange=[0 1e-3];
	structData.InitCond=[0.1 0];
case 'frc_colpitts',
	structData.ParamVal=[];
	structData.fsamp=20e6;
	structData.SelVar=1;
	structData.TimeRange=[0 25e-6];
	structData.IntRange=[0 50e-6];
	structData.InitCond=[0.1 0 0];
case 'frc_hysteresis',
	global m_hystState
	m_hystState=1e-3;
	structData.ParamVal=[];
	structData.fsamp=1e6;
	structData.SelVar=1;
	structData.TimeRange=[0 0.3e-3];
	structData.IntRange=[0 0.6e-3];
	structData.InitCond=[0 0];
case 'frc_nonlincirc',
	structData.ParamVal=[];
	structData.fsamp=5e6;
	structData.SelVar=1;
	structData.TimeRange=[0 0.05e-3];
	structData.IntRange=[0 0.1e-3];
	structData.InitCond=[3e-3 0 -1e-3];
case 'fsimplechaoticcirc',
	structData.ParamVal=[];
	structData.fsamp=50e6;
	structData.SelVar=1;
	structData.TimeRange=[0 25e-6];
	structData.IntRange=[0 5e-6];
	structData.InitCond=[0.1 0];
case 'rayleighosc',
	structData.ParamVal=0.5;
	structData.fsamp=4;
	structData.SelVar=1;
	structData.TimeRange=[0 75];
	structData.IntRange=[0 150];
	structData.InitCond=[0.1 0];
case 'rc_colpitts',
	structData.ParamVal=2;
	structData.fsamp=4;
	structData.SelVar=1;
	structData.TimeRange=[0 100];
	structData.IntRange=[0 300];
	structData.InitCond=[0 0.5 1.5];
case 'rc_hysteresis',
	global m_hystState
	m_hystState=1;
	structData.ParamVal=0.01;
	structData.fsamp=4;
	structData.SelVar=1;
	structData.TimeRange=[0 75];
	structData.IntRange=[0 150];
	structData.InitCond=[0 0];
case 'rc_nonlincirc',
	structData.ParamVal=250;
	structData.fsamp=2.5;
	structData.SelVar=1;
	structData.TimeRange=[0 75];
	structData.IntRange=[0 150];
	structData.InitCond=[3 0 -1];
case 'simplechaoticcirc',
	structData.ParamVal=0.25;
	structData.fsamp=0.5;
	structData.SelVar=1;
	structData.TimeRange=[0 250];
	structData.IntRange=[0 500];
	structData.InitCond=[0.1 0];
case 'lorenz'
	structData.ParamVal=10;
	structData.fsamp=20;
	structData.SelVar=1;
	structData.TimeRange=[0 100];
	structData.IntRange=[0 300];
	structData.InitCond=[0.1 0 0];
	
	%Discr
case 'genhaos',
	structData.ParamVal=2;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=[0.1 0 0];
case 'henonmap',
	structData.ParamVal=1.4;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=[0.1 0];
case {'logisticmap','logisticmap1','logisticmap2','logisticmap3'},
	structData.ParamVal=4;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=0.1;
case {'pwammap1','pwammap2','pwammap3'},
	structData.ParamVal=3;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=0.1;
case 'pwammap4',
	structData.ParamVal=2.1;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=0.1;
case 'tentmap',
	structData.ParamVal=0.99;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=0.1;
case 'tentmap1',
	structData.ParamVal=3;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=0.1;
case 'tentmap2',
	structData.ParamVal=3.99;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=0.1;
case 'tailedtentmap',
	structData.ParamVal=0.1;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=0.1;
case 'miramap',
	structData.ParamVal=1.05;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=[6 0];	
case 'bernoullimap',
	structData.ParamVal=1.99;
	structData.fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[1 100];
	structData.IntRange=[1 1000];
	structData.InitCond=0.1;	
otherwise
	warndlg(['The "' fcname '.m"' ' file has no default parameters.'],'Warning');
end
