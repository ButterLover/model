clear all;
close all;
rot_angle=linspace(-180, 180, 181);
load(strcat(pwd, '\rotate\iso\capacity'))

%% Plot capacity with different rotating angle
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

%% Comparison
load(strcat(pwd, '\rotate\iso\capacity'))
for rxi=1:8
    figure
    plot(rot_angle, cpsm(rxi, :))
    hold on
    plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
    hold on
    % plot(rot_angle, cpeig)
    plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm2(rxi, :),'--')
%     ylim([0 inf])
    grid on
    legend('SM','BF','SM4','SM2')
    xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
    saveas(gcf, strcat('rotISOrx', num2str(rxi)),'png')
end

load(strcat(pwd, '\rotate\patch\capacity'))
for rxi=1:8
    figure
    plot(rot_angle, cpsm(rxi, :))
    hold on
    plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
    hold on
    % plot(rot_angle, cpeig)
    plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm2(rxi, :),'--')
%     ylim([0 inf])
    grid on
    legend('SM','BF','SM4','SM2')
    xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
    saveas(gcf, strcat('rotPATrx', num2str(rxi)),'png')
end
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
saveas(gcf, 'rotPATrx82','png')

