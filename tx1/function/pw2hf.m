function [ Hk, f, tau ] = pw2hf( al, toa, fc, bw, Nf )
%PW2HT: [ Hk, f,tau ] = pw2hf( al, toa, fc, bw, Nf )
% Generating transfer function and impulse response according to plane
% wave.
% 
% Input:
% al: Complex amplitude of plane wave (rays x antenna elements)
% toa: time of arrival (rays x antenna elements)
% -------------------------------------------------------
% output:
% Hk - Transfer function
% f - frequency range
% Ht - Complex impulse response
% tau - time delay for impulse response
% -------------------------------------------------------
%

% Parameter initialization
% fc=15e9;    % Carrier frequency
% bw=1e9; % Bandwidth
% Nf=801; % Number of frequency bins
ft=bw/(Nf-1);   % Frequency spacing between two bins
f=fc-bw/2:ft:fc+bw/2;   % Frequency range
tau=0:1/bw:1/ft;
k=0:1:Nf-1; % Bin number range
[~,txN]=size(al);
if length(toa(:))~=length(al(:))
    toa=toa(:);
    toa=repmat(toa,1,txN);
end
Hk=zeros(Nf,txN);
% Inputs are all column vectors
for m=1:txN
    cir=al(:,m);
    t=toa(:,m);
    e=exp(-1j*2*pi*ft.*t);
    et=bsxfun(@power, e,k); % Fourier matrix
    Hk(:,m)=et.'*cir;
end

% Ht=ifft(Hk);

end

