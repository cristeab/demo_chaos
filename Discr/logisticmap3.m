function fx=logisticmap3(x,rParam)
%rParam=4 for chaos

fx=rParam*x*(1.25-(5*(x^2))+(4*(x^4)));
