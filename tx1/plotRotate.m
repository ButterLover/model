clear all;
close all;
rot_angle=linspace(-180, 180, 61);


%% Plot capacity with different rotating angle
rx_ind=[ 10 19 44 67 82 90 114 122];
%
load(strcat(pwd, '\rotate\iso\capacity'))
for rxi=1:8
    figure
    plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm(rxi, :))
    hold on
    plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm2(rxi, :),'--')
    grid on
    legend('BF','SM','SM4','SM2')
    xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
    %     saveas(gcf, strcat('rotISOrx', num2str(rxi)),'png')
end

load(strcat(pwd, '\rotate\patch\capacity'))
for rxi=1:8
    figure
    plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm(rxi, :))
    hold on
    plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm2(rxi, :),'--')
    grid on
    legend('BF','SM','SM4','SM2')
    xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
    %     saveas(gcf, strcat('rotPATrx', num2str(rxi)),'png')
end

