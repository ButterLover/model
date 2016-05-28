%% Capacity CDF LOS ant
clear all;
close all;
str=pwd;
op=1;
ed=132;
% dir BF
figure
load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
% h.LineStyle='-.';
hold on
load(strcat(str,'\bfModel\iso\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='-.';
hold on
load(strcat(str,'\bfModel\pat\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='--';
hold on
load(strcat(str,'\bfModel\pat\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle=':';
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90','Location','best')
xlabel('Capacity [bps/hz]');ylabel('Probability');
title('Directional beamforming LOS capacity CDF')
saveas(gcf,'capCDFlosBF','png')
% dominant eigenmode
figure
load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
% h.LineStyle='-.';
hold on
load(strcat(str,'\bfEigModel\iso\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='-.';
hold on
load(strcat(str,'\bfEigModel\pat\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='--';
hold on
load(strcat(str,'\bfEigModel\pat\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle=':';
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90','Location','best')
xlabel('Capacity [bps/hz]');ylabel('Probability');
title('DET LOS capacity CDF')
saveas(gcf,'capCDFlosDET','png')

% 8x32 sm
figure
load(strcat(str,'\smModel\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
% h.LineStyle='-.';
hold on
load(strcat(str,'\smModel\iso\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='-.';
hold on
load(strcat(str,'\smModel\pat\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='--';
hold on
load(strcat(str,'\smModel\pat\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle=':';
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90','Location','best')
xlabel('Capacity [bps/hz]');ylabel('Probability'); 
title('Spatial multiplexing LOS capacity CDF')
saveas(gcf,'capCDFlosSM','png')

% 4x32 Hybrid sm
figure
load(strcat(str,'\smh4Model\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
% h.LineStyle='-.';
hold on
load(strcat(str,'\smh4Model\iso\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='-.';
hold on
load(strcat(str,'\smh4Model\pat\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='--';
hold on
load(strcat(str,'\smh4Model\pat\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle=':';
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90','Location','best')
xlabel('Capacity [bps/hz]');ylabel('Probability'); 
title('SM4 LOS capacity CDF')
saveas(gcf,'capCDFlosSM4','png')

% 2x32 Hybrid sm
figure
load(strcat(str,'\smh2Model\iso\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
% h.LineStyle='-.';
hold on
load(strcat(str,'\smh2Model\iso\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='-.';
hold on
load(strcat(str,'\smh2Model\pat\r0\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle='--';
hold on
load(strcat(str,'\smh2Model\pat\r90\capacity.mat'))
h=cdfplot(cp(op:ed)) ;
h.LineStyle=':';
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90','Location','best')
xlabel('Capacity [bps/hz]');ylabel('Probability'); 
title('SM2 LOS capacity CDF')
saveas(gcf,'capCDFlosSM2','png')