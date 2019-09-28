function fx=PWAMmap4(x,rParam)
%rParam=2.1 for chaos
%x0=0.4

%parameters
B=rParam;
D=1;

if abs(x)<=D
   fx=-B*x+B*D*sign(x);
else
   fx=B*x-2*B*D*sign(x);
end

