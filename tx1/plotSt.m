%% Delay spread
close all;
str=pwd;
op=1;
ed=48;
% Directional beamforming
load(strcat(str,'\bfModel\iso\r0\rmsDelay.mat'))
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
load(strcat(str,'\bfEigModel\iso\r0\rmsDelay.mat'))
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
load(strcat(str,'\smModel\iso\r0\rmsDelay.mat'))
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
load(strcat(str,'\smh4Model\iso\r0\rmsDelay.mat'))
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
load(strcat(str,'\smh2Model\iso\r0\rmsDelay.mat'))
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

%% LOS1 delay spread compare
op=1;
ed=58;
% Dominant eigenmode
figure
load(strcat(str,'\bfModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\bfEigModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode')
xlabel('Rx index');ylabel('Delay spread [s]')

% 8x32 SM
figure
load(strcat(str,'\bfModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\bfEigModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\smModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM')
xlabel('Rx index');ylabel('Delay spread [s]')

% 4x32 hyrid SM
figure
load(strcat(str,'\bfModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\bfEigModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\smModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\smh4Model\iso\r0\rmsDelay.mat'))
plot(st(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM','4x32 hybrid SM')
xlabel('Rx index');ylabel('Delay spread [s]')

% 2x32 hyrid SM
figure
load(strcat(str,'\bfModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\bfEigModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\smModel\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\smh4Model\iso\r0\rmsDelay.mat'))
plot(st(op:ed))
hold on
load(strcat(str,'\smh2Model\iso\r0\rmsDelay.mat'))
plot(st(op:ed),'-x')
grid on
legend('Directional beamforming','Dominant eigenmode','8x32 SM','4x32 hybrid SM','2x32 hybrid SM')
xlabel('Rx index');ylabel('Delay spread [s]')