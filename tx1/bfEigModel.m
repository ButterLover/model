function [ cpeig ] = bfEigModel( hf, dir )
%BFEIGMODEL [ cpeig ] = bfEigModel( hf, dir )
%
%  Dominant eigmode beamforming
%
%  Input:
%  hf - channel transfer function with antenna array phase shift applied
%  dir - data saving directory
%
%
%  Output:
%  cpeig - capacity of dominant eigmode
%
%% Dominant eigenmode
strSave=strcat(mfilename('fullpath'), dir)
if exist(strSave, 'dir')~=7
    mkdir(strSave);
end
elem_tx=32;
elem_rx=8;
Nf=801;
fc=15e9;
bw=1e9; % System bandwidth
ft=bw/(Nf-1);   % Frequency spacing between two bins
fk=fc-bw/2:ft:fc+bw/2;   % Frequency range
tau=0:1/bw:1/ft;    % Calculating delay
Hf=permute(hf, [2 1 3]);
Hf=reshape(Hf, elem_rx, elem_tx, Nf, []);
[~, ~, ~, rxN]=size(Hf);
clear hf
%%
bw=1e9; % System bandwidth
B=bw/(Nf-1);    % Frequency bins bandwidth
Ptx=-30;    % Transmitting power 0dBm=-30dBw
k=1.381*10e-23;
T=290;
No=k*T; % Noise level
snr=db2pow(Ptx)/(No*B);
cp_eig=zeros(rxN, 1);
parfor w=1:rxN
    H=Hf(:,:,:,w);
    sigma=zeros(1, Nf);
    for w1=1:Nf
        [u, ~, vh]=svd(H(:,:,w1)); % The first column is the max singular vector
        uh=u(:, 1)';
        v=vh(:, 1);
        sigma(w1)=uh*H(:,:,w1)*v;
    end
    hfeig(:,w)=sigma;
    cp_t=log2(1+snr*abs(sigma).^2);
    cp_eig(w)=mean(cp_t);
end
clear Hf
cp_eig=cp_eig(:);
cp=cp_eig;
% save cpeig cp_eig
%% Save channel matrix and capacity
hfeig=reshape(hfeig, Nf, 1, []);
if rxN>735
    hfeig_los=hfeig(:,:,1:132);
    hfeig_nlos1=hfeig(:,:,133:433);
    hfeig_nlos2=hfeig(:,:,434:734);
    hfeig_nlos3=hfeig(:,:,735:end);
end
if rxN>735
    save( strcat(strSave,'/channelMatrix'), 'hfeig_los', 'hfeig_nlos1', 'hfeig_nlos2', 'hfeig_nlos3');
end
save( strcat(strSave,'/capacity'), 'cp');
clear hfeig_los hfeig_nlos*
%% RMS delay
ht=ifft(hfeig);
clear hfeig
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
save( strcat(strSave,'/rmsDelay'), 'st');
save( strcat(strSave,'/rxPowerMIMO'), 'rxP');%% Received power

toc
end

