% Implementing all models with and without antenna element pattern
% This file should be run under the files directions
% MIMO case: tx - 8x4  rx - 1x8 
clc;clear all; close all;
tic
% generateData;
op=10;
ed=20;
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
hf=smModel( op, ed, al, doa, dod, phase, toa, dir );
bfModel( hf, dir );
bfEigModel( hf, dir );
smh2Model( op, ed, al, doa, dod, phase, toa, dir );
smh4Model( op, ed, al, doa, dod, phase, toa, dir );
%% =============================  Iso r45  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0; % Isotropic antenna plane wave are the same for all rotation
% rotation 0
doa=doa1;
dir='\iso\r45';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir );
bfModel( hf, dir );
bfEigModel( hf, dir );
smh2Model( op, ed, al, doa, dod, phase, toa, dir );
smh4Model( op, ed, al, doa, dod, phase, toa, dir );
%% =============================  Iso r90  ===============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0; % Isotropic antenna plane wave are the same for all rotation
% rotation 0
doa=doa2;
dir='\iso\r90';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir );
bfModel( hf, dir );
bfEigModel( hf, dir );
smh2Model( op, ed, al, doa, dod, phase, toa, dir );
smh4Model( op, ed, al, doa, dod, phase, toa, dir );
%% =============================  Iso r135  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0; % Isotropic antenna plane wave are the same for all rotation
% rotation 0
doa=doa3;
dir='\iso\r135';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir );
bfModel( hf, dir );
bfEigModel( hf, dir );
smh2Model( op, ed, al, doa, dod, phase, toa, dir );
smh4Model( op, ed, al, doa, dod, phase, toa, dir );
%% =============================  Patch r0  ==============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al_pat;
% rotation 0
doa=doa0;
dir='\pat\r0';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir );
bfModel( hf, dir );
bfEigModel( hf, dir );
smh2Model( op, ed, al, doa, dod, phase, toa, dir );
smh4Model( op, ed, al, doa, dod, phase, toa, dir );
%% =============================  Patch r45  ==============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al_pat1;
% rotation 0
doa=doa1;
dir='\pat\r45';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir );
bfModel( hf, dir );
bfEigModel( hf, dir );
smh2Model( op, ed, al, doa, dod, phase, toa, dir );
smh4Model( op, ed, al, doa, dod, phase, toa, dir );
%% =============================  Patch r90  =============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al_pat2;
% rotation 0
doa=doa2;
dir='\pat\r90';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir );
bfModel( hf, dir );
bfEigModel( hf, dir );
smh2Model( op, ed, al, doa, dod, phase, toa, dir );
smh4Model( op, ed, al, doa, dod, phase, toa, dir );
%% =============================  Patch r135  ==============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al_pat3;
% rotation 0
doa=doa3;
dir='\pat\r135';
hf=smModel( op, ed, al, doa, dod, phase, toa, dir );
bfModel( hf, dir );
bfEigModel( hf, dir );
smh2Model( op, ed, al, doa, dod, phase, toa, dir );
smh4Model( op, ed, al, doa, dod, phase, toa, dir );
toc
