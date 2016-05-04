% Calculating Spatial multiplexing capacity outdoor 15 GHz Tx1
% This file should be run under the files directions
% MIMO case: tx - 8x4  rx - 1x8
clc;clear all; close all;
tic
load rayAm
load doa doa
load dod
strSave=mfilename('fullpath')
op=1;
ed=2;
%%
prx=al(:,:,op:ed);
doa_phi=doa(:,1,op:ed); % degree
doa_theta=doa(:,2,op:ed); % degree
dod_phi=dod(:,1,op:ed); % degree
dod_theta=dod(:,2,op:ed); % degree
phase=phase(:,:,op:ed);
al_lin=db2mag(prx).*exp(1j*2*pi*degtorad(phase));    % Plane wave
% al_lin(10:end,:,:)=0;
% Initialized parameters
fc=15e9;
bw=1e9; % System bandwidth
Nf=801;
ft=bw/(Nf-1);   % Frequency spacing between two bins
% f=fc-bw/2:ft:fc+bw/2;   % Frequency range
tau=0:1/bw:1/ft;    % Calculating delay
[rayN, ~, rxN]=size(prx);
B=bw/(Nf-1);    % Frequency bins bandwidth
Ptx=-30;    % Transmitting power 0dBm=-30dBw
k=1.381*10e-23;
T=290;
No=k*T; % Noise level

% Applying 8x4 array phase shift on Tx side
array_tx=[4 1 8];   % 8x4 XZ plane
array_rx=[8 1 1];   % 8x1 Linear X
elem_tx=prod(array_tx);
elem_rx=prod(array_rx);
dir_tx=[dod_phi dod_theta];
dir_rx=[doa_phi doa_theta];
hf=zeros(Nf,elem_tx*elem_rx,rxN);
for w=1:rxN
%     w
    % Phase shift of antenna array
    ant_tx=psht(array_tx, dir_tx(:,:,w), fc, false); % 200x32
    ant_tx=reshape(ant_tx.', 1, elem_tx, rayN); % 1x32x200
    ant_rx=psht(array_rx, dir_rx(:,:,w), fc, false); % 200x8
    ant_rx=reshape(ant_rx.', elem_rx, 1, rayN); % 8x1x200
    % Applying antenna pattern on plane wave
    tx=repmat(ant_tx, elem_rx, 1, 1); % 8x32x200
    rx=repmat(ant_rx, 1, elem_tx, 1); % 8x32x200
    ant=reshape(tx.*rx, [],rayN); % 256x200
    am=bsxfun(@times, ant.', al_lin(:,:,w)); % 200x256 200x1
    % Calculating transfer function from plane wave
    hf(:,:,w)=pw2hf(am, toa(:,:,w), fc, bw, Nf);
end
% save hf hf
%% Capacity averaging on all frequency bins
clear a* d* rx tx phase prx toa f
snr=db2pow(Ptx)/(No*B);
Hf=permute(hf, [2 1 3]);
Hf=reshape(Hf, elem_rx, elem_tx, Nf, []);
for w=1:rxN
    H=Hf(:,:,:,w);
    Hh=permute( conj(H), [ 2 1 3]);
    R=times3d(H, Hh);
    gamma=waterfill(H);
    for w1=1:Nf
        lambda(:,w1)=eig(R(:,:,w1));
    end
    lambda=sort(lambda,'descend');
    cp_t=sum(log2(1+snr*gamma.*lambda./elem_tx),1);
    cp(w)=mean(cp_t);
end
cpsm=cp(:);
% save cpsm cpsm
% %--------------------------------------
%% RMS delay
ht=ifft(hf);
pdp=squeeze(sum(abs(ht).^2,2));
% Time-intergrated power
pm=sum(pdp,1);
% Mean delay
tm=sum(bsxfun(@times, pdp, tau.'),1);
% Rms delay spread
tau2=tau(:).^2;
st=sqrt(sum(bsxfun(@times, pdp, tau2),1)./pm-tm.^2);
st=st(:);
rxP=pow2db(squeeze(mean(sum(abs(ht).^2,2),1)));

%% Save data
% save( strcat(strSave,'/rmsDelay'), 'st');%% Received power
% save( strcat(strSave,'/channelMatrix'), 'hf');
% save( strcat(strSave,'/rxPowerMIMO'), 'rxP');
% save( strcat(strSave,'/capacity'), 'cp');
toc