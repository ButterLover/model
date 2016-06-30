%% Capacity compare los1
clear all;
% close all;
str=pwd;
op=1;
ed=48;
% dir BF
figure
load(strcat(str,'\bfModel\iso\r0\capacity.mat'))
plot(cp(op:ed))
hold on
load(strcat(str,'\bfModel\iso\r90\capacity.mat'))
plot(cp(op:ed))
hold on
load(strcat(str,'\bfModel\pat\r0\capacity.mat'))
plot(cp(op:ed),'--')
hold on
load(strcat(str,'\bfModel\pat\r90\capacity.mat'))
plot(cp(op:ed),'--')
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');
% dominant eigenmode
figure
load(strcat(str,'\bfEigModel\iso\r0\capacity.mat'))
plot(cp(op:ed))
hold on
load(strcat(str,'\bfEigModel\iso\r90\capacity.mat'))
plot(cp(op:ed))
hold on
load(strcat(str,'\bfEigModel\pat\r0\capacity.mat'))
plot(cp(op:ed),'--')
hold on
load(strcat(str,'\bfEigModel\pat\r90\capacity.mat'))
plot(cp(op:ed),'--')
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');
% 8x32 sm
figure
load(strcat(str,'\smModel\iso\r0\capacity.mat'))
plot(cp(op:ed))
% max(cp(:))
hold on
load(strcat(str,'\smModel\iso\r90\capacity.mat'))
plot(cp(op:ed))
% max(cp(:))
hold on
load(strcat(str,'\smModel\pat\r0\capacity.mat'))
plot(cp(op:ed),'--')
% max(cp(:))
hold on
load(strcat(str,'\smModel\pat\r90\capacity.mat'))
plot(cp(op:ed),'--')
% max(cp(:))
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');
% 4x32 Hybrid sm
figure
load(strcat(str,'\smh4Model\iso\r0\capacity.mat'))
plot(cp(op:ed))
hold on
load(strcat(str,'\smh4Model\iso\r90\capacity.mat'))
plot(cp(op:ed))
hold on
load(strcat(str,'\smh4Model\pat\r0\capacity.mat'))
plot(cp(op:ed),'--')
hold on
load(strcat(str,'\smh4Model\pat\r90\capacity.mat'))
plot(cp(op:ed),'--')
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');
% 2x32 Hybrid sm
figure
load(strcat(str,'\smh2Model\iso\r0\capacity.mat'))
plot(cp(op:ed))
hold on
load(strcat(str,'\smh2Model\iso\r90\capacity.mat'))
plot(cp(op:ed))
hold on
load(strcat(str,'\smh2Model\pat\r0\capacity.mat'))
plot(cp(op:ed),'--')
hold on
load(strcat(str,'\smh2Model\pat\r90\capacity.mat'))
plot(cp(op:ed),'--')
hold on
grid on
legend('Isotropic r=0','Isotropic r=90','Patch r=0','Patch r=90')
ylabel('Capacity [bps/hz]');xlabel('Rx index');