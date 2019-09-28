function fx=miramap(x,rParam)

%parameters
a=rParam;%1.05
lambda=2;

fx=zeros(1,2);

fx(1)=x(2);
if x(1)<6
	fx(2)=x(2)-a*x(1);
else
	fx(2)=x(2)+lambda*x(1)-6*(a+lambda);
end