function fx=logisticmap1(x,rParam)
%rParam=4 for chaos

fx=(rParam^2)*x.*(1-x)*((1-2*x)^2);
