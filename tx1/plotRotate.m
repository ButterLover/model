clear all;
close all;
rot_angle=linspace(270, -90, 181);

%% Plot capacity with different rotating angle
rx_ind=[ 10 19 44 67 82 90 114 122];
load(strcat(pwd, '\rotate\iso\capacity'))
rot_angle(rot_angle>180)=mod(rot_angle(rot_angle>180),-180);
rot_angle(rot_angle<-180)=mod(rot_angle(rot_angle<-180),180);

% Comparison
load(strcat(pwd, '\rotate\iso\capacity'))
for rxi=1:8
    figure
    t=sortrows([rot_angle; cpsm(rxi, :)].').';
    plot(t(1,:), t(2,:));
    hold on
    t=sortrows( [rot_angle;  cpbf(rxi, :)].').';
    plot(t(1,:), t(2,:),'-x','MarkerSize',3)
    hold on
    % t=sort( [rot_angle;  cpeig)
    t=sortrows( [rot_angle;  cpsm4(rxi, :)].').';
    plot(t(1,:), t(2,:),'-o','MarkerSize',3)
    hold on
    t=sortrows( [rot_angle;  cpsm2(rxi, :)].').';
    plot(t(1,:), t(2,:),'--')
    %     ylim([0 inf])
    grid on
    legend('SM','BF','SM4','SM2')
    xlabel('Phi angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
    title( strcat('Isotropic Rx #', num2str(rx_ind(rxi))))
    saveas(gcf, strcat('rotISOrx', num2str(rx_ind(rxi))),'png')
end
%
for rxi=1:8
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
%%
load(strcat(pwd, '\rotate\patch\capacity'))
for rxi=1:8
    figure
    t=sortrows([rot_angle; cpsm(rxi, :)].').';
    plot(t(1,:), t(2,:));
    hold on
    t=sortrows( [rot_angle;  cpbf(rxi, :)].').';
    plot(t(1,:), t(2,:),'-x','MarkerSize',3)
    hold on
    t=sortrows( [rot_angle;  cpsm4(rxi, :)].').';
    plot(t(1,:), t(2,:),'-o','MarkerSize',3)
    hold on
    t=sortrows( [rot_angle;  cpsm2(rxi, :)].').';
    plot(t(1,:), t(2,:),'--')
    grid on
    legend('SM','BF','SM4','SM2')
    xlabel('Phi angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
    title( strcat('Patch Rx #', num2str(rx_ind(rxi))))
    saveas(gcf, strcat('rotPATrx',  num2str(rx_ind(rxi))),'png')
end

for rxi=1:8
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
