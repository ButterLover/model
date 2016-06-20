%% Received power
clear all;
close all;
load position
cmin=-120;
cmax=-40;
str=pwd;

%% Total received power 2D map
op=1;
ed=968;
% Directional beamforming
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
% colormap jet
colormap hot
colormap(flipud(colormap))
h=colorbar;
h.Label.String='Received power [dBm]';
caxis([cmin cmax])
% axis([-210 50 -275 25]);
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
saveas( gcf, 'cov15G', 'png')
title('Directional beamforming received power');
% saveas(gcf,'rxP2Dbf','png')

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
% colormap jet
colormap hot
colormap(flipud(colormap))
h=colorbar;
h.Label.String='Received power [dBm]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Dominant eigenmode received power');
saveas(gcf,'rxP2DdetISO','png')


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
% colormap jet
colormap hot
colormap(flipud(colormap))
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
% colormap jet
colormap hot
colormap(flipud(colormap))
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
% colormap jet
colormap hot
colormap(flipud(colormap))
h=colorbar;
h.Label.String='Received power [dBm]';
caxis([cmin cmax])
grid on
legend('Tx','Rx')
xlabel('x [m]');ylabel('y [m]')
title('Hybrid Spatial multiplexing 2x32 received power');

%% Total received power with distance
op=1;
ed=132;
load(strcat(str,'\bfModel\iso\r0\rxPowerMIMO.mat'))
d=dis(op:ed);
c=rxP(op:ed);
figure
plot(d, c, 'x');
hold on
load(strcat(str,'\bfEigModel\iso\r0\rxPowerMIMO.mat'))
d=dis(op:ed);
c=rxP(op:ed);
plot(d, c, 'o');
hold on
load(strcat(str,'\smModel\iso\r0\rxPowerMIMO.mat'))
d=dis(op:ed);
c=rxP(op:ed);
plot(d, c, '>');
hold on
load(strcat(str,'\smh4Model\iso\r0\rxPowerMIMO.mat'))
d=dis(op:ed);
c=rxP(op:ed);
plot(d, c, '<');
hold on
load(strcat(str,'\smh2Model\iso\r0\rxPowerMIMO.mat'))
d=dis(op:ed);
c=rxP(op:ed);
plot(d, c, '+');
hold on
xlabel('Distance [m]');ylabel('Total received power [dBm]');
legend('Location', 'best', 'Dir BF', 'DET', 'SM', 'SMH4', 'SMH2')
grid on
ylim([-120, -40]);
title('Street route total received power with distance')
% saveas(gcf,'rxPdisSR','png')
%% Extracting rxP data
load(strcat(str,'\bfModel\iso\r0\rxPowerMIMO.mat'))
rxP1=rxP;
load(strcat(str,'\bfEigModel\iso\r0\rxPowerMIMO.mat'))
rxP2=rxP;
load(strcat(str,'\smModel\iso\r0\rxPowerMIMO.mat'))
rxP3=rxP;
load(strcat(str,'\smh4Model\iso\r0\rxPowerMIMO.mat'))
rxP4=rxP;
load(strcat(str,'\smh2Model\iso\r0\rxPowerMIMO.mat'))
rxP5=rxP;
%
rxP=mean([rxP1 rxP2 rxP3 rxP4 rxP5], 2);
data=[dis rxP];
data=sortrows(data);
wl=3;
len=0;
th=3;
%
while len~=length(data)
    len=length(data);
    for x=1:len
        if x<=wl
            m_rxP=mean(data(x+1:x+2*wl, 2));
        elseif x+wl<=length(data)
            m_rxP=(mean(data(x-wl:x-1, 2))+mean(data(x+1:x+wl, 2)))/2;
        elseif x <= length(data)
            m_rxP=mean(data(x-2*wl:x-1, 2));
        else
            break;
        end
        if data(x, 2)< m_rxP-th
            data(x, :)=[];
        end        
    end
end
%
figure
plot(data(:,1), data(:,2));
xlabel('Distance [m]');ylabel('Total received power [dBm]');
% legend('Location', 'best', 'Dir BF', 'DET', 'SM', 'SMH4', 'SMH2')
grid on
% ylim([-inf, inf]);
title('Street route total received power with distance')
saveas(gcf,'rxPdisSRiso','png')
%% Plot CDF of received power
thd=-200;
load(strcat(str,'\bfModel\iso\r0\rxPowerMIMO.mat'))
rxP1=rxP(rxP>thd);
load(strcat(str,'\bfEigModel\iso\r0\rxPowerMIMO.mat'))
rxP2=rxP(rxP>thd);
load(strcat(str,'\smModel\iso\r0\rxPowerMIMO.mat'))
rxP3=rxP(rxP>thd);
load(strcat(str,'\smh4Model\iso\r0\rxPowerMIMO.mat'))
rxP4=rxP(rxP>thd);
load(strcat(str,'\smh2Model\iso\r0\rxPowerMIMO.mat'))
rxP5=rxP(rxP>thd);
%
figure
hold on
[f, x]=ecdf(rxP1);
plot(x, f, '.-.');
% plot(x(1:50:end), f(1:50:end), 'x');
[f, x]=ecdf(rxP2);
plot(x, f, '--');
% plot(x(1:50:end), f(1:50:end), 'o');
[f, x]=ecdf(rxP3);
plot(x, f, '-.');
% plot(x(1:50:end), f(1:50:end), '+');
[f, x]=ecdf(rxP4);
plot(x, f, ':');
% plot(x(1:50:end), f(1:50:end), '^');
[f, x]=ecdf(rxP5);
plot(x, f);
% plot(x(1:50:end), f(1:50:end), 'd');
grid on
legend('Location', 'best', 'Dir BF', 'DET', 'SM', 'SMH4', 'SMH2')
xlabel('Total received power [dBm]');ylabel('CDF');
title('RxP Emiprical CDF');
saveas(gcf,'rxPcdfISO','png')
