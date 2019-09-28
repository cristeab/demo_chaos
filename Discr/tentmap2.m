function fx=tentmap2(x,rParam)
%rParam=3.99

if (0<=x) & (x<1/4)
	fx=rParam*x;
elseif (1/4<=x) & (x<1/2)
	fx=sqrt(rParam)*(1-(2*x));
elseif (1/2<=x) & (x<3/4)
	fx=sqrt(rParam)*((2*x)-1);
else
	fx=rParam*(1-x);
end