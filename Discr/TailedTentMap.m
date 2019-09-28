function fx=TailedTentMap(x,rParam)
%rParam=0.1, controls tail size

fx=1-2*abs(x-((1-rParam)/2))+max(x-1+rParam,0);
