function structData=HistInit(fcname)
%initialization function for 2D attractor plotting

structData.Nbins=[];
structData.ParamVal=[];
structData.TimeRange=[];
structData.InitCond=[];
structData.SelVar=[];

switch lower(fcname)
	%Discr
case 'genhaos',
	structData.Nbins=100;
	structData.ParamVal=2;
	structData.TimeRange=[1 1e4];
	structData.InitCond=[0.1 0 0];
	structData.SelVar=1;
case 'henonmap',
	structData.Nbins=100;
	structData.ParamVal=1.4;
	structData.TimeRange=[1 1e4];
	structData.InitCond=[0.1 0];
	structData.SelVar=1;
case {'logisticmap','logisticmap1','logisticmap2','logisticmap3'},
	structData.Nbins=100;
	structData.ParamVal=4;
	structData.TimeRange=[1 1e4];
	structData.InitCond=0.1;
	structData.SelVar=1;
case {'pwammap1','pwammap2','pwammap3'},
	structData.Nbins=100;
	structData.ParamVal=3;
	structData.TimeRange=[1 1e4];
	structData.InitCond=0.1;
	structData.SelVar=1;
case 'pwammap4',
	structData.Nbins=100;
	structData.ParamVal=2.1;
	structData.TimeRange=[1 1e4];
	structData.InitCond=0.1;
	structData.SelVar=1;
case 'tentmap',
	structData.Nbins=100;
	structData.ParamVal=0.99;
	structData.TimeRange=[1 1e4];
	structData.InitCond=0.1;
	structData.SelVar=1;
case 'tentmap1',
	structData.Nbins=100;
	structData.ParamVal=3;
	structData.TimeRange=[1 1e4];
	structData.InitCond=0.1;
	structData.SelVar=1;
case 'tentmap2',
	structData.Nbins=100;
	structData.ParamVal=3.99;
	structData.TimeRange=[1 1e4];
	structData.InitCond=0.1;
	structData.SelVar=1;
case 'tailedtentmap',
	structData.Nbins=100;
	structData.ParamVal=0.1;
	structData.TimeRange=[1 1e4];
	structData.InitCond=0.1;
	structData.SelVar=1;
case 'miramap',
	structData.Nbins=100;
	structData.ParamVal=1.05;
	structData.TimeRange=[1 1e4];
	structData.InitCond=[6 0];
	structData.SelVar=1;
case 'bernoullimap',
	structData.Nbins=100;
	structData.ParamVal=1.99;
    structData.TimeRange=[1 1e4];
	structData.InitCond=0.1;
    structData.SelVar=1;
otherwise
	warndlg(['The "' fcname '.m"' ' file has no default parameters.'],'Warning');
end


	



	



	
	



