function fx=logisticmap(x,rParam)
%implementation of logistic map
%rParam=4 for chaos

fx=rParam*x.*(1-x);
