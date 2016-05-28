%% Capacity CDF LOS iso r0
clear all;
close all;
str=pwd;
op=1;
ed=132;
% % 8x32 sm
% figure
% load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
% h=cdfplot(cp(op:ed));
% hold on
% load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
% h=cdfplot(cp(op:ed));
% xlabel('Capacity [bps/hz]');
% legend( 'Directional BF','Dominant eigenmode');
% title('Isotropic element without rotation LOS capacity empirical CDF');
% % 8x32 sm
% figure
% load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
% h=cdfplot(cp(op:ed));
% hold on
% load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
% h=cdfplot(cp(op:ed));
% hold on
% load(strcat(str,'\smModel\iso\r0\capacity.mat'))
% h=cdfplot(cp(op:ed));
% xlabel('Capacity [bps/hz]');
% legend( 'Directional BF','Dominant eigenmode', '8x32 SM');
% title('Isotropic element without rotation LOS capacity empirical CDF');
% % 4x32 hybrid sm
% figure
% load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
% h=cdfplot(cp(op:ed));
% hold on
% load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
% h=cdfplot(cp(op:ed));
% hold on
% load(strcat(str,'\smModel\iso\r0\capacity.mat'))
% h=cdfplot(cp(op:ed));
% hold on
% load(strcat(str,'\smh4Model\iso\r0\capacity.mat'))
% h=cdfplot(cp(op:ed));
% xlabel('Capacity [bps/hz]');
% legend( 'Directional BF','Dominant eigenmode', '8x32 SM', '4x32 hybrid SM');
% title('Isotropic element without rotation LOS capacity empirical CDF');
% 2x32 hybrid sm
figure
load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed));
% h.LineStyle='-.';
hold on
load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed));
h.LineStyle='--';
hold on
load(strcat(str,'\smModel\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed));
h.LineStyle=':';
hold on
load(strcat(str,'\smh4Model\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed));
h.LineStyle='-.';
hold on
load(strcat(str,'\smh2Model\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed));
h.Marker='.';
h.MarkerSize=4;
xlabel('Capacity [bps/hz]');ylabel('Probability');
legend( 'Directional BF','Dominant eigenmode', '8x32 SM', '4x32 hybrid SM', '2x32 hybrid SM','Location','best')
title('Isotropic element without rotation LOS capacity empirical CDF');
saveas(gcf,'capCDFlosIsoR0compare','png')