function [ hf, cp, st, rxP ] = smh4Model( hft, dir, Ptx, fc, bw, save_flag)
%SMH4MODEL [ hf, cp, st, rxP ] = smModel( hft, dir, Ptx, bw, save_flag)
% Calculating hybrid Spatial multiplexing capacity outdoor Tx1
% MIMO case:
% tx - 8x4  rx - 1x2 with all antenna elements lambda/2 spacing
% 4 subarrays with spacing lambda each
%
%
% Input:
% hft - MIMO radio channel transfer function
% dir - saving data directory
% Ptx - transmitting power /dBw
% fc - carrier frequency /Hz
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
% Initialization parameters
Nf=801; % Number of frequency points
tau=0:1/bw:(Nf-1)/bw;    % Calculating delay
[~, ~, rxN]=size(hft);
B=bw/(Nf-1);    % Frequency bins bandwidth
k=1.381*10e-23;
T=290;
No=k*T; % Noise level
snr=db2pow(Ptx)/(No*B);

array_tx=[4 1 8];   % 8x4 XZ plane
array_rx=[2 1 1];   % 8x1 Linear X
Nb_rx=4;
elem_tx=prod(array_tx);
elem_srx=prod(array_rx);
elem_rx=elem_srx*Nb_rx;

phi=linspace(-180, 180, 90);
theta=linspace(0, 180, 45);
[ phi2, theta2]=meshgrid(phi, theta);
dirs_t=[phi2(:), theta2(:)];
clear phi phi2 theta theta2

%% Capacity averaging on all frequency bins
cp=zeros(rxN,1);
parfor w=1:rxN
    % transfer function
    hf1=hft(:,:,w);% 801x256
    ht_t=ifft(hf1); % 801x256
    ht_t=reshape( ht_t.', elem_rx, elem_tx, Nf ); % 8x32x801
    ht_t=squeeze(sum(ht_t, 2) ); % 8x801 IR when seeing Tx as one point
    
    % Finding steering vector at rx side
    hf_rx=reshape(fft(ht_t.').', elem_srx, Nb_rx, []); % 2x4x801
    hf2=reshape(hf1.', elem_srx, Nb_rx, elem_tx, [] ); % 2x4x32x801
    
    % Steering phase shift
    hf_s=[];
    as_rx=zeros(elem_srx, Nb_rx);
    for w1=1:Nb_rx
        as_rx_t=findStr( array_rx, squeeze(hf_rx( :, w1, : )), dirs_t, fc, 1 ); % 4x2 Four beams of 2 ant elements
        wf=norm( as_rx_t( 1, :), 'fro');
        as_rx_t=as_rx_t./wf;
        as_rx(:,w1)=as_rx_t;
        hftt=squeeze(hf2( :, w1, :, :)); % 2x32x801
        hf_s=[hf_s; times3d(as_rx_t, hftt)]; % 4x32x801
    end
    
    % Applying spatila multiplexing
    gam=waterfill(hf_s); % 4x801
    R=times3d( hf_s, permute( conj( hf_s), [2 1 3] )); % 4x4x801
    lambda=zeros( Nb_rx, Nf);
    for w1=1:Nf
        lambda(:,w1)=eig(R(:,:,w1));
    end
    [lambda, ind]=sort(lambda,'descend');
    
    % Effective channel
    gam_s=zeros(elem_rx, Nf);
    gam_s(1:2:elem_rx,:)=sqrt(gam(ind));
    gam_s(2:2:elem_rx,:)=sqrt(gam(ind));
    H=reshape(hf1.', elem_rx, elem_tx, Nf);
    Hfsm4=zeros(elem_rx, elem_tx, Nf);
    for w2=1:Nf
        [u, ~, v]=svd(H(:,:,w2));
        gam_st=diag(gam_s(:,w2));
        gam_st(elem_tx, elem_tx)=0;
        Hfsm4(:,:,w2)=(repmat(as_rx(:), 1, elem_rx).*u')*H(:,:,w2)*(v.*gam_st);
    end
    hf(:,:,w)=reshape(Hfsm4, elem_rx*elem_tx, Nf).';
    
    % Calculating capacity
    cp_t=sum(log2(1+snr*gam.*lambda./elem_tx),1);
    cp(w)=mean(cp_t(:));
end
cp=cp(:);

%% Save capacity and channel matrix
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
pdp=squeeze(sum(abs(ht).^2,2));
% Time-intergrated power
pm=sum(pdp,1);
% Mean delay
tm=sum(bsxfun(@times, pdp, tau.'),1)./pm;
% Rms delay spread
tau2=tau(:).^2;
clear tau
st=sqrt(sum(bsxfun(@times, pdp, tau2),1)./pm-tm.^2);
st=st(:);
pw=pow2db(squeeze(mean(sum(abs(ht).^2,2),1)));
rxP=pw(:)+Ptx+30;

%% Save data
if save_flag
    save( strcat(strSave,'/rmsDelay'), 'st');%% Received power
    save( strcat(strSave,'/rxPowerMIMO'), 'rxP');
    save( strcat(strSave,'/capacity'), 'cp');
end
% toc

end

