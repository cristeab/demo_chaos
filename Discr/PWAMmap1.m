function fx=PWAMmap1(x,rParam)
%rParam=1.5...3 for chaos (see rParam=3)
%x0=0.4

%parameters
B=rParam;
D=1;

if abs(x)<=D
   fx=B*(D-abs(x));
else
   fx=B*(abs(x)-2*D);
end
