function [ outdata ] = disCal( indata,Tx )
%DISCAL Summary of this function goes here
%  Tx is the transmitter coordinate [x,y,z]
% Initialization
% clc; clear all; close all;
% h=importdata( 'Tx1Rx2pathLoss28.txt');
% indata=h.data;
%%
data=indata;
% Coordinate of Tx
% xo=-114.76;
% yo=-87.2825;
% zo=19.4894;
xo=Tx(1);
yo=Tx(2);
zo=Tx(3);
% Calculating distance
dis=sqrt((data(:,2)-xo).^2+(data(:,3)-yo).^2+(data(:,4)-zo).^2);
% %%
% Ldb=0-data(:,6);
% % Plot path loss with distance
% figure
% plot(dis, Ldb);
% grid on 
% xlabel('Distance [m]');ylabel('Path loss [dB]');
% title('Path loss of simulation results 15GHz');
outdata=dis;
end

