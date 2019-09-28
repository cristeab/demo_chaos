function structData=LyapInit(fcname)
%initialization function for Lyapunov exponent(s) plotting

structData.ParRg=[];
structData.Step=[];
structData.DiscardItr=[];
structData.MaxItr=[];
structData.Tol=[];
structData.SampFreq=[];
structData.InitCond=[];

switch lower(fcname)
	%Discr
case 'l_henonmap',
	structData.ParRg=[0 1.4];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=[0.1 0];
case 'l_logisticmap',
	structData.ParRg=[2.8 4];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case 'l_logisticmap1',
	structData.ParRg=[1.8 4];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case 'l_logisticmap2',
	structData.ParRg=[2.4 4];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case 'l_logisticmap3',
	structData.ParRg=[1.6 4];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case {'l_pwammap1','l_pwammap2','l_pwammap3'},
	structData.ParRg=[0.8 3];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case 'l_pwammap4',
	structData.ParRg=[0.7 2.1];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case 'l_tentmap',
	structData.ParRg=[0.4 0.99];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case 'l_tentmap1',
	structData.ParRg=[0.9 3];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case 'l_tentmap2',
	structData.ParRg=[0.9 3.99];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case 'l_tailedtentmap',
	structData.ParRg=[0 1];
	structData.Step=500;
	structData.DiscardItr=100;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
case 'l_miramap',
	structData.ParRg=[0.9 1.2];
	structData.Step=500;
	structData.DiscardItr=500;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=[0.1 0];
case 'l_bernoullimap',
	structData.ParRg=[0.9 1.99];
	structData.Step=500;
	structData.DiscardItr=500;
	structData.MaxItr=1000;
	structData.Tol=[1e-3 1e-6];
	structData.SampFreq=1;
	structData.InitCond=0.1;
otherwise
	warndlg(['The "' fcname '.m"' ' file has no default parameters.'],'Warning');
end


	



	



	
	



