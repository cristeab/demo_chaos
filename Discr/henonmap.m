function fx=henonmap(x,rParam)

%parameters
alpha=rParam;%1.4
beta=0.3;

fx=zeros(1,2);

fx(1)=1-alpha*x(1)^2+x(2);
fx(2)=beta*x(1);

