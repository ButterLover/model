%% LOS1 capacity compare
clear all;
close all;
str=pwd;
op=1;
ed=58;
% % Dominant eigenmode
% figure
% load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
% plot(cp(op:ed))
% hold on
% load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
% plot(cp(op:ed),'-x')
% grid on
% legend('Directional beamforming','Dominant eigenmode')
% xlabel('Rx index');ylabel('Capacity [bps/Hz]')
% 
% % 8x32 SM
% figure
% load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
% plot(cp(op:ed))
% hold on
% load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
% plot(cp(op:ed))
% hold on
% load(strcat(str,'\smModel\iso\r0\capacity.mat'))
% plot(cp(op:ed),'-x')
% grid on
% legend('Directional beamforming','Dominant eigenmode','8x32 SM')
% xlabel('Rx index');ylabel('Capacity [bps/Hz]')
% 
% % 4x32 hyrid SM
% figure
% load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
% plot(cp(op:ed))
% hold on
% load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
% plot(cp(op:ed))
% hold on
% load(strcat(str,'\smModel\iso\r0\capacity.mat'))
% plot(cp(op:ed))
% hold on
% load(strcat(str,'\smh4Model\iso\r0\capacity.mat'))
% plot(cp(op:ed),'-x')
% grid on
% legend('Directional beamforming','Dominant eigenmode','8x32 SM','4x32 hybrid SM')
% xlabel('Rx index');ylabel('Capacity [bps/Hz]')

% 2x32 hyrid SM
figure
load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
plot(cp(op:ed))
hold on
load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
plot(cp(op:ed),'--')
hold on
load(strcat(str,'\smModel\iso\r0\capacity.mat'))
plot(cp(op:ed),'-..')
hold on
load(strcat(str,'\smh4Model\iso\r0\capacity.mat'))
plot(cp(op:ed),'-o','MarkerSize',3)
hold on
load(strcat(str,'\smh2Model\iso\r0\capacity.mat'))
plot(cp(op:ed),'-x','MarkerSize',3)
grid on
legend('Directional BF','DET','8x32 SM','4x32 hybrid SM','2x32 hybrid SM','Location','best')
xlabel('Rx index');ylabel('Capacity [bps/Hz]')
title('Capacity LOS1 compare iso R0')
saveas(gcf,'capLos1isoR0','png')