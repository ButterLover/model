clear all;
close all;
rot_angle=linspace(-180, 180, 61);


%% Plot capacity with different rotating angle
rx_ind=[ 10 19 44 67 82 90 114 122];
%
load(strcat(pwd, '\rotate\iso\capacity'))
for rxi=1:length(rx_ind)
    figure
    plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm(rxi, :))
    hold on
    plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm2(rxi, :),'--')
    grid on
    legend('Location', 'best','BF','SM','SM4','SM2')
    xlabel('\phi[\circ]');ylabel('Capacity [bps/Hz]');
    title( strcat('Isotropic Rx #', num2str(rx_ind(rxi))))
    saveas(gcf, strcat('rotISOrx', num2str(rx_ind(rxi))),'png')
end
for rxi=1:length(rx_ind)
    figure
    cdfplot( cpsm(rxi, :));
    hold on
    h=cdfplot( cpbf(rxi, :));
    h.LineStyle='--';
    hold on
    h=cdfplot( cpsm4(rxi, :));
    h.LineStyle='-.';
    hold on
    h=cdfplot( cpsm2(rxi, :));
    h.LineStyle=':';
    grid on
    legend('Location', 'best', 'SM', 'BF', 'Hybrid SM4', 'Hybrid SM2')
    xlabel('Capacity [bps/Hz]');ylabel('Probability');
    title( strcat('Isotropic Rx #', num2str(rx_ind(rxi))))
    saveas(gcf, strcat('rotISOcdfRx',  num2str(rx_ind(rxi))),'png')
end

load(strcat(pwd, '\rotate\patch\capacity'))
for rxi=1:length(rx_ind)
    figure
    plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm(rxi, :))
    hold on
    plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm2(rxi, :),'--')
    grid on
    legend('Location', 'best','BF','SM','SM4','SM2')
    xlabel('\phi[\circ]');ylabel('Capacity [bps/Hz]');
    title( strcat('Patch Rx #', num2str(rx_ind(rxi))))
    saveas(gcf, strcat('rotPATrx',  num2str(rx_ind(rxi))),'png')
end
for rxi=1:length(rx_ind)
    figure
    cdfplot( cpsm(rxi, :));
    hold on
    h=cdfplot( cpbf(rxi, :));
    h.LineStyle='--';
    hold on
    h=cdfplot( cpsm4(rxi, :));
    h.LineStyle='-.';
    hold on
    h=cdfplot( cpsm2(rxi, :));
    h.LineStyle=':';
    grid on
    legend('Location', 'best', 'SM', 'BF', 'Hybrid SM4', 'Hybrid SM2')
    xlabel('Capacity [bps/Hz]');ylabel('Probability');
    title( strcat('Patch Rx #', num2str(rx_ind(rxi))))
    saveas(gcf, strcat('rotPATcdfRx',  num2str(rx_ind(rxi))),'png')
end

