function structData=BifInit(fcname)
%initialization function for bifurcation plotting

structData.ParamRg=[];
structData.NbPts=[];
structData.TimeRange=[];
structData.SelVar=[];
structData.InitCond=[];

switch lower(fcname)
	%Discr
case 'genhaos',
	structData.ParamRg=[0 2];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=[0.1 0 0];
case 'henonmap',
	structData.ParamRg=[0 1.4];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=[0.1 0];
case 'logisticmap',
	structData.ParamRg=[2.8 4];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case 'logisticmap1',
	structData.ParamRg=[1.8 4];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case 'logisticmap2',
	structData.ParamRg=[2.4 4];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case 'logisticmap3',
	structData.ParamRg=[1.6 4];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case {'pwammap1','pwammap2','pwammap3'},
	structData.ParamRg=[0.8 3];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case 'pwammap4',
	structData.ParamRg=[0.7 2.1];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case 'tentmap',
	structData.ParamRg=[0.4 0.99];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case 'tentmap1',
	structData.ParamRg=[0.9 3];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case 'tentmap2',
	structData.ParamRg=[0.9 3.99];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case 'tailedtentmap',
	structData.ParamRg=[0 1];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
case 'miramap',
	structData.ParamRg=[0.9 1.2];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=[6 0];
case 'bernoullimap',
	structData.ParamRg=[0.9 1.99];
	structData.NbPts=500;
	structData.TimeRange=[500 1000];
	structData.SelVar=1;
	structData.InitCond=0.1;
otherwise
	warndlg(['The "' fcname '.m"' ' file has no default parameters.'],'Warning');
end


	



	



	
	



