% Implementing all models with and without antenna element pattern
% This file should be run under the files directions
% MIMO case: tx - 8x4  rx - 8x1
clc;clear all;
tic
% generateData;
run arrayPattern
% rx_ind=1:1:2;
fc=15e9;
bw=800e6;
Ptx=1.5; % 1.5 dBw = 31.5 dBm
save_flag=true;
% save_flag=false;
strLoad=strcat(pwd, '\mimo');

%% =============================  Iso r0  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
% load(strcat(strLoad, '\hf'));
% hft=hf(:,:,rx_ind);
hft=hf;
dir='\iso\r0';
smModel( hft, dir, Ptx, bw, save_flag);
smh4Model( hft, dir, Ptx, fc, bw, save_flag);
smh2Model( hft, dir, Ptx, fc, bw, save_flag);
bfEigModel( hft, dir, Ptx, bw, save_flag );
bfModel( hft, dir, Ptx, fc, bw, save_flag);
%% =============================  Pat r0  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern pat ---------------------x
% x-----------------------------------------------------------------------x
% load(strcat(strLoad, '\hf_pat'));
% hft=hf_pat(:,:,rx_ind);
hft=hf_pat;
dir='\pat\r0';
[hfsm, cpsm, stsm, rxPsm]=smModel( hft, dir, Ptx, bw, save_flag);
[hfsmh4, cpsmh4, stsmh4, rxPsmh4]=smh4Model( hft, dir, Ptx, fc, bw, save_flag);
[hfsmh2, cpsmh2, stsmh2, rxPsmh2]=smh2Model( hft, dir, Ptx, fc, bw, save_flag);
[ hfeig, cpeig, steig, rxPeig ] = bfEigModel( hft, dir, Ptx, bw, save_flag );
[hfbf, cpbf, stbf, rxPbf]=bfModel( hft, dir, Ptx, fc, bw, save_flag);


% %% =============================  Iso r45  ================================|
% % x-----------------------------------------------------------------------x
% % x----------------------Antenna element pattern iso ---------------------x
% % x-----------------------------------------------------------------------x
% al=al0; % Isotropic antenna plane wave are the same for all rotation
% % rotation 0
% doa=doa1;
% dir='\iso\r45';
% hf=smModel( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% bfModel( hf, dir, Ptx, fc, bw, save_flag );
% bfEigModel( hf, dir, Ptx, fc, bw, save_flag );
% smh2Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% smh4Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% %% =============================  Iso r90  ===============================|
% % x-----------------------------------------------------------------------x
% % x----------------------Antenna element pattern iso ---------------------x
% % x-----------------------------------------------------------------------x
% al=al0; % Isotropic antenna plane wave are the same for all rotation
% % rotation 0
% doa=doa2;
% dir='\iso\r90';
% hf=smModel( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% bfModel( hf, dir, Ptx, fc, bw, save_flag );
% bfEigModel( hf, dir, Ptx, fc, bw, save_flag );
% smh2Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% smh4Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% %% =============================  Iso r135  ================================|
% % x-----------------------------------------------------------------------x
% % x----------------------Antenna element pattern iso ---------------------x
% % x-----------------------------------------------------------------------x
% al=al0; % Isotropic antenna plane wave are the same for all rotation
% % rotation 0
% doa=doa3;
% dir='\iso\r135';
% hf=smModel( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% bfModel( hf, dir, Ptx, fc, bw, save_flag );
% bfEigModel( hf, dir, Ptx, fc, bw, save_flag );
% smh2Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% smh4Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% %% =============================  Patch r0  ==============================|
% % x-----------------------------------------------------------------------x
% % x----------------------Antenna element pattern iso ---------------------x
% % x-----------------------------------------------------------------------x
% al=al_pat;
% % rotation 0
% doa=doa0;
% dir='\pat\r0';
% hf=smModel( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% bfModel( hf, dir, Ptx, fc, bw, save_flag );
% bfEigModel( hf, dir, Ptx, fc, bw, save_flag );
% smh2Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% smh4Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% %% =============================  Patch r45  ==============================|
% % x-----------------------------------------------------------------------x
% % x----------------------Antenna element pattern iso ---------------------x
% % x-----------------------------------------------------------------------x
% al=al_pat1;
% % rotation 0
% doa=doa1;
% dir='\pat\r45';
% hf=smModel( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% bfModel( hf, dir, Ptx, fc, bw, save_flag );
% bfEigModel( hf, dir, Ptx, fc, bw, save_flag );
% smh2Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% smh4Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% %% =============================  Patch r90  =============================|
% % x-----------------------------------------------------------------------x
% % x----------------------Antenna element pattern iso ---------------------x
% % x-----------------------------------------------------------------------x
% al=al_pat2;
% % rotation 0
% doa=doa2;
% dir='\pat\r90';
% hf=smModel( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% bfModel( hf, dir, Ptx, fc, bw, save_flag );
% bfEigModel( hf, dir, Ptx, fc, bw, save_flag );
% smh2Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% smh4Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% %% =============================  Patch r135  ==============================|
% % x-----------------------------------------------------------------------x
% % x----------------------Antenna element pattern iso ---------------------x
% % x-----------------------------------------------------------------------x
% al=al_pat3;
% % rotation 0
% doa=doa3;
% dir='\pat\r135';
% hf=smModel( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% bfModel( hf, dir, Ptx, fc, bw, save_flag );
% bfEigModel( hf, dir, Ptx, fc, bw, save_flag );
% smh2Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
% smh4Model( rx_ind, al, doa, dod, phase, toa, dir, Ptx, fc, bw, save_flag);
toc
