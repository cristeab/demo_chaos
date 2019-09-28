function structData=BicInit(fcname)
%initialization function for bicoherence plotting

structData.ParamVal=[];
structData.Fsamp=[];
structData.SelVar=[];
structData.TimeRange=[];
structData.InitCond=[];

switch lower(fcname)
	%Cont
case 'autonomous4dcirc',
	structData.ParamVal=0.17;
	structData.Fsamp=1.5;
	structData.SelVar=1;
	structData.TimeRange=[0 400];
	structData.InitCond=[0.1 0 0 0];
case 'chuacirc',
	structData.ParamVal=10;
	structData.Fsamp=2.5;
	structData.SelVar=1;
	structData.TimeRange=[0 250];
	structData.InitCond=[1 0.2 0];
case 'chuacirccn',
	structData.ParamVal=8.85;
	structData.Fsamp=2.5;
	structData.SelVar=1;
	structData.TimeRange=[0 250];
	structData.InitCond=[1 0.2 0];
case 'colpittsosc',
	structData.ParamVal=0.35;
	structData.Fsamp=10;
	structData.SelVar=1;
	structData.TimeRange=[0 100];
	structData.InitCond=[0.1 0 0];
case 'fautonomous4dcirc',
	structData.ParamVal=[];
	structData.Fsamp=1e6;
	structData.SelVar=1;
	structData.TimeRange=[0 0.6e-3];
	structData.InitCond=[0.1 0 0 0];
case 'fchuacirc',
	structData.ParamVal=[];
	structData.Fsamp=20e6;
	structData.SelVar=1;
	structData.TimeRange=[0 3e-5];
	structData.InitCond=[1 0.2 0];
case 'fcolpittsosc',
	structData.ParamVal=[];
	structData.Fsamp=1e6;
	structData.SelVar=1;
	structData.TimeRange=[0 2e-3];
	structData.InitCond=[0.1 0 0];
case 'frayleighosc',
	structData.ParamVal=[];
	structData.Fsamp=0.2e6;
	structData.SelVar=1;
	structData.TimeRange=[0 6e-3];
	structData.InitCond=[0.1 0];
case 'frc_colpitts',
	structData.ParamVal=[];
	structData.Fsamp=10e6;
	structData.SelVar=1;
	structData.TimeRange=[0 50e-6];
	structData.InitCond=[0.1 0 0];
case 'frc_hysteresis',
	global m_hystState
	m_hystState=1e-3;
	structData.ParamVal=[];
	structData.Fsamp=1e6;
	structData.SelVar=1;
	structData.TimeRange=[0 5e-4];
	structData.InitCond=[0.1 0];
case 'frc_nonlincirc',
	structData.ParamVal=[];
	structData.Fsamp=5e6;
	structData.SelVar=1;
	structData.TimeRange=[0 0.05e-3];
	structData.InitCond=[3e-3 0 -1e-3];
case 'fsimplechaoticcirc',
	structData.ParamVal=[];
	structData.Fsamp=50e6;
	structData.SelVar=1;
	structData.TimeRange=[0 10e-6];
	structData.InitCond=[0.1 0];
case 'rayleighosc',
	structData.ParamVal=2;
	structData.Fsamp=4;
	structData.SelVar=1;
	structData.TimeRange=[0 200];
	structData.InitCond=[0.1 0];
case 'rc_colpitts',
	structData.ParamVal=2;
	structData.Fsamp=4;
	structData.SelVar=1;
	structData.TimeRange=[0 150];
	structData.InitCond=[0 0.5 1.5];
case 'rc_hysteresis',
	global m_hystState
	m_hystState=1;
	structData.ParamVal=0.01;
	structData.Fsamp=1;
	structData.SelVar=1;
	structData.TimeRange=[0 500];
	structData.InitCond=[0.1 0];
case 'rc_nonlincirc',
	structData.ParamVal=250;
	structData.Fsamp=2.5;
	structData.SelVar=1;
	structData.TimeRange=[0 200];
	structData.InitCond=[3 0 -1];
case 'simplechaoticcirc',
	structData.ParamVal=0.25;
	structData.Fsamp=0.5;
	structData.SelVar=1;
	structData.TimeRange=[0 1e3];
	structData.InitCond=[0.1 0];
case 'lorenz'
	structData.ParamVal=10;
	structData.Fsamp=5;
	structData.SelVar=1;
	structData.TimeRange=[0 150];
	structData.InitCond=[0.1 0 0];
otherwise
	warndlg(['The "' fcname '.m"' ' file has no default parameters.'],'Warning');
end


	



	



	
	



