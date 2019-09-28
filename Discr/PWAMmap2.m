function fx=PWAMmap2(x,rParam)
%rParam=3 for chaos
%x0=0.4

%parameters
B=rParam;
D=1;

if abs(x)<=D
   fx=-B*abs(x);
else
   fx=-B*(abs(x)-2*D);
end


