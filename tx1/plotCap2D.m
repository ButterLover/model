%% capacity 2D map all
clear all; 
%close all;
load position
str=pwd;
cmin=0;
cmax=87;
% Pure directional BF
op=1;
ed=968;
load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);max(c)
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
legend('Tx','Rx','Location','best') 
xlabel('x [m]');ylabel('y [m]')
title('Directional beamforming capacity');
% % axis([-210 50 -275 25]); 
saveas(gcf,'cap2dBF','png')

% Dominant eigenmode
load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);max(c)
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
legend('Tx','Rx','Location','best') 
xlabel('x [m]');ylabel('y [m]')
% axis([-210 50 -275 25]); 
title('Dominant eigenmode capacity');
saveas(gcf,'cap2dDET','png')

% 8x32 SM
load(strcat(str,'\smModel\iso\r0\capacity.mat'))
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);max(c)
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
legend('Tx','Rx','Location','best') 
xlabel('x [m]');ylabel('y [m]')
title('Spatial multiplexing 8x32 capacity');
% % axis([-210 50 -275 25]); 
saveas(gcf,'cap2dSM','png')

% 4x32 hybrid SM
load(strcat(str,'\smh4Model\iso\r0\capacity.mat'))
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);max(c)
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
legend('Tx','Rx','Location','best') 
xlabel('x [m]');ylabel('y [m]')
% % axis([-210 50 -275 25]); 
title('Hybrid spatial multiplexing 4x32 capacity');
saveas(gcf,'cap2dSM4','png')

% 2x32 hybrid SM
load(strcat(str,'\smh2Model\iso\r0\capacity.mat'))
a=10;
x=x(op:ed);
y=y(op:ed);
c=cp(op:ed);max(c)
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
legend('Tx','Rx','Location','best') 
xlabel('x [m]');ylabel('y [m]')
% % axis([-210 50 -275 25]); 
title('Hybrid spatial multiplexing 2x32 capacity');
saveas(gcf,'cap2dSM2','png')
