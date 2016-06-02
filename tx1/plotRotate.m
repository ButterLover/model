clear all;
close all;
rot_angle=linspace(-180, 180, 61);


%% Plot capacity with different rotating angle
rx_ind=[ 10 19 44 67 82 90 114 122];
% 
% load(strcat(pwd, '\rotate\iso\capacity'))
% figure
% plot(rot_angle, cpsm(rxi, :))
% hold on
% plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
% hold on
% % plot(rot_angle, cpeig)
% plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
% hold on
% plot(rot_angle, cpsm2(rxi, :),'--')
% %     ylim([0 inf])
% grid on
% legend('SM','BF','SM4','SM2')
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% %     saveas(gcf, strcat('rotISOrx', num2str(rxi)),'png')

load(strcat(pwd, '\rotate\patch\capacity'))
for rxi=1:8
    figure
        plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm(rxi, :))
    hold on

    % plot(rot_angle, cpeig)
    plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
    hold on
    plot(rot_angle, cpsm2(rxi, :),'--')
    %     ylim([0 inf])
    grid on
    legend('BF','SM','SM4','SM2')
    xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
    %     saveas(gcf, strcat('rotISOrx', num2str(rxi)),'png')
end

% % Directional beamforming
% figure
% plot(rot_angle, cpbf)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% % DET
% figure
% plot(rot_angle, cpeig)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% % SM
% figure
% plot(rot_angle, cpsm)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% % SM4
% figure
% plot(rot_angle, cpsm4)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% % SM2
% figure
% plot(rot_angle, cpsm2)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');

% %% Comparison
% load(strcat(pwd, '\rotate\iso\capacity'))
% for rxi=1:8
%     figure
%     plot(rot_angle, cpsm(rxi, :))
%     hold on
%     plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
%     hold on
%     % plot(rot_angle, cpeig)
%     plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
%     hold on
%     plot(rot_angle, cpsm2(rxi, :),'--')
% %     ylim([0 inf])
%     grid on
%     legend('SM','BF','SM4','SM2')
%     xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
%     saveas(gcf, strcat('rotISOrx', num2str(rxi)),'png')
% end
% 
% for rxi=1:8
%     figure
%     h=cdfplot( cpsm(rxi, :));
%     %     h.LineStyle='--';
%     hold on
%     h=cdfplot( cpbf(rxi, :));
%     h.LineStyle='--';
%     hold on
%     h=cdfplot( cpsm4(rxi, :));
%     h.LineStyle='-.';
%     hold on
%     h=cdfplot( cpsm2(rxi, :));
%     h.LineStyle=':';
%     grid on
%     legend('Location', 'best', 'SM', 'BF', 'Hybrid SM4', 'Hybrid SM2')
%     xlabel('Capacity [bps/Hz]');ylabel('Probability');
%     saveas(gcf, strcat('rotISOcdfRx', num2str(rxi)),'png')
% 
% end
% %%
% load(strcat(pwd, '\rotate\patch\capacity'))
% for rxi=1:8
%     figure
%     plot(rot_angle, cpsm(rxi, :))
%     hold on
%     plot(rot_angle, cpbf(rxi, :),'-x','MarkerSize',3)
%     hold on
%     % plot(rot_angle, cpeig)
%     plot(rot_angle, cpsm4(rxi, :),'-o','MarkerSize',3)
%     hold on
%     plot(rot_angle, cpsm2(rxi, :),'--')
% %     ylim([0 inf])
%     grid on
%     legend('SM','BF','SM4','SM2')
%     xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
%     saveas(gcf, strcat('rotPATrx', num2str(rxi)),'png')
% end
% %%
% load(strcat(pwd, '\rotate\patch\capacity'))
% % Directional beamforming
% figure
% plot(rot_angle, cpbf)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% % DET
% figure
% plot(rot_angle, cpeig)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% % SM
% figure
% plot(rot_angle, cpsm)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% % SM4
% figure
% plot(rot_angle, cpsm4)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% % SM2
% figure
% plot(rot_angle, cpsm2)
% grid on
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% 
% % Comparison
% figure
% plot(rot_angle, cpsm)
% hold on
% plot(rot_angle, cpbf,'-x','MarkerSize',3)
% hold on
% % plot(rot_angle, cpeig)
% plot(rot_angle, cpsm4,'-o','MarkerSize',3)
% hold on
% plot(rot_angle, cpsm2,'--')
% grid on
% legend('SM','BF','SM4','SM2')
% xlabel('Rotating angle \phi[\circ]');ylabel('Capacity [bps/Hz]');
% saveas(gcf, 'rotPATrx82','png')
% 
