clear all; close all;
rot_angle=linspace(-180, 180, 181);
load(strcat(pwd, '\rotate\iso\capacity'))
% Directional beamforming
figure
plot(rot_angle, cpbf)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% DET
figure
plot(rot_angle, cpeig)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% SM
figure
plot(rot_angle, cpsm)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% SM4
figure
plot(rot_angle, cpsm4)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% SM2
figure
plot(rot_angle, cpsm2)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% Comparison
figure
plot(rot_angle, cpsm)
hold on
plot(rot_angle, cpbf,'-x','MarkerSize',3)
hold on
% plot(rot_angle, cpeig)
plot(rot_angle, cpsm4,'-o','MarkerSize',3)
hold on
plot(rot_angle, cpsm2,'--')
grid on
legend('SM','BF','SM4','SM2')
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');


%%
load(strcat(pwd, '\rotate\patch\capacity'))
% Directional beamforming
figure
plot(rot_angle, cpbf)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% DET
figure
plot(rot_angle, cpeig)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% SM
figure
plot(rot_angle, cpsm)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% SM4
figure
plot(rot_angle, cpsm4)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% SM2
figure
plot(rot_angle, cpsm2)
grid on
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% Comparison
figure
plot(rot_angle, cpsm)
hold on
plot(rot_angle, cpbf,'-x','MarkerSize',3)
hold on
% plot(rot_angle, cpeig)
plot(rot_angle, cpsm4,'-o','MarkerSize',3)
hold on
plot(rot_angle, cpsm2,'--')
grid on
legend('SM','BF','SM4','SM2')
xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');

