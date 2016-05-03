% Implementing all models with and without antenna element pattern
% This file should be run under the files directions
% MIMO case: tx - 8x4  rx - 1x8 
clc;clear all; close all;
tic
% generateData;
los=58;
load rayAm
load doa
load dod
%% =============================  BF Model  ==============================|
% x-----------------------------------------------------------------------x
% x----------------------Antenna element pattern iso ---------------------x
% x-----------------------------------------------------------------------x
al=al; % Isotropic antenna plane wave are the same for all rotation
% rotation 0
doa=doa;
bfModel( los, al, doa, dod, phase, toa, '\iso\r0' );

%%
tl=10;
htdb=mag2db(abs(sum(ht,2)));

figure
plot(tau,htdb(:,:,tl))
hold on
plot(toa(:,:,tl),mag2db(abs(al(:,:,tl))),'o')
% hold on
% plot(toa(:,:,20),mag2db(abs(sum(am(:,:,20),2))),'x')
%%
amt=sum(am,2);
figure
plot(toa(:,:,tl),mag2db(abs(amt(:,:,tl))),'x')
hold on
plot(toa(:,:,tl),mag2db(abs(al(:,:,tl))),'o')
%%
for w=1:rxN
    hfal(:,:,w)=pw2hf(al(:,:,w), toa(:,:,w), fc, bw, Nf);
end
htaldb=mag2db(abs(ifft(hfal)));

%%
for w=1:rxN
    hfam(:,:,w)=pw2hf(sum(am(:,:,w),2), toa(:,:,w), fc, bw, Nf);
end
htamdb=pow2db(abs(ifft(hfam)));

%%
figure
% plot(tau,Htdb(:,tl))
% hold on
plot(tau, htaldb(:,:,tl))
hold on
plot(tau, htamdb(:,:,tl))
%%
for w=1:rxN
    hfam1(:,:,w)=pw2hf(am(:,:,w), toa(:,:,w), fc, bw, Nf);
end
% htamdb1=pow2db(sum(abs(ifft(hfam1)).^2,2));

%% plot(tau,Htdb(:,tl))
% hold on
htamdb1=pow2db(sum(abs(ifft(hfam1)).^2,2));
figure
plot(tau, htaldb(:,:,tl))
hold on
plot(tau, htamdb1(:,:,tl),'--')
hold on
plot(tau, htamdb(:,:,tl),'.')

%%

array=array_tx;
dir=dir_tx(:,:,w);
c=3e8;  % Light speed
lambda=c/fc; % wavelength
d=zeros(array);
phi=degtorad(dir(:,1));
theta=degtorad(dir(:,2));
phi=phi(:).';
theta=theta(:).';
an=prod(array);

[x, y, z]=ind2sub(size(d),find(d==0));
x=x(:);
y=y(:);
z=z(:);
dt=[(x-1) (y-1) (z-1)]*lambda/2;
dx=dt(:,1);
dy=dt(:,2);
dz=dt(:,3);
% Make sure dx dy dz are column vectors here
dx=dx(:);
dy=dy(:);
dz=dz(:);
% Steering vector
bn=exp(-1j*2*pi*dx*(sin(theta).*cos(phi))/lambda).*exp(-1j*2*pi*dy*(sin(theta).*sin(phi))/lambda).*exp(-1j*2*pi*dz*cos(theta)/lambda);
% Find the largest received power
%%
alste=alt_tx*bn;
powste=mag2db(abs(sum(alste,1)));
% [~,ind]=max(powste);
powste=powste(:).';
tn=[bn; powste].';
tn=sortrows(tn,an+1);
%%
Nb=1;
tn=tn(1:Nb,:);
tn(:,end)=[];
% outdata=bn(:,ind);
% outdata=sum(tn,1);
outdata=tn;