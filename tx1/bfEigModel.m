function [ hf, cp, st, rxP ] = bfEigModel( hft, dir, Ptx, bw, save_flag )
%BFEIGMODEL [ hf, cp, st, rxP ] = bfEigModel( hft, dir, Ptx, bw, save_flag )
%
% Dominant eigmode beamforming
%
% Input:
% hf - channel transfer function with antenna array phase shift applied
% dir - data saving directory
% Ptx - transmitting power
% fc - center frequency
% bw - system bandwidth
% save_flag - true for saving data in folder
%
% Output:
% hf - channel transfer function with beamforming weights
% cp - capacity of dominant eigmode
% st - rms delay spread
% rxP - received power
%
%% Dominant eigenmode
strSave=strcat(mfilename('fullpath'), dir)
if exist(strSave, 'dir')~=7
    mkdir(strSave);
end
% Initialized parameters
Nf=801;
tau=0:1/bw:(Nf-1)/bw;    % Calculating delay
[~, ~, rxN]=size(hft);
B=bw/(Nf-1);    % Frequency bins bandwidth
k=1.381*10e-23;
T=290;
No=k*T; % Noise level
snr=db2pow(Ptx)/(No*B);
elem_rx=8;
elem_tx=32;

%% Capacity averaging on all frequency bins
Hf=permute(hft, [2 1 3]);
Hf=reshape(Hf, elem_rx, elem_tx, Nf, []);
cp=zeros(rxN,1);
for w=1:rxN
    H=Hf(:,:,:,w);
    sigma=zeros(1, Nf);
    Hfeig=zeros(elem_rx, elem_tx, Nf);
    for w1=1:Nf
        [u, ~, vh]=svd(H(:,:,w1)); % The first column is the max singular vector
        uh=u(:, 1)';
        v=vh(:, 1);
        sigma(w1)=uh*H(:,:,w1)*v;
        Hfeig(1,1,w1)=sigma(w1)./sqrt(elem_tx);
        Hfeig(elem_rx, elem_tx, w1)=0;
    end
    hf(:,:,w)=reshape(Hfeig, elem_rx*elem_tx, Nf).';
    cp_t=log2(1+snr*abs(sigma).^2);
    cp(w)=mean(cp_t); 
end
cp=cp(:);

%% Save channel matrix and capacity
if rxN>735 && save_flag
    hf_los=hf(:,:,1:132);
    hf_nlos1=hf(:,:,133:433);
    hf_nlos2=hf(:,:,434:734);
    hf_nlos3=hf(:,:,735:end);
    save( strcat(strSave,'/channelMatrix'), 'hf_los', 'hf_nlos1', 'hf_nlos2', 'hf_nlos3');
    clear hf_los hf_nlos*
elseif save_flag
    save( strcat(strSave,'/channelMatrix'), 'hf');
end

%% RMS delay
ht=ifft(hf);
% Received power
pw=pow2db(squeeze(mean(sum(abs(ht).^2,2),1)));
rxP=pw(:)+Ptx+30; % 9dB higher than SISO link, correct
% clear hf
pdp=squeeze(mean(abs(ht).^2,2));
clear ht
% Time-intergrated power
pm=sum(pdp,1);
% Mean delay
tm=sum(bsxfun(@times, pdp, tau.'),1)./pm;
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