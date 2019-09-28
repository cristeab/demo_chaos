function lambda=findLyap(fcname,T,x,options,rParam)
%x must be a row vector
%options=[GT,Er,Ea,kmax]

GT=options(1);%generator type
Er=options(2);%relative error
Ea=options(3);%absolute error
kmax=options(4);%maximal number of iterations
n=length(x);%number of Lyapunov exponent(s)
lambda=zeros(1,n);%Lyapunov exponent(s)
u=eye(n);
bidon=zeros(1,n);
IC=[x';u(:)];%initial conditions to compute x and Jacobian simultaniously
%MAIN LOOP
for k=1:kmax
	lambda_old=lambda;
	%begin of integration process
	if GT==1 %Cont
		IC=feval(fcname,IC,rParam);
	elseif GT==2 %Discr (by default T=1)
		IC=feval(fcname,IC,rParam);
	end
	%end of integration process
	x=IC(1:n);
	dx=reshape(IC(n+1:end),n,n)*u;
	for i=1:n
		v(:,i)=dx(:,i);
		for j=1:(i-1)
			v(:,i)=v(:,i)-sum(v(:,i).*u(:,j))*u(:,j);
		end
		u(:,i)=v(:,i)/norm(v(:,i));
		bidon(i)=bidon(i)+log(norm(v(:,i)));
		lambda(i)=bidon(i)/(k*T);
	end
	if norm(lambda_old-lambda)<Er*norm(lambda)+Ea, break; end
end
%END MAIN LOOP
