function [ hf ] = smModel( op, ed, al, doa, dod, phase, toa, dir )
%SMMODEL [ hf ] = smModel( op, ed, al, doa, dod, phase, toa, dir )
%
% Calculating Spatial multiplexing capacity outdoor Tx1
% MIMO case: tx - 8x4  rx - 1x8 with all antenna elements lambda/2 spacing
%
% Input:
% op - the first antenna index
% ed - the last antenna indes ( Indicating rx calculation range, eg. 1:132 for LOS )
% al - plane wave amplitude in dB, SISO from WirelessInsite,
% doa - direction of arrival in degree at Rx, [ phi, theta]
% dod - direction of departure in degree at Tx, [ phi, theta]
% phase - plane wave phase in degree
% toa - plane wave time of arrive
% dir - saving data directory
%
% Output:
% hf - channel transfer function with antenna array phase shift applied
%
%%
strSave=strcat(mfilename('fullpath'), dir)
prx=al(:,:,op:ed);
doa_phi=doa(:,1,op:ed); % degree
doa_theta=doa(:,2,op:ed); % degree
dod_phi=dod(:,1,op:ed); % degree
dod_theta=dod(:,2,op:ed); % degree
phase=phase(:,:,op:ed);
al_lin=db2mag(prx).*exp(1j*2*pi*degtorad(phase));    % Plane wave
clear al al_p* doa doa2 dod phase
%%
% al_lin(2:end,:,:)=0;
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
clear doa* dod*
hf=zeros(Nf,elem_tx*elem_rx,rxN);
parfor w=1:rxN
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
% save cpsm cpsm
% %--------------------------------------
%% RMS delay
if rxN>735
    hf_los=hf(:,:,1:132);
    hf_nlos1=hf(:,:,133:433);
    hf_nlos2=hf(:,:,434:734);
    hf_nlos3=hf(:,:,735:end);
end
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
rxP=rxP(:);

%% Save data
if rxN>735
    save( strcat(strSave,'/channelMatrix'), 'hf_los', 'hf_nlos1', 'hf_nlos2', 'hf_nlos3');
end
save( strcat(strSave,'/rmsDelay'), 'st');%% Received power
save( strcat(strSave,'/rxPowerMIMO'), 'rxP');
save( strcat(strSave,'/capacity'), 'cp');
toc

end

