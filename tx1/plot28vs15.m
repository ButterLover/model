% richness 2d map
clear all;
close all;
load position
str='C:\Users\NI\Documents\MATLAB\thesis\';

%% Plot channel multiplexing richness compare LOS1 
op=1;
ed=58;

load(strcat(str, 'outdoor28G\tx1\mulR'))
figure
plot(mul(op:ed), '-x')
hold on
load(strcat(str, 'outdoor15G\tx1\mulR'))
plot(mul(op:ed), '-o')
grid on
xlabel('Rx index');ylabel('Channel multiplexing richness');
legend('Location','best','28GHz','15GHz')
saveas(gcf, 'chR15vs28los1isoR0','png')

%% LOS1 capacity ISO PAT r=0
op=1;
ed=58;

% BF
load(strcat(str, 'outdoor28G\tx1\bfModel\iso\r0\capacity'))
figure
plot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\bfModel\pat\r0\capacity'))
plot(cp(op:ed), '-.')
hold on
load(strcat(str, 'outdoor15G\tx1\bfModel\iso\r0\capacity'))
plot(cp(op:ed), '-x', 'Markersize', 4)
hold on
load(strcat(str, 'outdoor15G\tx1\bfModel\pat\r0\capacity'))
plot(cp(op:ed), '-*', 'Markersize', 4)
grid on
xlabel('Rx index');ylabel('Capacity [bps/Hz]');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'cap15vs28los1BFr0','png')

% DET
load(strcat(str, 'outdoor28G\tx1\bfEigModel\iso\r0\capacity'))
figure
plot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\bfEigModel\pat\r0\capacity'))
plot(cp(op:ed), '-.')
hold on
load(strcat(str, 'outdoor15G\tx1\bfEigModel\iso\r0\capacity'))
plot(cp(op:ed), '-x', 'Markersize', 4)
hold on
load(strcat(str, 'outdoor15G\tx1\bfEigModel\pat\r0\capacity'))
plot(cp(op:ed), '-*', 'Markersize', 4)
grid on
xlabel('Rx index');ylabel('Capacity [bps/Hz]');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'cap15vs28los1DETr0','png')

% SM
load(strcat(str, 'outdoor28G\tx1\smModel\iso\r0\capacity'))
figure
plot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\smModel\pat\r0\capacity'))
plot(cp(op:ed), '-.')
hold on
load(strcat(str, 'outdoor15G\tx1\smModel\iso\r0\capacity'))
plot(cp(op:ed), '-x', 'Markersize', 4)
hold on
load(strcat(str, 'outdoor15G\tx1\smModel\pat\r0\capacity'))
plot(cp(op:ed), '-*', 'Markersize', 4)
grid on
xlabel('Rx index');ylabel('Capacity [bps/Hz]');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'cap15vs28los1SMr0','png')

% SM4
load(strcat(str, 'outdoor28G\tx1\smh4Model\iso\r0\capacity'))
figure
plot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\smh4Model\pat\r0\capacity'))
plot(cp(op:ed), '-.')
hold on
load(strcat(str, 'outdoor15G\tx1\smh4Model\iso\r0\capacity'))
plot(cp(op:ed), '-x', 'Markersize', 4)
hold on
load(strcat(str, 'outdoor15G\tx1\smh4Model\pat\r0\capacity'))
plot(cp(op:ed), '-*', 'Markersize', 4)
grid on
xlabel('Rx index');ylabel('Capacity [bps/Hz]');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'cap15vs28los1SM4r0','png')

% SM2
load(strcat(str, 'outdoor28G\tx1\smh2Model\iso\r0\capacity'))
figure
plot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\smh2Model\pat\r0\capacity'))
plot(cp(op:ed), '-.')
hold on
load(strcat(str, 'outdoor15G\tx1\smh2Model\iso\r0\capacity'))
plot(cp(op:ed), '-x', 'Markersize', 4)
hold on
load(strcat(str, 'outdoor15G\tx1\smh2Model\pat\r0\capacity'))
plot(cp(op:ed), '-*', 'Markersize', 4)
grid on
xlabel('Rx index');ylabel('Capacity [bps/Hz]');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'cap15vs28los1SM2r0','png')

%% LOS capacity CDF ISO PAT r=0
op=1;
ed=132;

% BF
load(strcat(str, 'outdoor28G\tx1\bfModel\iso\r0\capacity'))
figure
cdfplot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\bfModel\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('-.');
hold on
load(strcat(str, 'outdoor15G\tx1\bfModel\iso\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('--');
hold on
load(strcat(str, 'outdoor15G\tx1\bfModel\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=(':');
grid on
xlabel('Capacity [bps/Hz]');ylabel('Probability');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'capCDF15vs28losBFr0','png')

% DET
load(strcat(str, 'outdoor28G\tx1\bfEigModel\iso\r0\capacity'))
figure
cdfplot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\bfEigModel\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('-.');
hold on
load(strcat(str, 'outdoor15G\tx1\bfEigModel\iso\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('--');
hold on
load(strcat(str, 'outdoor15G\tx1\bfEigModel\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=(':');
grid on
xlabel('Capacity [bps/Hz]');ylabel('Probability');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'capCDF15vs28losDETr0','png')

% SM
load(strcat(str, 'outdoor28G\tx1\smModel\iso\r0\capacity'))
figure
cdfplot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\smModel\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('-.');
hold on
load(strcat(str, 'outdoor15G\tx1\smModel\iso\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('--');
hold on
load(strcat(str, 'outdoor15G\tx1\smModel\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=(':');
grid on
xlabel('Capacity [bps/Hz]');ylabel('Probability');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'capCDF15vs28losSMr0','png')

% SM4
load(strcat(str, 'outdoor28G\tx1\smh4Model\iso\r0\capacity'))
figure
cdfplot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\smh4Model\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('-.');
hold on
load(strcat(str, 'outdoor15G\tx1\smh4Model\iso\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('--');
hold on
load(strcat(str, 'outdoor15G\tx1\smh4Model\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=(':');
grid on
xlabel('Capacity [bps/Hz]');ylabel('Probability');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'capCDF15vs28losSM4r0','png')

% SM2
load(strcat(str, 'outdoor28G\tx1\smh2Model\iso\r0\capacity'))
figure
cdfplot(cp(op:ed))
hold on
load(strcat(str, 'outdoor28G\tx1\smh2Model\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('-.');
hold on
load(strcat(str, 'outdoor15G\tx1\smh2Model\iso\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=('--');
hold on
load(strcat(str, 'outdoor15G\tx1\smh2Model\pat\r0\capacity'))
h=cdfplot(cp(op:ed));
h.LineStyle=(':');
grid on
xlabel('Capacity [bps/Hz]');ylabel('Probability');
legend('Location','best','Isotropic 28GHz', 'Patch 28GHz','Isotropic 15GHz', 'Patch 15GHz')
saveas(gcf, 'capCDF15vs28losSM2r0','png')
