function fx=genhaos(x,rParam)
%chaos generator with a recursive structure
%y0=[0.1 0 0]

%parameters
c1=rParam;%2
c2=1;
c3=1;

%initialization
fx=zeros(1,3);

%DDE
bidon=c1*x(1)+c2*x(2)+c3*x(3);
fx(1)=bidon-2*floor((bidon+1)/2);
fx(2)=x(1);
fx(3)=x(2);