% Implementing all models with and without antenna element pattern
% This file should be run under the files directions
% MIMO case: tx - 8x4  rx - 1x8 
clc;clear all; close all;
tic
% generateData;
op=1;
ed=132;
load rayAm
load doa
load dod
doa0=doa;
al0=al;
%% =============================  SM Model  ==============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0; % Isotropic antenna plane wave are the same for all rotation
% rotation 0
doa=doa0;
hf=smModel( op, ed, al, doa, dod, phase, toa, '\iso\r0' );
% %% =============================  BF Model  ==============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
% al=al0; % Isotropic antenna plane wave are the same for all rotation
% % rotation 0
% doa=doa0;
bfModel( hf, '\iso\r0' );
bfEigModel( hf, '\iso\r0' );
%%
% % rotation 45
% doa=doa1;
% bfModel( los, al, doa, dod, phase, toa, '\iso\r45' );
% rotation 90
doa=doa2;
bfModel( los, al, doa, dod, phase, toa, '\iso\r90' );
% % rotation 135
% doa=doa3;
% bfModel( los, al, doa, dod, phase, toa, '\iso\r135' );
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern patch--------------------x
% x-----------------------------------------------------------------------x
% rotation 0
al=al_pat;
doa=doa0;
bfModel( los, al, doa, dod, phase, toa, '\patch\r0' );
% % rotation 45
% al=al_pat1;
% doa=doa1;
% bfModel( los, al, doa, dod, phase, toa, '\patch\r45' );
% rotation 90
al=al_pat2;
doa=doa2;
bfModel( los, al, doa, dod, phase, toa, '\patch\r90' );
% % rotation 135
% al=al_pat3;
% doa=doa3;
% bfModel( los, al, doa, dod, phase, toa, '\patch\r135' );
%% ============================   SM 2x4  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0;
% rotation 0
doa=doa0;
sm2x4Model( los, al, doa, dod, phase, toa, '\iso\r0' );
% % rotation 45
% doa=doa1;
% sm2x4Model( los, al, doa, dod, phase, toa, '\iso\r45' );
% % rotation 90
% doa=doa2;
% sm2x4Model( los, al, doa, dod, phase, toa, '\iso\r90' );
% % rotation 135
% doa=doa3;
% sm2x4Model( los, al, doa, dod, phase, toa, '\iso\r135' );
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern patch--------------------x
% x-----------------------------------------------------------------------x
% rotation 0
al=al_pat;
doa=doa0;
sm2x4Model( los, al, doa, dod, phase, toa, '\patch\r0' );
% % rotation 45
% al=al_pat1;
% doa=doa1;
% sm2x4Model( los, al, doa, dod, phase, toa, '\patch\r45' );
% % rotation 90
% al=al_pat2;
% doa=doa2;
% sm2x4Model( los, al, doa, dod, phase, toa, '\patch\r90' );
% % rotation 135
% al=al_pat3;
% doa=doa3;
% sm2x4Model( los, al, doa, dod, phase, toa, '\patch\r135' );
%% =============================  SM 4x2  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0;
% rotation 0
doa=doa0;
sm4x2Model( los, al, doa, dod, phase, toa, '\iso\r0' );
% % rotation 45
% doa=doa1;
% sm4x2Model( los, al, doa, dod, phase, toa, '\iso\r45' );
% % rotation 90
% doa=doa2;
% sm4x2Model( los, al, doa, dod, phase, toa, '\iso\r90' );
% % rotation 135
% doa=doa3;
% sm4x2Model( los, al, doa, dod, phase, toa, '\iso\r135' );
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern patch--------------------x
% x-----------------------------------------------------------------------x
% rotation 0
al=al_pat;
doa=doa0;
sm4x2Model( los, al, doa, dod, phase, toa, '\patch\r0' );
% % rotation 45
% al=al_pat1;
% doa=doa1;
% sm4x2Model( los, al, doa, dod, phase, toa, '\patch\r45' );
% % rotation 90
% al=al_pat2;
% doa=doa2;
% sm4x2Model( los, al, doa, dod, phase, toa, '\patch\r90' );
% % rotation 135
% al=al_pat3;
% doa=doa3;
% sm4x2Model( los, al, doa, dod, phase, toa, '\patch\r135' );
%% =============================  SM 8x8  ================================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al0;
% rotation 0
doa=doa0;
sm8x8Model( los, al, doa, dod, phase, toa, '\iso\r0' );
% % rotation 45
% doa=doa1;
% sm8x8Model( los, al, doa, dod, phase, toa, '\iso\r45' );
% % rotation 90
% doa=doa2;
% sm8x8Model( los, al, doa, dod, phase, toa, '\iso\r90' );
% % rotation 135
% doa=doa3;
% sm8x8Model( los, al, doa, dod, phase, toa, '\iso\r135' );
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern patch--------------------x
% x-----------------------------------------------------------------------x
% rotation 0
al=al_pat;
doa=doa0;
sm8x8Model( los, al, doa, dod, phase, toa, '\patch\r0' );
% % rotation 45
% al=al_pat1;
% doa=doa1;
% sm8x8Model( los, al, doa, dod, phase, toa, '\patch\r45' );
% % rotation 90
% al=al_pat2;
% doa=doa2;
% sm8x8Model( los, al, doa, dod, phase, toa, '\patch\r90' );
% % rotation 135
% al=al_pat3;
% doa=doa3;
% sm8x8Model( los, al, doa, dod, phase, toa, '\patch\r135' );
toc