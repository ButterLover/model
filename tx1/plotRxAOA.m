%% Multiplexing Rx position
clear all;
close all;
load position
str=pwd;
rx1i=[ 10 19 44 67];
rx2i=[82 90 114 122];
op=1;
ed=132;

load(strcat(str,'\mulR.mat'))
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
saveas(gcf,'chRaoa2Dlos#1','png')

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
saveas(gcf,'chRaoa2Dlos#2','png')

%% Angular spread
load('rayAm.mat', 'al', 'toa')
load('doa.mat')
load('dod.mat')

rxi=[ 10 19 44 67 82 90 114 122];
cmin=-180;
% plot AOA AOD 1
for w=1:8
    dot_size=12;
    rxl=rxi(w);
    al_t=flipud(al(:,:,rxl));   % Plot the largest value latest
    cmax=max(al_t);
    toa_t=flipud(toa(:,:,rxl));
    doa_phi=flipud(doa(:, 1, rxl));
    dod_phi=flipud(dod(:, 1,rxl));
    figure
    subplot(2,1,1);
    scatter(toa_t, doa_phi, dot_size, al_t, 'filled')
    colormap jet
    grid on
    caxis([cmin cmax])
    h=colorbar;
    xlim([0 inf]);
    tStr=strcat('Rx #', num2str(rxl));
    title(tStr);
    xlabel('Delay [s]');ylabel('AOA [deg]');
    h.Label.String='Received power [dBm]';
    subplot(2, 1, 2);
    scatter(toa_t, dod_phi, dot_size, al_t, 'filled')
    colormap jet
    grid on
    caxis([cmin cmax])
    h=colorbar;
    xlim([0 inf]);
    h.Label.String='Received power [dBm]';
    xlabel('Delay [s]');ylabel('AOD [deg]');
    saveas(gcf, strcat('aoa', tStr), 'png')
end
% %
% w=2;
% dot_size=12;
% rxl=rxi(w);
% al_t=flipud(al(:,:,rxl));   % Plot the largest value latest
% cmax=max(al_t);
% toa_t=flipud(toa(:,:,rxl));
% doa_phi=flipud(doa(:, 1, rxl));
% dod_phi=flipud(dod(:, 1,rxl));
% figure
% subplot(2,1,1);
% scatter(toa_t, doa_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% tStr=strcat('Rx #', num2str(rxl));
% title(tStr);
% xlabel('Delay [s]');ylabel('AOA [deg]');
% h.Label.String='Received power [dBm]';
% subplot(2, 1, 2);
% scatter(toa_t, dod_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% h.Label.String='Received power [dBm]';
% xlabel('Delay [s]');ylabel('AOD [deg]');
% 
% w=3;
% dot_size=12;
% rxl=rxi(w);
% al_t=flipud(al(:,:,rxl));   % Plot the largest value latest
% cmax=max(al_t);
% toa_t=flipud(toa(:,:,rxl));
% doa_phi=flipud(doa(:, 1, rxl));
% dod_phi=flipud(dod(:, 1,rxl));
% figure
% subplot(2,1,1);
% scatter(toa_t, doa_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% tStr=strcat('Rx #', num2str(rxl));
% title(tStr);
% xlabel('Delay [s]');ylabel('AOA [deg]');
% h.Label.String='Received power [dBm]';
% subplot(2, 1, 2);
% scatter(toa_t, dod_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% h.Label.String='Received power [dBm]';
% xlabel('Delay [s]');ylabel('AOD [deg]');
% 
% w=4;
% dot_size=12;
% rxl=rxi(w);
% al_t=flipud(al(:,:,rxl));   % Plot the largest value latest
% cmax=max(al_t);
% toa_t=flipud(toa(:,:,rxl));
% doa_phi=flipud(doa(:, 1, rxl));
% dod_phi=flipud(dod(:, 1,rxl));
% figure
% subplot(2,1,1);
% scatter(toa_t, doa_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% tStr=strcat('Rx #', num2str(rxl));
% title(tStr);
% xlabel('Delay [s]');ylabel('AOA [deg]');
% h.Label.String='Received power [dBm]';
% subplot(2, 1, 2);
% scatter(toa_t, dod_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% h.Label.String='Received power [dBm]';
% xlabel('Delay [s]');ylabel('AOD [deg]');
% 
% w=5;
% 
% dot_size=12;
% rxl=rxi(w);
% al_t=flipud(al(:,:,rxl));   % Plot the largest value latest
% cmax=max(al_t);
% toa_t=flipud(toa(:,:,rxl));
% doa_phi=flipud(doa(:, 1, rxl));
% dod_phi=flipud(dod(:, 1,rxl));
% figure
% subplot(2,1,1);
% scatter(toa_t, doa_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% tStr=strcat('Rx #', num2str(rxl));
% title(tStr);
% xlabel('Delay [s]');ylabel('AOA [deg]');
% h.Label.String='Received power [dBm]';
% subplot(2, 1, 2);
% scatter(toa_t, dod_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% h.Label.String='Received power [dBm]';
% xlabel('Delay [s]');ylabel('AOD [deg]');
% 
% w=6;
% dot_size=12;
% rxl=rxi(w);
% al_t=flipud(al(:,:,rxl));   % Plot the largest value latest
% cmax=max(al_t);
% toa_t=flipud(toa(:,:,rxl));
% doa_phi=flipud(doa(:, 1, rxl));
% dod_phi=flipud(dod(:, 1,rxl));
% figure
% subplot(2,1,1);
% scatter(toa_t, doa_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% tStr=strcat('Rx #', num2str(rxl));
% title(tStr);
% xlabel('Delay [s]');ylabel('AOA [deg]');
% h.Label.String='Received power [dBm]';
% subplot(2, 1, 2);
% scatter(toa_t, dod_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% h.Label.String='Received power [dBm]';
% xlabel('Delay [s]');ylabel('AOD [deg]');
% 
% w=7;
% dot_size=12;
% rxl=rxi(w);
% al_t=flipud(al(:,:,rxl));   % Plot the largest value latest
% cmax=max(al_t);
% toa_t=flipud(toa(:,:,rxl));
% doa_phi=flipud(doa(:, 1, rxl));
% dod_phi=flipud(dod(:, 1,rxl));
% figure
% subplot(2,1,1);
% scatter(toa_t, doa_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% tStr=strcat('Rx #', num2str(rxl));
% title(tStr);
% xlabel('Delay [s]');ylabel('AOA [deg]');
% h.Label.String='Received power [dBm]';
% subplot(2, 1, 2);
% scatter(toa_t, dod_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% h.Label.String='Received power [dBm]';
% xlabel('Delay [s]');ylabel('AOD [deg]');
% 
% w=8;
% dot_size=12;
% rxl=rxi(w);
% al_t=flipud(al(:,:,rxl));   % Plot the largest value latest
% cmax=max(al_t);
% toa_t=flipud(toa(:,:,rxl));
% doa_phi=flipud(doa(:, 1, rxl));
% dod_phi=flipud(dod(:, 1,rxl));
% figure
% subplot(2,1,1);
% scatter(toa_t, doa_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% tStr=strcat('Rx #', num2str(rxl));
% title(tStr);
% xlabel('Delay [s]');ylabel('AOA [deg]');
% h.Label.String='Received power [dBm]';
% subplot(2, 1, 2);
% scatter(toa_t, dod_phi, dot_size, al_t, 'filled')
% colormap jet
% grid on
% caxis([cmin cmax])
% h=colorbar; xlim([0 inf]);
% h.Label.String='Received power [dBm]';
% xlabel('Delay [s]');ylabel('AOD [deg]');
