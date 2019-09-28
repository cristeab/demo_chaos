function [waxis,Pyy]=m_powerspec(y,nfft,wind,nsamp,overlap)
%estimates the power spectrum with the same method as in bicoherence

%parameter checks
[ly, nrecs] = size(y);
if (ly == 1) y = y(:);  ly = nrecs; nrecs = 1; end
if (exist('nfft') ~= 1)            nfft = 128; end
if (exist('overlap') ~= 1)      overlap = 50;  end
overlap = max(0,min(overlap,99));
if (nrecs > 1)                  overlap = 0;   end
if (exist('nsamp') ~= 1)          nsamp = 0;  end
if (nrecs > 1)                    nsamp = ly;  end
if (nrecs == 1 & nsamp <= 0)
	nsamp = fix(ly/ (8 - 7 * overlap/100));
end
if (nfft  < nsamp)   nfft = 2^nextpow2(nsamp); end
overlap  = fix( nsamp * overlap/100);
nadvance = nsamp - overlap;
nrecs    = fix ( (ly*nrecs - overlap) / nadvance);
if (exist('wind') ~= 1) wind = hanning(nsamp); end
[rw,cw] = size(wind);
if (min(rw,cw) ~= 1 | max(rw,cw) ~= nsamp)
	disp(['Segment size  is ',int2str(nsamp)])
	disp(['"wind" array  is ',int2str(rw),' by ',int2str(cw)])
	disp(['Using default Hanning window'])
	wind = hanning(nsamp);
end
wind = wind(:);

%accumulate products
Pyy  = zeros(nfft,1);
ind  = [1:nsamp];

for k = 1:nrecs
	ys = y(ind);
 ys = (ys(:)).*wind;
 %ys = (ys(:)-mean(ys(:))).*wind;
	Yf = fft(ys,nfft)/nsamp;
 CYf = conj(Yf);
	Pyy = Pyy + Yf.*CYf;
 ind = ind + nadvance;
end

Pyy = Pyy/nrecs;
Pyy = fftshift(Pyy);

if (rem(nfft,2) == 0)
	waxis = [-nfft/2:(nfft/2-1)]'/nfft;
else
	waxis = [-(nfft-1)/2:(nfft-1)/2]'/nfft;
end

