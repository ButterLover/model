function [ hf, cp, st, rxP ] =smModel( hft, dir, Ptx, bw, save_flag)
%SMMODEL [ hf, cp, st, rxP ] =smModel( hft, dir, Ptx, bw, save_flag)
%
% Calculating Spatial multiplexing capacity outdoor Tx1
%
% Input:
% hft - MIMO radio channel transfer function
% dir - saving data directory
% Ptx - transmitting power /dBw
% bw - system bandwidth /Hz
% save_flag - true for saving data in folder
%
% Output:
% hf - channel transfer function with antenna array phase shift applied
% cp - spatial multiplexing capacity /bps/Hz
% st - rms delay spread /s
% rxP - received power /dBm
%
%%
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
parfor w=1:rxN
    H=Hf(:,:,:,w);
    Hh=permute( conj(H), [ 2 1 3]);
    R=times3d(H, Hh);
    gam=waterfill(H);
    lambda=zeros(elem_rx, Nf);
    for w1=1:Nf
        lambda(:,w1)=eig(R(:,:,w1));
    end
    [lambda, ind]=sort(lambda,'descend');
    cp_t=sum(log2(1+snr*gam.*lambda./elem_tx),1);
    cp(w)=mean(cp_t);
    % Effective channel
    gam_s=sqrt(gam(ind));
    Hfsm=zeros(elem_rx, elem_tx, Nf);
    for w2=1:Nf
        [u, ~, v]=svd(H(:,:,w2));
        gam_st=diag(gam_s(:,w2));
        gam_st(elem_tx, elem_tx)=0;
        Hfsm(:,:,w2)=u'*H(:,:,w2)*(v.*gam_st);        
    end
    hf(:,:,w)=reshape(Hfsm, elem_rx*elem_tx, Nf).';
end
cp=cp(:);
clear Hf
% save cpsm cpsm

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
htsm=ifft(hf);
% Received power
pw=pow2db(squeeze(mean(sum(abs(htsm).^2,2),1)));
rxP=pw(:)+Ptx+30; % 9dB higher than SISO link, correct
% clear hf
pdp=squeeze(mean(abs(htsm).^2,2));
clear htsm
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

