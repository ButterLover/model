% Implementing all models with and without antenna element pattern
% This file should be run under the files directions
% MIMO case: tx - 8x4  rx - 1x8 
clc;clear all; close all;
tic
% generateData;
op=10;
ed=58;
Ptx=1.5; % 1.5 dBw = 31.5 dBm
load rayAm
load doa
load dod
doa0=doa;
al0=al;
%% =============================  Iso r0  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0; % Isotropic antenna plane wave are the same for all rotation
% rotation 0
doa=doa0;
dir='\iso\r0';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir, Ptx );
bfModel( hf, dir , Ptx);
bfEigModel( hf, dir , Ptx);
smh2Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
smh4Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
%% =============================  Iso r45  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0; % Isotropic antenna plane wave are the same for all rotation
% rotation 0
doa=doa1;
dir='\iso\r45';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir, Ptx );
bfModel( hf, dir, Ptx );
bfEigModel( hf, dir , Ptx);
smh2Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
smh4Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
%% =============================  Iso r90  ===============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0; % Isotropic antenna plane wave are the same for all rotation
% rotation 0
doa=doa2;
dir='\iso\r90';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir , Ptx);
bfModel( hf, dir , Ptx);
bfEigModel( hf, dir , Ptx);
smh2Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
smh4Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
%% =============================  Iso r135  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0; % Isotropic antenna plane wave are the same for all rotation
% rotation 0
doa=doa3;
dir='\iso\r135';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir , Ptx);
bfModel( hf, dir , Ptx);
bfEigModel( hf, dir , Ptx);
smh2Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
smh4Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
%% =============================  Patch r0  ==============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al_pat;
% rotation 0
doa=doa0;
dir='\pat\r0';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir , Ptx);
bfModel( hf, dir , Ptx);
bfEigModel( hf, dir , Ptx);
smh2Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
smh4Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
%% =============================  Patch r45  ==============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al_pat1;
% rotation 0
doa=doa1;
dir='\pat\r45';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir , Ptx);
bfModel( hf, dir , Ptx);
bfEigModel( hf, dir , Ptx);
smh2Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
smh4Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
%% =============================  Patch r90  =============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al_pat2;
% rotation 0
doa=doa2;
dir='\pat\r90';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir , Ptx);
bfModel( hf, dir , Ptx);
bfEigModel( hf, dir , Ptx);
smh2Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
smh4Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
%% =============================  Patch r135  ==============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al_pat3;
% rotation 0
doa=doa3;
dir='\pat\r135';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir , Ptx);
bfModel( hf, dir , Ptx);
bfEigModel( hf, dir , Ptx);
smh2Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
smh4Model( op, ed, al, doa, dod, phase, toa, dir , Ptx);
toc
