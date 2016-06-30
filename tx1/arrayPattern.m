load rayAm
load dod
load doa

fc=15e9;
bw=800e6;
Ptx=1.5; % 1.5 dBw = 31.5 dBm
save_flag=true;
rx_ind=1:1:2;

prx=al(:,:,rx_ind);
doa_phi=doa(:,1,rx_ind); % degree
doa_theta=doa(:,2,rx_ind); % degree
dod_phi=dod(:,1,rx_ind); % degree
dod_theta=dod(:,2,rx_ind); % degree
phase=phase(:,:,rx_ind);
al_lin=db2mag(prx).*exp(1j*2*pi*degtorad(phase));    % Plane wave
clear al al_p* doa doa2 dod phase
%%
% Initialized parameters
Nf=801;
ft=bw/(Nf-1);   % Frequency spacing between two bins
tau=0:1/bw:1/ft;    % Calculating delay
[rayN, ~, rxN]=size(prx);
B=bw/(Nf-1);    % Frequency bins bandwidth
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
hta=zeros(elem_tx*elem_rx,rxN);
parfor w=1:rxN
    % Phase shift of antenna array
    ant_tx=psht(array_tx, dir_tx(:,:,w), fc, false, 0.5); % 200x32
    ant_tx=reshape(ant_tx.', 1, elem_tx, rayN); % 1x32x200
    ant_rx=psht(array_rx, dir_rx(:,:,w), fc, false, 0.5); % 200x8
    ant_rx=reshape(ant_rx.', elem_rx, 1, rayN); % 8x1x200
    % Applying antenna pattern on plane wave
    tx=repmat(ant_tx, elem_rx, 1, 1); % 8x32x200
    rx=repmat(ant_rx, 1, elem_tx, 1); % 8x32x200
    ant=reshape(tx.*rx, [],rayN); % 256x200
    am=bsxfun(@times, ant.', al_lin(:,:,w)); % 200x256 200x1
    % Calculating transfer function from plane wave
    hf(:,:,w)=pw2hf(am, toa(:,:,w), fc, bw, Nf);
end
%%
strSave=strcat(pwd, '\mimo');
if exist(strSave, 'dir')~=7
    mkdir(strSave);
end
if rx_ind(end)>735 && save_flag
    hf_los=hf(:,:,1:132);
    hf_nlos1=hf(:,:,133:433);
    hf_nlos2=hf(:,:,434:734);
    hf_nlos3=hf(:,:,735:end);
    % clear hf
    save( strcat(strSave, '\hf'), 'hf_*');
elseif save_flag
    save( strcat(strSave, '\hf'), 'hf');
end
%% Patch element
load rayAm
load dod
load doa

fc=15e9;
bw=800e6;
Ptx=1.5; % 1.5 dBw = 31.5 dBm
save_flag=true;
% rx_ind=1:1:968;

prx=al_pat(:,:,rx_ind);
doa_phi=doa(:,1,rx_ind); % degree
doa_theta=doa(:,2,rx_ind); % degree
dod_phi=dod(:,1,rx_ind); % degree
dod_theta=dod(:,2,rx_ind); % degree
phase=phase(:,:,rx_ind);
al_lin=db2mag(prx).*exp(1j*2*pi*degtorad(phase));    % Plane wave
clear al al_p* doa doa2 dod phase
%%
% Initialized parameters
Nf=801;
ft=bw/(Nf-1);   % Frequency spacing between two bins
tau=0:1/bw:1/ft;    % Calculating delay
[rayN, ~, rxN]=size(prx);
B=bw/(Nf-1);    % Frequency bins bandwidth
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
hf_pat=zeros(Nf,elem_tx*elem_rx,rxN);
hta=zeros(elem_tx*elem_rx,rxN);
parfor w=1:rxN
    % Phase shift of antenna array
    ant_tx=psht(array_tx, dir_tx(:,:,w), fc, false, 0.5); % 200x32
    ant_tx=reshape(ant_tx.', 1, elem_tx, rayN); % 1x32x200
    ant_rx=psht(array_rx, dir_rx(:,:,w), fc, false, 0.5); % 200x8
    ant_rx=reshape(ant_rx.', elem_rx, 1, rayN); % 8x1x200
    % Applying antenna pattern on plane wave
    tx=repmat(ant_tx, elem_rx, 1, 1); % 8x32x200
    rx=repmat(ant_rx, 1, elem_tx, 1); % 8x32x200
    ant=reshape(tx.*rx, [],rayN); % 256x200
    am=bsxfun(@times, ant.', al_lin(:,:,w)); % 200x256 200x1
    % Calculating transfer function from plane wave
    hf_pat(:,:,w)=pw2hf(am, toa(:,:,w), fc, bw, Nf);
end
%%
strSave=strcat(pwd, '\mimo');
if exist(strSave, 'dir')~=7
    mkdir(strSave);
end
if rx_ind(end)>735 && save_flag
    hf_los=hf_pat(:,:,1:132);
    hf_nlos1=hf_pat(:,:,133:433);
    hf_nlos2=hf_pat(:,:,434:734);
    hf_nlos3=hf_pat(:,:,735:end);
    % clear hf
    save( strcat(strSave, '\hf_pat'), 'hf_los', 'hf_n*');
elseif save_flag
    save( strcat(strSave, '\hf_pat'), 'hf_pat');
end