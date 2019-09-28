function fx=PWAMmap3(x,rParam)
%rParam=2.1...3 for chaos (see rParam=3)
%x0=0.4

%parameters
B=rParam;
D=1;

if abs(x)<=D
   fx=-B*x;
else
   fx=B*(x-2*D*sign(x));
end

   