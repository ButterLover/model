% Calculating Beamforming capacity outdoor 15 GHz Tx1
% This file should be run under the files directions
% MIMO case: tx - 8x4  rx - 1x2 linear subarray, 4 beams
clear all; close all;
tic
load rayAm al phase toa
load doa doa
load dod
strSave=mfilename('fullpath')
op=1;
ed=20;
%%
prx=al(:,:,op:ed);
doa_phi=doa(:,1,op:ed); % degreeBButterLover
doa_theta=doa(:,2,op:ed); % degree
dod_phi=dod(:,1,op:ed); % degree
dod_theta=dod(:,2,op:ed); % degree
phase=phase(:,:,op:ed);
al_lin=db2mag(prx).*exp(1j*2*pi*degtorad(phase));    % Plane wave
[ rayN, ~, rxN]=size(al_lin);
clear al
% Initialization parameters
fc=15e9;
bw=1e9; % System bandwidth
Nf=801; % Number of subchannels
ft=bw/(Nf-1);   % Frequency spacing between two bins
fk=fc-bw/2:ft:fc+bw/2;   % Frequency range
tau=0:1/bw:1/ft;    % Calculating delay
B=bw/(Nf-1);    % Frequency bins bandwidth
Ptx=-30;    % Transmitting power 0dBm=-30dBw
k=1.381*10e-23;
T=290;
No=k*T; % Noise level
snr=db2pow(Ptx)/(No*B);

array_tx=[4 1 8];   % 8x4 XZ plane
array_rx=[2 1 1];   % 8x1 Linear X
Nb_rx=4;
elem_tx=prod(array_tx);
elem_rx=prod(array_rx);
dir_tx=[dod_phi dod_theta];
dir_rx=[doa_phi doa_theta];
% hf=zeros(Nf,elem_tx*elem_rx,rxN); % TF of tx with one subarray 32x2
phi=linspace(-180, 180, 90);
theta=linspace(0, 180, 45);
[ phi2, theta2]=meshgrid(phi, theta);
dirs_t=[phi2(:), theta2(:)];
clear dod dod_phi dod_theta doa doa_phi doa_theta phi phi2 theta theta2 phase prx
% hf=zeros(Nf,elem_tx*elem_rx,rxN);
for w=1:rxN
    
    % Phase shift of antenna array
    ant_tx=psht(array_tx, dir_tx(:,:,w), fc, false); % 200x32
    ant_tx=reshape(ant_tx.', 1, elem_tx, rayN); % 1x32x200
    ant_rx=psht2(array_rx, dir_rx(:,:,w), fc, Nb_rx); % 200x8
    ant_rx=reshape(ant_rx.', elem_rx*Nb_rx, 1, rayN); % 8x1x200
    
    % Applying antenna pattern on plane wave
    tx=repmat(ant_tx, elem_rx*Nb_rx, 1, 1); % 8x32x200
    rx=repmat(ant_rx, 1, elem_tx, 1); % 8x32x200
    ant=reshape(tx.*rx, [],rayN); % 256x200
    am=bsxfun(@times, ant.', al_lin(:,:,w)); % 200x256 200x1
    % Calculating transfer function from plane wave
    hf(:,:,w)=pw2hf(am, toa(:,:,w), fc, bw, Nf);    % 801x256
    ht_t=ifft(hf(:,:,w)); % 801x256
    ht_t=reshape( ht_t.', elem_rx*Nb_rx, elem_tx, [] ); % 8x32x801
    ht_t=squeeze(sum(ht_t, 2) ); % 8x801
    % Finding steering vector at rx side
    hf_t=reshape(fft(ht_t.').', elem_rx, Nb_rx, []); % 2x4x801  
    
    hft=reshape(hf(:,:,w).', elem_rx, Nb_rx, elem_tx, [] ); % 2x4x32x801
    % Steering phase shift
    as_rx=zeros(Nb_rx, elem_rx);
    hf_s=[];
    for w2=1:Nb_rx
        hf_rx=squeeze(hf_t( :, w2, : ));  % 2x801 Assuming all rx element see the same from tx
        as_rx_t=findStr( array_rx, hf_rx, dirs_t, fc, 1 ); % 4x2 Four beams of 2 ant elements
        wf=norm( as_rx_t( 1, :), 'fro');
        as_rx_t=as_rx_t./wf;
        as_rx(w2, :)=as_rx_t;    % Normalization
        
        hftt=squeeze(hft( :, w2, :, :)); % 2x32x801
        hf_st=times3d(as_rx_t, hftt); % 1x32x801
        hf_s=[hf_s; hf_st]; % 4x32x801
    end
    % Applying steering vector
%     hf_s=times3d(as_rx, hf_t);  % 4x32x801
    hf_sh=permute( conj( hf_s), [2 1 3] ); % 32x4x801
    R=times3d( hf_s, hf_sh); % 4x4x801
    gamma=waterfill(hf_s); % 4x801
    lambda=zeros( Nb_rx, Nf);
    for w1=1:Nf
        lambda( :, w1 )=sort(eig(R(:,:,w1)), 'descend');
    end
    % Calculating capacity
    cp_t=sum(log2(1+snr*gamma.*lambda./elem_tx),1);
    cp(w)=mean(cp_t);
end
% clear ant* tx rx am a* toa tau dir* do* N* phase prx f
% clear lambda
% save hf2 hf
%% Capacity of estimating directional beamforming
cpsm4=cp(:);
save cpsm4 cpsm4
%% Capacity method 3 classic shannon
% Hf=sum(abs(hf).^2, 2);
% cpbf=mean(log2(1+snr*Hf));
% cpbf=cpbf(:);
% save cpbf cpbf
% save hf hf
toc