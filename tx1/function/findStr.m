function [ outdata ] = findStr( array, hf, dir, fc, Nb)
% [ outdata ] = findStr( array, hf, dir, fc, Nb)
%STEERVEC Calculating steering phase shift for antenna array
%
%   Input:
%   array - antenna allocation
%   hf - channel transfer function e.g. 32x801
%   al - Complex Impulse response with array pattern( rays x Tx number )
%   dir - steering direction in degree [phi theta]
%   fc - carrier frequence for calculating spacing
%   Nb - number of beams
%
%   Output:
%   outdata - antenna steering phase shift
c=3e8;  % Light speed
lambda=c/fc; % wavelength
d=zeros(array);
phi=degtorad(dir(:,1));
theta=degtorad(dir(:,2));
phi=phi(:).';
theta=theta(:).';
an=prod(array);
hf=hf.';

[x, y, z]=ind2sub(size(d),find(d==0));
x=x(:);
y=y(:);
z=z(:);
dt=[(x-1) (y-1) (z-1)]*lambda/2;
dx=dt(:,1);
dy=dt(:,2);
dz=dt(:,3);
% Make sure dx dy dz are column vectors here
dx=dx(:);
dy=dy(:);
dz=dz(:);

% Find tau peak
% bw=1e9; % System bandwidth
bw=800e6;
Nf=801;
ft=bw/(Nf-1);   % Frequency spacing between two bins
f=fc-bw/2:ft:fc+bw/2;   % Frequency range
tau=0:1/bw:1/ft;    % Calculating delay
ht=ifft(hf);    % 801x32
% size(hf)
pdp=squeeze(sum(abs(ht).^2,2)); % 801x1
[~, ind_mx]=max(pdp(:)); % 801x1
tau_p=tau(ind_mx);

% Steering vector
bn=exp(-1j*2*pi*dx*(sin(theta).*cos(phi))/lambda).*exp(-1j*2*pi*dy*(sin(theta).*sin(phi))/lambda).*exp(-1j*2*pi*dz*cos(theta)/lambda);
% size(bn)
% Find the largest received power, hf 801x32, bn 32x16500
wf=norm(bn, 'fro');
alste=abs(exp(-1j*2*pi.*f(:).*tau_p(:)).'*(hf*bn./wf)); % 1x801 801x32 32x16500 = 1x16500
powste=mag2db(abs(alste));
powste=powste(:).';
tn=[bn; powste].'; % 16500x33
tn=sortrows(tn,an+1);
% tn=tn(1:Nb,:);
tn(:,end)=[]; % 16500x32
if Nb~=1
    hf_t=hf(round(Nf/2), :);    % 1x32
%     size(hf_t)
    len=length(tn);
    pn=tn.*repmat(hf_t, len, 1); % 16500x32
    pn_co=corrcoef(pn.'); % 16500x16500
    ind=1;
    for w1=1:Nb
        pin(w1)=ind;
        id=find(abs(pn_co(ind:end,ind))<0.5)+ind-1;
        if isempty(id)
            ind=pin(max(1,w1-1));
        else
            ind=id(1);
        end
    end
    outdata=tn(pin,:); % Nbx32
else
    outdata=tn(1,:); % 1x32
end

end

