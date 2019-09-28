function fx=tentmap1(x,rParam)
%rParam=3

if (0<=x) & (x<1/3)
	fx=rParam*x;
elseif (1/3<=x) & (x<2/3)
	fx=rParam*(2/3-x);
else
	fx=rParam*(-2/3+x);
end