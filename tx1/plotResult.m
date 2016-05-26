load position
load mulR
%% Channel richness

% LOS1
op=1;
ed=58;
figure
subplot(2,1,1)
plot(mul(op:ed),'-o')
grid on
xlabel('Rx index');ylabel('Channel richness');

% richness 2d map
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\mulR.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=mul(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
% caxis([cmin cmax])
h.Label.String='Channel multiplexing richness';
legend('Tx','Rx')
grid on
xlabel('x [m]');ylabel('y [m]')

%% Multiplexing Rx position
rx1i=[ 10 19 44 67];
rx2i=[82 90 114 122];
op=1;
ed=132;

load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\mulR.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=mul(op:ed);
figure
plot(tx(1),tx(2),'x');
% text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
for w=1:length(rx1i)
    rxt=rx1i(w);
    tstr=strcat('Rx #',num2str(rxt),'\rightarrow ');
    text(x(rxt),y(rxt),tstr,'HorizontalAlignment','right')
end
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
% caxis([cmin cmax])
h.Label.String='Channel multiplexing richness';
legend('Tx','Rx')
grid on
xlabel('x [m]');ylabel('y [m]')

figure
plot(tx(1),tx(2),'x');
% text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
for w=1:length(rx1i)
    rxt=rx2i(w);
    tstr=strcat('Rx #',num2str(rxt),'\rightarrow ');
    text(x(rxt),y(rxt),tstr,'HorizontalAlignment','right')
end
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
% caxis([cmin cmax])
h.Label.String='Channel multiplexing richness';
legend('Tx','Rx')
grid on
xlabel('x [m]');ylabel('y [m]')
%% Capacity compare los1
op=1;
ed=58;
% dir BF
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r90\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\pat\r0\capacity.mat')
plot(cp(op:ed),'--')
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\pat\r90\capacity.mat')
plot(cp(op:ed),'--')
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');
% dominant eigenmode
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r90\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\pat\r0\capacity.mat')
plot(cp(op:ed),'--')
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\pat\r90\capacity.mat')
plot(cp(op:ed),'--')
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');
% 8x32 sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r90\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\pat\r0\capacity.mat')
plot(cp(op:ed),'--')
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\pat\r90\capacity.mat')
plot(cp(op:ed),'--')
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');
% 4x32 Hybrid sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r90\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\pat\r0\capacity.mat')
plot(cp(op:ed),'--')
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\pat\r90\capacity.mat')
plot(cp(op:ed),'--')
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');
% 2x32 Hybrid sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r90\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\pat\r0\capacity.mat')
plot(cp(op:ed),'--')
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\pat\r90\capacity.mat')
plot(cp(op:ed),'--')
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');

%% Capacity CDF LOS ant
op=1;
ed=132;
% dir BF
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\pat\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\pat\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
xlabel('Capacity [bps/hz]');
% dominant eigenmode
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\pat\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\pat\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
xlabel('Capacity [bps/hz]');
% 8x32 sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\pat\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\pat\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
xlabel('Capacity [bps/hz]');
% 4x32 Hybrid sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\pat\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\pat\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
xlabel('Capacity [bps/hz]');
% 2x32 Hybrid sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\pat\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\pat\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
xlabel('Capacity [bps/hz]');

%% BF Capacity CDF NLOS ant
op=133;
ed=968;
% dir BF
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\pat\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\pat\r90\capacity.mat')
cdfplot(cp(op:ed))
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');
% dominant eigenmode
%% Capacity CDF LOS iso r0
op=1;
ed=132;
% 8x32 sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
xlabel('Capacity [bps/hz]');
legend( 'Directional BF','Dominant eigenmode');
title('Isotropic element without rotation LOS capacity empirical CDF');
% 8x32 sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
xlabel('Capacity [bps/hz]');
legend( 'Directional BF','Dominant eigenmode', '8x32 SM');
title('Isotropic element without rotation LOS capacity empirical CDF');
% 4x32 hybrid sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
xlabel('Capacity [bps/hz]');
legend( 'Directional BF','Dominant eigenmode', '8x32 SM', '4x32 hybrid SM');
title('Isotropic element without rotation LOS capacity empirical CDF');
% 2x32 hybrid sm
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
xlabel('Capacity [bps/hz]');
legend( 'Directional BF','Dominant eigenmode', '8x32 SM', '4x32 hybrid SM', '2x32 hybrid SM');
title('Isotropic element without rotation LOS capacity empirical CDF');

%% Capacity CDF NLOS iso r0
op=133;
ed=968;
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r0\capacity.mat')
cdfplot(cp(op:ed))
xlabel('Capacity [bps/hz]');
legend('Directional BF', 'Dominant eigenmode',  '8x32 SM', '4x32 hybrid SM', '2x32 SM');
title('Isotropic element without rotation NLOS capacity empirical CDF');

%% capacity 2D map all
cmin=0;
cmax=40;
% Pure directional BF
op=133;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
caxis([cmin cmax])
h.Label.String='Capacity [bps/Hz]';
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Directional beamforming capacity');
% axis([-210 50 -275 25]);

% Dominant eigenmode
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Capacity [bps/Hz]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
axis([-210 50 -275 25]);
title('Dominant eigenmode capacity');

% 8x32 SM
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Capacity [bps/Hz]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Spatial multiplexing 8x32 capacity');
axis([-210 50 -275 25]);
% set(gca,'ydir','normal');

% 4x32 hybrid SM
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\capacity.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Capacity [bps/Hz]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
axis([-210 50 -275 25]);
title('Hybrid spatial multiplexing 4x32 capacity');

% 2x32 hybrid SM
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\capacity.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Capacity [bps/Hz]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
axis([-210 50 -275 25]);
title('Hybrid spatial multiplexing 2x32 capacity');
%% SM PDP of the LOS2 last Rx
fc=15e9;
% bw=1e9; % System bandwidth
bw=800e6;
Nf=801;
ft=bw/(Nf-1);   % Frequency spacing between two bins
% f=fc-bw/2:ft:fc+bw/2;   % Frequency range
tau=0:1/bw:1/ft;    % Calculating delay
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\channelMatrix.mat', 'hf_los')
hft=hf_los(:,:,82);
htt=ifft(hft);
pdp=pow2db(squeeze(sum(abs(htt).^2,2)));
figure
plot(tau, pdp)
hold on
plot(tau, -105*ones(801,1)-31.5,'--')
grid on
xlabel('Time delay [s]');ylabel('PDP [dB]');
%% Angular spread
load('rayAm.mat', 'al', 'toa')
load('doa.mat')
load('dod.mat')

rxi=[ 10 19 44 67 82 90 114 122];
cmin=-180;
% plot AOA AOD 1
w=1;
rxl=rxi(w);
al_t=al(:,:,rxl);
cmax=max(al_t);
toa_t=toa(:,:,rxl);
doa_phi=doa(:, 1, rxl);
dod_phi=dod(:, 1,rxl);
figure
subplot(2,1,1);
scatter(toa_t, doa_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
tStr=strcat('Rx #', num2str(rxl));
title(tStr);
xlabel('Delay [s]');ylabel('AOA [deg]');
h.Label.String='Received power [dBm]';
subplot(2, 1, 2);
scatter(toa_t, dod_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
h.Label.String='Received power [dBm]';
xlabel('Delay [s]');ylabel('AOD [deg]');
% plot AOA AOD 2
w=2;
rxl=rxi(w);
al_t=al(:,:,rxl);
cmax=max(al_t);
toa_t=toa(:,:,rxl);
doa_phi=doa(:, 1, rxl);
dod_phi=dod(:, 1,rxl);
figure
subplot(2,1,1);
scatter(toa_t, doa_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
tStr=strcat('Rx #', num2str(rxl));
title(tStr);
xlabel('Delay [s]');ylabel('AOA [deg]');
h.Label.String='Received power [dBm]';
subplot(2, 1, 2);
scatter(toa_t, dod_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
h.Label.String='Received power [dBm]';
xlabel('Delay [s]');ylabel('AOD [deg]');
% plot AOA AOD 3
w=3;
rxl=rxi(w);
al_t=al(:,:,rxl);
cmax=max(al_t);
toa_t=toa(:,:,rxl);
doa_phi=doa(:, 1, rxl);
dod_phi=dod(:, 1,rxl);
figure
subplot(2,1,1);
scatter(toa_t, doa_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
tStr=strcat('Rx #', num2str(rxl));
title(tStr);
xlabel('Delay [s]');ylabel('AOA [deg]');
h.Label.String='Received power [dBm]';
subplot(2, 1, 2);
scatter(toa_t, dod_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
h.Label.String='Received power [dBm]';
xlabel('Delay [s]');ylabel('AOD [deg]');
% plot AOA AOD 4
w=4;
rxl=rxi(w);
al_t=al(:,:,rxl);
cmax=max(al_t);
toa_t=toa(:,:,rxl);
doa_phi=doa(:, 1, rxl);
dod_phi=dod(:, 1,rxl);
figure
subplot(2,1,1);
scatter(toa_t, doa_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
tStr=strcat('Rx #', num2str(rxl));
title(tStr);
xlabel('Delay [s]');ylabel('AOA [deg]');
h.Label.String='Received power [dBm]';
subplot(2, 1, 2);
scatter(toa_t, dod_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
h.Label.String='Received power [dBm]';
xlabel('Delay [s]');ylabel('AOD [deg]');

% plot AOA AOD 5
w=5;
rxl=rxi(w);
al_t=al(:,:,rxl);
cmax=max(al_t);
toa_t=toa(:,:,rxl);
doa_phi=doa(:, 1, rxl);
dod_phi=dod(:, 1,rxl);
figure
subplot(2,1,1);
scatter(toa_t, doa_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
tStr=strcat('Rx #', num2str(rxl));
title(tStr);
xlabel('Delay [s]');ylabel('AOA [deg]');
h.Label.String='Received power [dBm]';
subplot(2, 1, 2);
scatter(toa_t, dod_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
h.Label.String='Received power [dBm]';
xlabel('Delay [s]');ylabel('AOD [deg]');

% plot AOA AOD 6
w=6;
rxl=rxi(w);
al_t=al(:,:,rxl);
cmax=max(al_t);
toa_t=toa(:,:,rxl);
doa_phi=doa(:, 1, rxl);
dod_phi=dod(:, 1,rxl);
figure
subplot(2,1,1);
scatter(toa_t, doa_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
tStr=strcat('Rx #', num2str(rxl));
title(tStr);
xlabel('Delay [s]');ylabel('AOA [deg]');
h.Label.String='Received power [dBm]';
subplot(2, 1, 2);
scatter(toa_t, dod_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
h.Label.String='Received power [dBm]';
xlabel('Delay [s]');ylabel('AOD [deg]');

% plot AOA AOD 7
w=7;
rxl=rxi(w);
al_t=al(:,:,rxl);
cmax=max(al_t);
toa_t=toa(:,:,rxl);
doa_phi=doa(:, 1, rxl);
dod_phi=dod(:, 1,rxl);
figure
subplot(2,1,1);
scatter(toa_t, doa_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
tStr=strcat('Rx #', num2str(rxl));
title(tStr);
xlabel('Delay [s]');ylabel('AOA [deg]');
h.Label.String='Received power [dBm]';
subplot(2, 1, 2);
scatter(toa_t, dod_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
h.Label.String='Received power [dBm]';
xlabel('Delay [s]');ylabel('AOD [deg]');

% plot AOA AOD 8
w=8;
rxl=rxi(w);
al_t=al(:,:,rxl);
cmax=max(al_t);
toa_t=toa(:,:,rxl);
doa_phi=doa(:, 1, rxl);
dod_phi=dod(:, 1,rxl);
figure
subplot(2,1,1);
scatter(toa_t, doa_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
tStr=strcat('Rx #', num2str(rxl));
title(tStr);
xlabel('Delay [s]');ylabel('AOA [deg]');
h.Label.String='Received power [dBm]';
subplot(2, 1, 2);
scatter(toa_t, dod_phi, 8, al_t, 'filled')
colormap jet
grid on
caxis([cmin cmax])
h=colorbar;
h.Label.String='Received power [dBm]';
xlabel('Delay [s]');ylabel('AOD [deg]');

%% LOS1 cap compare
op=1;
ed=58;
% Dir BF
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r90\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\pat\r0\capacity.mat')
plot(cp(op:ed),'--')
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\pat\r90\capacity.mat')
plot(cp(op:ed),'--')
hold on
grid on
legend('Iso r=0', 'Iso r=90','Patch r=0','Patch r=90');
xlabel('Rx index');ylabel('Capacity [bps/Hz]');

%% Received power
cmin=-180;
cmax=-30;
% Directional beamforming
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rxPowerMIMO.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=rxP(op:ed)+31.5;
% c=rxP(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Received power [dBm]';
caxis([cmin cmax])
% axis([-210 50 -275 25]);
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
% title('Directional beamforming received power');

% Dominant eigenmode
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rxPowerMIMO.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=rxP(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Received power [dBm]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Dominant eigenmode received power');


% 8x32 SM
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\rxPowerMIMO.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=rxP(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Received power [dBm]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Spatial multiplexing 8x32 received power');


% 4x32 hybrid SM
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\rxPowerMIMO.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=rxP(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Received power [dBm]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Hybrid spatial multiplexing 4x32 received power');

% 2x32 hybrid SM
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r0\rxPowerMIMO.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=rxP(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Received power [dBm]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Hybrid Spatial multiplexing 2x32 received power');
%% Delay spread

% Directional beamforming
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rmsDelay.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=st(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Delay spread [s]';
% caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Directional beamforming delay spread');

% Dominant eigenmode
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rmsDelay.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=st(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Delay spread [s]';
% caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Dominant eigenmode delay spread');


% 8x32 SM
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\rmsDelay.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=st(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Delay spread [s]';
% caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Spatial multiplexing 8x32 delay spread');


% 4x32 hybrid SM
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\rmsDelay.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=st(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Delay spread [s]';
% caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Hybrid spatial multiplexing 4x32 delay spread');

% 2x32 hybrid SM
op=1;
ed=968;
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r0\rmsDelay.mat')
a=10;
x=x(op:ed);
y=y(op:ed);
c=st(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
h.Label.String='Delay spread [s]';
% caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Hybrid Spatial multiplexing 2x32 delay spread');

%% LOS1 capacity compare
op=1;
ed=58;
% Dominant eigenmode
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
plot(cp(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode')
xlabel('Rx index');ylabel('Capacity [bps/Hz]')

% 8x32 SM
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
plot(cp(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM')
xlabel('Rx index');ylabel('Capacity [bps/Hz]')

% 4x32 hyrid SM
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\capacity.mat')
plot(cp(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM','4x32 hybrid SM')
xlabel('Rx index');ylabel('Capacity [bps/Hz]')

% 2x32 hyrid SM
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\capacity.mat')
plot(cp(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r0\capacity.mat')
plot(cp(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM','4x32 hybrid SM','2x32 hybrid SM')
xlabel('Rx index');ylabel('Capacity [bps/Hz]')
%% LOS1 rxP compare
op=1;
ed=58;
% Dominant eigenmode
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode')
xlabel('Rx index');ylabel('Received power [dBm]')

% 8x32 SM
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM')
xlabel('Rx index');ylabel('Received power [dBm]')

% 4x32 hyrid SM
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM','4x32 hybrid SM')
xlabel('Rx index');ylabel('Received power [dBm]')

% 2x32 hyrid SM
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r0\rxPowerMIMO.mat')
plot(rxP(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM','4x32 hybrid SM','2x32 hybrid SM')
xlabel('Rx index');ylabel('Received power [dBm]')

%% LOS1 delay spread compare
op=1;
ed=58;
% Dominant eigenmode
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rmsDelay.mat')
plot(st(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode')
xlabel('Rx index');ylabel('Delay spread [s]')

% 8x32 SM
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\rmsDelay.mat')
plot(st(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM')
xlabel('Rx index');ylabel('Delay spread [s]')

% 4x32 hyrid SM
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\rmsDelay.mat')
plot(st(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM','4x32 hybrid SM')
xlabel('Rx index');ylabel('Delay spread [s]')

% 2x32 hyrid SM
figure
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfModel\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\bfEigModel\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smModel\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh4Model\iso\r0\rmsDelay.mat')
plot(st(op:ed))
hold on
load('C:\Users\NI\Documents\MATLAB\thesis\outdoor15G0403\tx1\smh2Model\iso\r0\rmsDelay.mat')
plot(st(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM','4x32 hybrid SM','2x32 hybrid SM')
xlabel('Rx index');ylabel('Delay spread [s]')