function [ hfsm4 ] = smh4Model( op, ed, al, doa, dod, phase, toa, dir, Ptx, fc, bw )
%SMH4MODEL [ hfsm4 ] = smh4Model( op, ed, al, doa, dod, phase, toa, dir, Ptx )
% Calculating hybrid Spatial multiplexing capacity outdoor Tx1
% MIMO case: 
% tx - 8x4  rx - 1x2 with all antenna elements lambda/2 spacing
% 4 subarrays with spacing lambda each
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
if exist(strSave, 'dir')~=7
    mkdir(strSave);
end
prx=al(:,:,op:ed);
doa_phi=doa(:,1,op:ed); % degreeBButterLover
doa_theta=doa(:,2,op:ed); % degree
dod_phi=dod(:,1,op:ed); % degree
dod_theta=dod(:,2,op:ed); % degree
phase=phase(:,:,op:ed);
toa=toa(:,:,op:ed);
al_lin=db2mag(prx).*exp(1j*2*pi*degtorad(phase));    % Plane wave
[ rayN, ~, rxN]=size(al_lin);
clear al doa dod
% Initialization parameters
% fc=15e9;
% bw=1e9; % System bandwidth
Nf=801; % Number of subchannels
ft=bw/(Nf-1);   % Frequency spacing between two bins
fk=fc-bw/2:ft:fc+bw/2;   % Frequency range
B=bw/(Nf-1);    % Frequency bins bandwidth
% Ptx=-30;    % Transmitting power 0dBm=-30dBw
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
clear dod_phi dod_theta doa_phi doa_theta
% hf=zeros(Nf,elem_tx*elem_rx,rxN); % TF of tx with one subarray 32x2
phi=linspace(-180, 180, 90);
theta=linspace(0, 180, 45);
[ phi2, theta2]=meshgrid(phi, theta);
dirs_t=[phi2(:), theta2(:)];
clear phi phi2 theta theta2 phase prx
hfsm4=zeros(Nf, elem_tx*Nb_rx, rxN);
parfor w=1:rxN 
    % Phase shift of antenna array
    ant_tx=psht(array_tx, dir_tx(:,:,w), fc, false, 0.5); % 200x32
    ant_tx=reshape(ant_tx.', 1, elem_tx, rayN); % 1x32x200
    ant_rx=psht2(array_rx, dir_rx(:,:,w), fc, Nb_rx); % 200x8
    ant_rx=reshape(ant_rx.', elem_rx*Nb_rx, 1, rayN); % 8x1x200
  % Applying antenna pattern on plane wave
    ant_tx=repmat(ant_tx, elem_rx*Nb_rx, 1, 1); % 8x32x200
    ant_rx=repmat(ant_rx, 1, elem_tx, 1); % 8x32x200
    ant=reshape(ant_tx.*ant_rx, [],rayN); % 256x200
    am=bsxfun(@times, ant.', al_lin(:,:,w)); % 200x256 200x1
   % Calculating transfer function from plane wave
    hf=pw2hf(am, toa(:,:,w), fc, bw, Nf);    % 801x256
    hf_t=ifft(hf); % 801x256
    hf_t=reshape( hf_t.', elem_rx*Nb_rx, elem_tx, [] ); % 8x32x801
    hf_t=squeeze(sum(hf_t, 2) ); % 8x801
   % Finding steering vector at rx side
    hf_t=reshape(fft(hf_t.').', elem_rx, Nb_rx, []); % 2x4x801      
    hft=reshape(hf.', elem_rx, Nb_rx, elem_tx, [] ); % 2x4x32x801    
    % Steering phase shift
    hf_s=[];
    for w2=1:Nb_rx
        as_rx_t=findStr( array_rx, squeeze(hf_t( :, w2, : )), dirs_t, fc, 1 ); % 4x2 Four beams of 2 ant elements
        wf=norm( as_rx_t( 1, :), 'fro');
        as_rx_t=as_rx_t./wf;       
        hftt=squeeze(hft( :, w2, :, :)); % 2x32x801
        hf_s=[hf_s; times3d(as_rx_t, hftt)]; % 4x32x801
    end 
    % Saving channel matrix
    hfsm4(:,:,w)=reshape(hf_s, [], Nf).';
    % Applying steering vector
    R=times3d( hf_s, permute( conj( hf_s), [2 1 3] )); % 4x4x801
    gamma=waterfill(hf_s); % 4x801    
    lambda=zeros( Nb_rx, Nf);
    for w1=1:Nf
        lambda( :, w1 )=sort(eig(R(:,:,w1)), 'descend');
    end
    % Calculating capacity
    cp_t=sum(log2(1+snr*gamma.*lambda./elem_tx),1);
    cp(w)=mean(cp_t(:));  
end
clear toa dir_tx dir_rx dirs_t
%% Capacity of estimating directional beamforming
cp=cp(:);
cpsm4=cp;
% save cpsm4 cpsm4
%% Save capacity and channel matrix
if rxN>735
    hfsm4_los=hfsm4(:,:,1:132);
    hfsm4_nlos1=hfsm4(:,:,133:433);
    hfsm4_nlos2=hfsm4(:,:,434:734);
    hfsm4_nlos3=hfsm4(:,:,735:end);
end
if rxN>735
    save( strcat(strSave,'/channelMatrix'), 'hfsm4_los', 'hfsm4_nlos1', 'hfsm4_nlos2', 'hfsm4_nlos3');
end
save( strcat(strSave,'/capacity'), 'cp');
clear hfsm4_los hfsm4_nlos*
%% RMS delay
ht=ifft(hfsm4);
tau=0:1/bw:1/ft;    % Calculating delay
pdp=squeeze(sum(abs(ht).^2,2));
% Time-intergrated power
pm=sum(pdp,1);
% Mean delay
tm=sum(bsxfun(@times, pdp, tau.'),1);
% Rms delay spread
tau2=tau(:).^2;
clear tau
st=sqrt(sum(bsxfun(@times, pdp, tau2),1)./pm-tm.^2);
st=st(:);
pw=pow2db(squeeze(mean(sum(abs(ht).^2,2),1)));
rxP=pw(:)+Ptx+30;
%% Save data
save( strcat(strSave,'/rmsDelay'), 'st');%% Received power
save( strcat(strSave,'/rxPowerMIMO'), 'rxP');
toc

end

