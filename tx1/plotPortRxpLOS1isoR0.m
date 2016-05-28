clear all;
close all;
load position
str=pwd;
Ptx=31.5;
%% Port 1 received power comparison
op=1;
ed=58;
figure
load(strcat(str,'\bfModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+1.5)
hold on
load(strcat(str,'\bfEigModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+1.5,'--')
hold on

load(strcat(str,'\smh2Model\iso\r0\channelMatrix.mat'), 'hfsm2_los')
ht=ifft(hfsm2_los);
ht_t=reshape(ht, 801, 2, 32, []);
ht=squeeze(ht_t(:, 1, :, :));
rxP_t=squeeze(pow2db(squeeze(mean(sum(abs(ht).^2,2),1))));
plot(rxP_t(op:ed)+Ptx,'-..')
hold on

load(strcat(str,'\smh4Model\iso\r0\channelMatrix.mat'), 'hfsm4_los')
ht=ifft(hfsm4_los);
ht_t=reshape(ht, 801, 4, 32, []);
ht=squeeze(ht_t(:, 1, :, :));
rxP_t=squeeze(pow2db(squeeze(mean(sum(abs(ht).^2,2),1))));
plot(rxP_t(op:ed)+Ptx,'.')
hold on

load(strcat(str,'\smModel\iso\r0\channelMatrix.mat'), 'hf_los')
ht=ifft(hf_los);
ht_t=reshape(ht, 801, 8, 32, []);
ht=squeeze(ht_t(:, 1, :, :));
rxP_t=squeeze(pow2db(squeeze(mean(sum(abs(ht).^2,2),1))));
plot(rxP_t(op:ed)+Ptx,'-.')
hold on
legend('Directional BF','DET','2x32 hybrid SM port1','4x32 hybrid SM port1','8x32 SM port1','Location','best')
grid on
xlabel('Rx index'); ylabel('Received power [dBm]');
title('Port 1 received power compare')
saveas(gcf,'port1rxP','png')

%% Hybrid SM2
op=1;
ed=58;
figure
load(strcat(str,'\bfModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+1.5)
hold on
load(strcat(str,'\bfEigModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+1.5,'--')
hold on

load(strcat(str,'\smh2Model\iso\r0\channelMatrix.mat'), 'hfsm2_los')
ht=ifft(hfsm2_los);
ht_t=reshape(ht, 801, 2, 32, []);
for w=1:2
    ht=squeeze(ht_t(:, w, :, :));
	temp=squeeze(pow2db(squeeze(mean(sum(abs(ht).^2,2),1))));
    plot(temp(op:ed)+Ptx,'-.')
    hold on
end
legend('Directional BF','DET','2x32 hybrid SM port1','2x32 hybrid SM port2','Location','best')
grid on
xlabel('Rx index'); ylabel('Port received power [dBm]');
title('SM2 port received power')
saveas(gcf,'portRxpSM2','png')
%%
op=1;
ed=58;
figure
load(strcat(str,'\bfModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+1.5)
hold on
load(strcat(str,'\bfEigModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+1.5,'--')
hold on

load(strcat(str,'\smh4Model\iso\r0\channelMatrix.mat'), 'hfsm4_los')
ht=ifft(hfsm4_los);
ht_t=reshape(ht, 801, 4, 32, []);
for w=1:4
    ht=squeeze(ht_t(:, w, :, :));
	temp=squeeze(pow2db(squeeze(mean(sum(abs(ht).^2,2),1))));
    plot(temp(op:ed)+Ptx,'-.')
    hold on
end
legend('Directional BF','DET','4x32 hybrid SM port1','4x32 hybrid SM port2','4x32 hybrid SM port3','4x32 hybrid SM port4','Location','best')
grid on
xlabel('Rx index'); ylabel('Port received power [dBm]');
title('SM4 port received power')
saveas(gcf,'portRxpSM4','png')
%%
op=1;
ed=58;
figure
load(strcat(str,'\bfModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+1.5)
hold on
load(strcat(str,'\bfEigModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+1.5,'--')
hold on

load(strcat(str,'\smModel\iso\r0\channelMatrix.mat'), 'hf_los')
ht1=ifft(hf_los);
ht_t=reshape(ht1, 801, 8, 32, []);
for w=1:8
    ht=squeeze(ht_t(:, w, :, :));
	temp=squeeze(pow2db(squeeze(mean(sum(abs(ht).^2,2),1))));
    plot(temp(op:ed)+Ptx,'-.')
    hold on
end
legend('Directional BF','DET','8x32 SM port1','8x32 SM port2','8x32 SM port3','8x32 SM port4','8x32 SM port5','8x32 SM port6','8x32 SM port7','8x32 SM port8','Location','best')
grid on
xlabel('Rx index'); ylabel('Port received power [dBm]');
title('SM port received power')
saveas(gcf,'portRxpSM','png')
%% total received power
load position
str=pwd;
Ptx=1.5;
op=1;
ed=58;
figure
load(strcat(str,'\bfModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+Ptx,'-..')
hold on
load(strcat(str,'\bfEigModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+Ptx,'--')
hold on
load(strcat(str,'\smModel\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+Ptx,'.')
hold on
load(strcat(str,'\smh4Model\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+Ptx)
hold on
load(strcat(str,'\smh2Model\iso\r0\rxPowerMIMO.mat'))
plot(rxP(op:ed)+Ptx,'-.')
legend('Directional BF','DET','8x32 SM','4x32 hybrid SM', '2x32 hyrid SM','Location','best')
grid on
xlabel('Rx index'); ylabel('Total received power [dBm]');
title('Total received power')
saveas(gcf,'rxpCom','png')
