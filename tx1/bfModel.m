function [ hf, cp, st, rxP ] = bfModel( hft, dir, Ptx, fc, bw, save_flag )
%BFMODEL [ hfbf, cpbf, st, rxP ] = bfModel( Hf, dir, Ptx, fc, bw, save_flag )
%  
%  Directional beamforming
% 
% Input:
% hf - channel transfer function with antenna array phase shift applied
% dir - data saving directory
% Ptx - transmitting power
% bw - system bandwidth
% save_flag - true for saving data in folder
%
% Output:
% hf - channel transfer function with beamforming weights
% cp - capacity of dominant eigmode
% st - rms delay spread
% rxP - received power
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
ft=bw/(Nf-1);
fk=fc-bw/2:ft:fc+bw/2;   % Frequency range

array_tx=[4 1 8];   % 8x4 XZ plane
array_rx=[8 1 1];   % 8x1 Linear X
elem_tx=prod(array_tx);
elem_rx=prod(array_rx);
phi=linspace(-180, 180, 180);
theta=linspace(0, 180, 90);
[ dod_phi, dod_theta]=meshgrid(phi, theta);
dirs_t=[dod_phi(:), dod_theta(:)];
clear dod_phi dod_theta phi theta

%% Capacity averaging on all frequency bins
Hf=permute(hft, [2 1 3]);
Hf=reshape(Hf, elem_rx, elem_tx, Nf, []);
cp=zeros(rxN,1);
parfor w=1:rxN
    
    hf_t=Hf(:,:,:,w);
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
%     wf=1
    ant=ant(:);
    % tau peak
    ht=ifft(hft(:,:,w));
    pdp=squeeze(mean(abs(ht).^2,2)); % 801x1
    [~, ind_mx]=max(pdp(:)); % 801x1
    tau_p=tau(ind_mx);
    
    hf(:,:,w)=hft(:,:,w).*(repmat(ant./sqrt(elem_tx), 1, Nf).');
    wb=abs( hft(:,:,w)*(ant./wf).*(exp(-1j*2*pi.*fk(:).*tau_p))); % 801x256 256x1 = 801x1 .* 801x1
    % Calculating capacity
    cp(w)=mean( log2(1+snr.*wb.^2)); % 801x1 = 1x1
end
clear Hf
%% Capacity of estimating directional beamforming
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
    save( strcat(strSave,'/rmsDelay'), 'st');
    save( strcat(strSave,'/rxPowerMIMO'), 'rxP');%% Received power
    save( strcat(strSave,'/capacity'), 'cp');
end
% toc
end