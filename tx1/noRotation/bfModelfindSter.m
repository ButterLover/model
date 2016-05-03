% Calculating Beamforming capacity outdoor 15 GHz Tx1
% This file should be run under the files directions
% MIMO case: tx - 8x4  rx - 1x8
clear all; close all;
tic
load hf
%%
% Initialization parameters
[Nf, ~, rxN]=size(hf);
Hf=permute(hf, [2 1 3]);
fc=15e9;
bw=1e9; % System bandwidth
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

B=bw/(Nf-1);    % Frequency bins bandwidth
Ptx=-30;    % Transmitting power 0dBm=-30dBw
k=1.381*10e-23;
T=290;
No=k*T; % Noise level
snr=db2pow(Ptx)/(No*B);
% hf=zeros(Nf,elem_tx*elem_rx,rxN);
for w=1:rxN
    
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
    
    wb=abs( Hf(:,:,w).'*ant./wf.*(exp(-1j*2*pi.*fk(:).*tau_p))); % 801x256 256x1 = 801x1 .* 801x1
    % Calculating capacity
    cp_t(w)=mean( log2(1+snr.*wb.^2)); % 801x1 = 1x1
end
clear ant* tx rx am a* toa tau dir* do* N* phase prx f
clear lambda

%% Capacity of estimating directional beamforming
cpbf=cp_t(:);
save cpbf cpbf
%% Capacity method 3 classic shannon
% Hf=sum(abs(hf).^2, 2);
% cpbf=mean(log2(1+snr*Hf));
% cpbf=cpbf(:);
% save cpbf cpbf
% save hf hf
toc