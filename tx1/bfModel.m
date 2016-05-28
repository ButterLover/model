function [ hfbf, cpbf, st, rxP ] = bfModel( Hf, dir, Ptx, fc, bw, save_flag )
%BFMODEL [ hfbf, cpbf, st, rxP ] = bfModel( Hf, dir, Ptx, fc, bw, save_flag )
%  
%  Directional beamforming
% 
% Input: 
% hf - channel transfer function with antenna array phase shift applied
% dir - data saving directory
% Ptx - transmitting power
% fc - center frequency
% bw - system bandwidth
% save_flag - true for saving data in folder
% 
% 
% Output:
% hfbf - transfer function
% cpbf - capacity of beamforming
% st - rms delay spread
% rxP - received power
% 

%%
strSave=strcat(mfilename('fullpath'), dir)
if exist(strSave, 'dir')~=7
    mkdir(strSave);
end
% Initialization parameters
[Nf, ~, rxN]=size(Hf);
Hf=permute(Hf, [2 1 3]);
% fc=15e9;
% bw=1e9; % System bandwidth
ft=bw/(Nf-1);   % Frequency spacing between two bins
fk=fc-bw/2:ft:fc+bw/2;   % Frequency range
tau=0:1/bw:1/ft;    % Calculating delay
array_tx=[4 1 8];   % 8x4 XZ plane
array_rx=[8 1 1];   % 8x1 Linear X
elem_tx=prod(array_tx);
elem_rx=prod(array_rx);
phi=linspace(-180, 180, 180);
theta=linspace(0, 180, 90);
[ dod_phi, dod_theta]=meshgrid(phi, theta);
dirs_t=[dod_phi(:), dod_theta(:)];
clear dod_phi dod_theta phi theta

B=bw/(Nf-1);    % Frequency bins bandwidth
% Ptx=-30;    % Transmitting power 0dBm=-30dBw
k=1.381*10e-23;
T=290;
No=k*T; % Noise level
snr=db2pow(Ptx)/(No*B);
% hf=zeros(Nf,elem_tx*elem_rx,rxN);
parfor w=1:rxN
    
    hf_t=reshape(Hf(:,:,w), elem_rx, elem_tx, []);
    hf_tx=squeeze( hf_t(1, :, :));
    hf_rx=squeeze(hf_t( :, 1,:));
    
    % Steering phase shift
    as_tx=findStr( array_tx, hf_tx, dirs_t, fc, 1 ); % 1x32
    as_rx=findStr( array_rx, hf_rx, dirs_t, fc, 1 );
    
    % Applying antenna pattern on plane wave
    tx=repmat(as_tx(:).', elem_rx, 1);
    rx=repmat(as_rx(:), 1,elem_tx);
    ant=tx.*rx;
    wf=norm(ant, 'fro');
    ant=ant(:);
    % tau peak
    ht=ifft(Hf(:,:,w).');
    pdp=squeeze(sum(abs(ht).^2,2)); % 801x1
    [~, ind_mx]=max(pdp(:)); % 801x1
    tau_p=tau(ind_mx);
    
    hfbf(:,w)=Hf(:,:,w).'*ant./wf;
    wb=abs( Hf(:,:,w).'*ant./wf.*(exp(-1j*2*pi.*fk(:).*tau_p))); % 801x256 256x1 = 801x1 .* 801x1
    % Calculating capacity
    cp_t(w)=mean( log2(1+snr.*wb.^2)); % 801x1 = 1x1
end
clear Hf
%% Capacity of estimating directional beamforming
cp=cp_t(:);
cpbf=cp;
%% Save channel matrix and capacity
hfbf=reshape(hfbf, Nf, 1, []);
if rxN>735 && save_flag
    hfbf_los=hfbf(:,:,1:132);
    hfbf_nlos1=hfbf(:,:,133:433);
    hfbf_nlos2=hfbf(:,:,434:734);
    hfbf_nlos3=hfbf(:,:,735:end);
    save( strcat(strSave,'/channelMatrix'), 'hfbf_los', 'hfbf_nlos1', 'hfbf_nlos2', 'hfbf_nlos3');
end

clear hfbf_los hfbf_nlos* cp_t
%% RMS delay
ht=ifft(hfbf);
if save_flag
    clear hfbf
end
pdp=squeeze(sum(abs(ht).^2,2));
% Time-intergrated power
pm=sum(pdp,1);
% Mean delay
tm=sum(bsxfun(@times, pdp, tau.'),1);
% Rms delay spread
tau2=tau(:).^2;
st=sqrt(sum(bsxfun(@times, pdp, tau2),1)./pm-tm.^2);
st=st(:);
pw=pow2db(squeeze(mean(sum(abs(ht).^2,2),1)));
rxP=pw(:)+Ptx+30;
%% Save data
if save_flag
    save( strcat(strSave,'/rmsDelay'), 'st');
    save( strcat(strSave,'/rxPowerMIMO'), 'rxP');%% Received power
    save( strcat(strSave,'/capacity'), 'cp');
end
% toc
end

