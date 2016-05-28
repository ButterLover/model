function [ hf, cpsm, st, rxP ] = smModel( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag)
%SMMODEL [ hf, cpsm, st, rxP ] = smModel( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag)
%
% Calculating Spatial multiplexing capacity outdoor Tx1
% MIMO case: tx - 8x4  rx - 1x8 with all antenna elements lambda/2 spacing
%
% Input:
% rx_ind - the index of rx which needed in caculation, eg. (1)rx_ind = 1:1:132
% for all LOS (2) rx_ind = 82 for single point rx #82 caculation
% al - plane wave amplitude in dBm, SISO from WirelessInsite, /dBm
% doa - direction of arrival in degree at Rx, [ phi, theta] in degree
% dod - direction of departure in degree at Tx, [ phi, theta] in degree
% phase - plane wave phase in degree
% toa - plane wave time of arrive
% dir - saving data directory
% Ptx - transmitting power /dBw
% fc - center frequency /Hz
% bw - system bandwidth /Hz
% save_flag - true for saving data in folder
%
% Output:
% hf - channel transfer function with antenna array phase shift applied
% cpsm - spatial multiplexing capacity /bps/Hz
% st - rms delay spread /s
% rxP - received power /dBm
%
%%
strSave=strcat(mfilename('fullpath'), dir)
if exist(strSave, 'dir')~=7
    mkdir(strSave);
end
prx=al(:,:,rx_ind);
doa_phi=doa(:,1,rx_ind); % degree
doa_theta=doa(:,2,rx_ind); % degree
dod_phi=dod(:,1,rx_ind); % degree
dod_theta=dod(:,2,rx_ind); % degree
phase=phase(:,:,rx_ind);
al_lin=db2mag(prx).*exp(1j*2*pi*degtorad(phase));    % Plane wave
clear al al_p* doa doa2 dod phase
%%
% Initialized parameters
% fc=15e9;
% bw=1e9; % System bandwidth
Nf=801;
ft=bw/(Nf-1);   % Frequency spacing between two bins
% f=fc-bw/2:ft:fc+bw/2;   % Frequency range
tau=0:1/bw:1/ft;    % Calculating delay
[rayN, ~, rxN]=size(prx);
B=bw/(Nf-1);    % Frequency bins bandwidth
% Ptx=-30;    % Transmitting power 0dBm=-30dBw
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
clear doa* dod*
hf=zeros(Nf,elem_tx*elem_rx,rxN);
parfor w=1:rxN
    % Phase shift of antenna array
    ant_tx=psht(array_tx, dir_tx(:,:,w), fc, false, 0.5); % 200x32
    ant_tx=reshape(ant_tx.', 1, elem_tx, rayN); % 1x32x200
    ant_rx=psht(array_rx, dir_rx(:,:,w), fc, false, 0.5); % 200x8
    ant_rx=reshape(ant_rx.', elem_rx, 1, rayN); % 8x1x200
    % Applying antenna pattern on plane wave
    tx=repmat(ant_tx, elem_rx, 1, 1); % 8x32x200
    rx=repmat(ant_rx, 1, elem_tx, 1); % 8x32x200
    ant=reshape(tx.*rx, [],rayN); % 256x200
    am=bsxfun(@times, ant.', al_lin(:,:,w)); % 200x256 200x1
    % Calculating transfer function from plane wave
    hf(:,:,w)=pw2hf(am, toa(:,:,w), fc, bw, Nf);
end
clear toa
% save hf hf
%% Capacity averaging on all frequency bins
snr=db2pow(Ptx)/(No*B);
Hf=permute(hf, [2 1 3]);
Hf=reshape(Hf, elem_rx, elem_tx, Nf, []);
cp=zeros(rxN,1);
parfor w=1:rxN
    H=Hf(:,:,:,w);
    Hh=permute( conj(H), [ 2 1 3]);
    R=times3d(H, Hh);
    gamma=waterfill(H);
    lambda=zeros(elem_rx, Nf);
    for w1=1:Nf
        lambda(:,w1)=eig(R(:,:,w1));
    end
    lambda=sort(lambda,'descend');
    cp_t=sum(log2(1+snr*gamma.*lambda./elem_tx),1);
    cp(w)=mean(cp_t);
end
cpsm=cp(:);
clear Hf
% save cpsm cpsm
% %--------------------------------------
%% Save channel matrix and capacity
if rxN>735 && save_flag
    hf_los=hf(:,:,1:132);
    hf_nlos1=hf(:,:,133:433);
    hf_nlos2=hf(:,:,434:734);
    hf_nlos3=hf(:,:,735:end);
    save( strcat(strSave,'/channelMatrix'), 'hf_los', 'hf_nlos1', 'hf_nlos2', 'hf_nlos3');
end
clear hf_los hf_nlos*
%% RMS delay
ht=ifft(hf);
% Received power
pw=pow2db(squeeze(mean(sum(abs(ht).^2,2),1)));
rxP=pw(:)+Ptx+30;
% clear hf
pdp=squeeze(sum(abs(ht).^2,2));
clear ht
% Time-intergrated power
pm=sum(pdp,1);
% Mean delay
tm=sum(bsxfun(@times, pdp, tau.'),1);
% Rms delay spread
tau2=tau(:).^2;
st=sqrt(sum(bsxfun(@times, pdp, tau2),1)./pm-tm.^2);
st=st(:);

%% Save data
if save_flag
    save( strcat(strSave,'/rmsDelay'), 'st');%% Received power
    save( strcat(strSave,'/rxPowerMIMO'), 'rxP');
    save( strcat(strSave,'/capacity'), 'cp');
end

% toc

end

