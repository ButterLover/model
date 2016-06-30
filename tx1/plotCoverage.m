clear all;
close all;
load position

str=pwd;
op=59;
ed=82;

figure
load(strcat(str, '\bfModel\iso\r0\rxPowerMIMO.mat'));
plot(dis(op:ed), rxP(op:ed), 'o', 'MarkerSize', 5)
hold on
load(strcat(str, '\bfEigModel\iso\r0\rxPowerMIMO.mat'));
plot(dis(op:ed), rxP(op:ed), 'x', 'MarkerSize', 5)
hold on
load(strcat(str, '\smModel\iso\r0\rxPowerMIMO.mat'));
plot(dis(op:ed), rxP(op:ed), '*', 'MarkerSize', 5)
hold on
load(strcat(str, '\smh4Model\iso\r0\rxPowerMIMO.mat'));
plot(dis(op:ed), rxP(op:ed), '+', 'MarkerSize', 5)
hold on
load(strcat(str, '\smh2Model\iso\r0\rxPowerMIMO.mat'));
plot(dis(op:ed), rxP(op:ed), '<', 'MarkerSize', 5)
grid on
ylim([-150 inf])
legend('Location', 'best', 'BF', 'DET', 'SM', 'Hybrid SM4', 'Hybrid SM2')
xlabel('Distance [m]'); ylabel('Received power [dBm]');
%%
% figure
% load(strcat(str, '\bfModel\iso\r0\capacity.mat'));
% plot(dis(op:ed), cp(op:ed), 'o', 'MarkerSize', 5)
% hold on
% load(strcat(str, '\bfEigModel\iso\r0\capacity.mat'));
% plot(dis(op:ed), cp(op:ed), 'x', 'MarkerSize', 5)
% hold on
% load(strcat(str, '\smModel\iso\r0\capacity.mat'));
% plot(dis(op:ed), cp(op:ed), '*', 'MarkerSize', 5)
% hold on
% load(strcat(str, '\smh4Model\iso\r0\capacity.mat'));
% plot(dis(op:ed), cp(op:ed), '+', 'MarkerSize', 5)
% hold on
% load(strcat(str, '\smh2Model\iso\r0\capacity.mat'));
% plot(dis(op:ed), cp(op:ed), '<', 'MarkerSize', 5)
% grid on
% legend('Location', 'best', 'BF', 'DET', 'SM', 'Hybrid SM4', 'Hybrid SM2')
% xlabel('Distance [m]'); ylabel('Received power [dBm]');