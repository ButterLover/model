% Generating needed data, including doa, dod, plane wave, prx(received
% power), toa, phase, rx positions, tx-rx distance,
% 
% 
clc;clear all; close all;
tic
str_cir='*.cir.*';
str_dod='*.dod.*';
str_doa='*.doa.*';
rayN=200;
colN=4;
% 4th dimension is Tx
cir4d=p2mConSIMO(str_cir,rayN,colN);
dod4d=p2mConSIMO(str_dod,rayN,colN);
doa4d=p2mConSIMO(str_doa,rayN,colN);

cir=[];
doa=[];
dod=[];
for w=1:length(cir4d)
    cir=cat(3, cir, cir4d{w});
    doa=cat(3, doa, doa4d{w});
    dod=cat(3, dod, dod4d{w});
end
clear cir4d doa4d dod4d
al=cir(:,4,:);
toa=cir(:,3,:);
phase=cir(:,2,:);
doa=doa(:,2:3,:);
dod=dod(:,2:3,:);
% Rx rotation
doa1=doa;
doa2=doa;
doa3=doa;
phi=doa(:,1,:)+45;
phi(phi>180)=mod(phi(phi>180),-180);
phi(phi<-180)=mod(phi(phi<-180),180);
doa1(:,1,:)=phi;
phi=doa(:,1,:)+90;
phi(phi>180)=mod(phi(phi>180),-180);
phi(phi<-180)=mod(phi(phi<-180),180);
doa2(:,1,:)=phi;
phi=doa(:,1,:)+135;
phi(phi>180)=mod(phi(phi>180),-180);
phi(phi<-180)=mod(phi(phi<-180),180);
doa3(:,1,:)=phi;
% Tx rotation, parallel with street
phi=dod(:,1,:)+45;
phi(phi>180)=mod(phi(phi>180),-180);
phi(phi<-180)=mod(phi(phi<-180),180);
dod(:,1,:)=phi;
%%
str_power='*.power*';
di=dir(str_power);
tx1=[-114.76 -87.2825 19.4894];
tx=tx1;
% tx2=[-38.0595 -80.071 23];
numfiles=length(di);
outdata=[];
for w=1:numfiles
    receivedPower{w}=importdata(di(w).name);
    outdata=[outdata; receivedPower{w}.data] ;
end
x=outdata(:,2);
y=outdata(:,3);
z=outdata(:,4);
prx=outdata(:,6);
dis=sqrt(abs(x-tx(1)).^2+abs(y-tx(2)).^2+abs(z-tx(3)).^2);
% dis2=sqrt(abs(x-tx2(1)).^2+abs(y-tx2(2)).^2+abs(z-tx2(3)).^2);

%% Adding patch antenna pattern
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
% Plane wave without rotation
phi_rx=round(doa(:,1,:)/2)+90;
phi_rx(phi_rx==0)=1;
ind=sub2ind(size(patch),theta_rx, phi_rx);
al_pat=mag2db(abs(al_lin.*patch(ind)));
% Plane wave with 45 rotation
phi=round(doa1(:,1,:)/2)+90;
phi(phi==0)=1;
ind=sub2ind(size(patch),theta_rx, phi);
al_pat1=mag2db(abs(al_lin.*patch(ind)));
% Plane wave with 90 rotation
phi=round(doa2(:,1,:)/2)+90;
phi(phi==0)=1;
ind=sub2ind(size(patch),theta_rx, phi);
al_pat2=mag2db(abs(al_lin.*patch(ind)));
% Plane wave with 135 rotation
phi=round(doa3(:,1,:)/2)+90;
phi(phi==0)=1;
ind=sub2ind(size(patch),theta_rx, phi);
al_pat3=mag2db(abs(al_lin.*patch(ind)));
%%
save position x y tx dis
save dod dod    % dod is rotated 45 degree
save doa doa doa*
save rayAm al al_pat* phase toa
save rxPower prx    % Received power of isotropic SISO
%% Multiplexing richness
ind=al>-110;
mul=sum(ind,1);
mul=mul(:);
save mulR mul
toc