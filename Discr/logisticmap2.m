function fx=logisticmap2(x,rParam)
%rParam=4 for chaos

fx=rParam*x*(0.75-(x^2));
