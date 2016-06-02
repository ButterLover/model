clear all;
close all;
load rayAm
load dod
load doa
tic
%
rx_ind=[ 10 19 44 67 82 90 114 122];
% rx_ind=82;
Ptx=1.5;
fc=15e9;
bw=800e6;
save_flag=false;
rt_phi=0:6:360;
dir=' ';
% %% Isotropic element
% parfor w=1:length(rt_phi)
%     % Rx rotation
%     doat=doa;
%     phi=doat(:,1,:)-rt_phi(:, w)+90; % From phi=-180 to 180
%     phi(phi>180)=mod(phi(phi>180),-180);
%     phi(phi<-180)=mod(phi(phi<-180),180);
%     doat(:,1,:)=phi;
%     % Spatial multiplexing model
%     [ hfsm(:,:,:,w), cpsm(:,w), st_sm(:,w), rxP_sm(:,w)]=smModel( rx_ind, al, doat, dod, phase, toa, ' ', Ptx, fc, bw, save_flag);
%     % Directional BF
%     [ hfbf(:,:,w), cpbf(:, w), st_bf(:, w), rxP_bf(:, w)]=bfModel( hfsm(:,:,:,w), dir, Ptx, fc, bw, save_flag );
%     % DET
%     [ hfeig(:,:,w), cpeig(:, w), st_eig(:, w), rxP_eig(:, w)]=bfEigModel( hfsm(:,:,:,w), dir, Ptx, fc, bw, save_flag );
%     % Hybrid SM2
%     [ hfsm2(:,:,:,w), cpsm2(:, w), st_sm2(:, w), rxP_sm2(:, w)]=smh2Model( rx_ind, al, doat, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
%     % Hybrid SM4
%     [ hfsm4(:,:,:,w), cpsm4(:,w), st_sm4(:,w), rxP_sm4(:, w) ] = smh4Model( rx_ind, al, doat, dod, phase, toa, dir, Ptx, fc, bw, save_flag)
% end
% toc
% %
% strSave=strcat(pwd,'/rotate/iso')
% if exist(strSave, 'dir')~=7
%     mkdir(strSave);
% end
% save( strcat(strSave,'/rmsDelay'), 'st*');
% save( strcat(strSave,'/capacity'), 'cp*');
% save( strcat(strSave,'/channel'), 'hf*');
% save( strcat(strSave,'/receivedPower'), 'rxP*');

%% Patch element
load patchYPattern % For tx, patch radiates North
load patchPattern % For rx, patch radiates South
% Adding ant pattern at tx side
theta_tx=round(dod(:,2,:)/2); % Theta for tx side
theta_tx(theta_tx==0)=1;
phi_tx=round(dod(:,1,:)/2)+90;
phi_tx(phi_tx==0)=1;
ind_tx=sub2ind(size(pat),theta_tx, phi_tx);
al_lin=db2mag(al).*exp(1j*2*pi*degtorad(phase)).*pat(ind_tx);

% Adding patch pattern at rx side
theta_rx=round(doa(:,2,:)/2); % Theta is all the same for any rotation
theta_rx(theta_rx==0)=1;  % Rx side
parfor w=1:length(rt_phi)
    % Rx rotation
    doat=doa;
    phi=doat(:,1,:)-rt_phi(:, w)+90;
    phi(phi>180)=mod(phi(phi>180),-180);
    phi(phi<-180)=mod(phi(phi<-180),180);
    doat(:,1,:)=phi;

    % Adding patch pattern at rx side
    phi_rx=round(doat(:,1,:)/2)+90;
    phi_rx(phi_rx==0)=1;
    ind=sub2ind(size(patch),theta_rx, phi_rx);
    al_pat=mag2db(abs(al_lin.*patch(ind)));
    
    % Spatial multiplexing model
    [ hfsm(:,:,:,w), cpsm(:,w), st_sm(:,w), rxP_sm(:,w)]=smModel( rx_ind, al_pat, doat, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
    % Directional BF
    [ hfbf(:,:,w), cpbf(:, w), st_bf(:, w), rxP_bf(:, w)]=bfModel( hfsm(:,:,:,w), dir, Ptx, fc, bw, save_flag );
    % DET
    [ hfeig(:,:,w), cpeig(:, w), st_eig(:, w), rxP_eig(:, w)]=bfEigModel( hfsm(:,:,:,w), dir, Ptx, fc, bw, save_flag );
    % Hybrid SM2
    [ hfsm2(:,:,:,w), cpsm2(:, w), st_sm2(:, w), rxP_sm2(:, w)]=smh2Model( rx_ind, al_pat, doat, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
    % Hybrid SM4
    [ hfsm4(:,:,:,w), cpsm4(:,w), st_sm4(:,w), rxP_sm4(:, w) ] = smh4Model( rx_ind, al_pat, doat, dod, phase, toa, dir, Ptx, fc, bw, save_flag)
end
toc
%
strSave=strcat(pwd,'/rotate/patch')
if exist(strSave, 'dir')~=7
    mkdir(strSave);
end
save( strcat(strSave,'/rmsDelay'), 'st*');
save( strcat(strSave,'/capacity'), 'cp*');
save( strcat(strSave,'/channel'), 'hf*');
save( strcat(strSave,'/receivedPower'), 'rxP*');
toc