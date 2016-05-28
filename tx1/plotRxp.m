%% Received power
clear all;
% close all;
load position
cmin=-180;
cmax=-30;
str=pwd;
% Directional beamforming
op=1;
ed=968;
load(strcat(str,'\bfModel\iso\r0\rxPowerMIMO.mat'))
a=10;
x=x(op:ed);
y=y(op:ed);
c=rxP(op:ed);
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
load(strcat(str,'\bfEigModel\iso\r0\rxPowerMIMO.mat'))
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
load(strcat(str,'\smModel\iso\r0\rxPowerMIMO.mat'))
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
load(strcat(str,'\smh4Model\iso\r0\rxPowerMIMO.mat'))
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
load(strcat(str,'\smh2Model\iso\r0\rxPowerMIMO.mat'))
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