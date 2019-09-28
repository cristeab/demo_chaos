function [T,Y] = m_dreTF(drefun,vTimeRange,bidon_y0,rParam)
%discrete recursive ecuation solver for time/frequency plotting (y[n]=drefun(y[n-1]))

%ensure that y0 is a row vector
y0=zeros(1,length(bidon_y0));
y0(:)=bidon_y0(:);

discard=vTimeRange(1)-1;
nbiter=vTimeRange(2)-discard;
T=zeros(nbiter,1);
Y=zeros(nbiter,length(y0));
Y_bidon=zeros(2,length(y0));
Y_bidon(1,:)=y0;

%discard values
for n=1:discard
	Y_bidon(2,:)=feval(drefun,Y_bidon(1,:),rParam);
	Y_bidon(1,:)=Y_bidon(2,:);
end
%compute output
T(1)=1+discard;
Y(1,:)=Y_bidon(1,:);
for n=2:nbiter
	T(n)=n+discard;
	Y(n,:)=feval(drefun,Y(n-1,:),rParam);
end