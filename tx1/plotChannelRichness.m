% richness 2d map
close all;
load position
str=pwd;
op=1;
ed=968;
load(strcat(str,'\mulR.mat'))
a=10;
x=x(op:ed);
y=y(op:ed);
c=mul(op:ed);
figure
plot(tx(1),tx(2),'x');
text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
% caxis([cmin cmax])
h.Label.String='Channel multiplexing richness';
legend('Tx','Rx')
grid on
xlabel('x [m]');ylabel('y [m]')
%% SM PDP of the LOS2 last Rx
fc=15e9;
% bw=1e9; % System bandwidth
bw=800e6;
Nf=801;
ft=bw/(Nf-1);   % Frequency spacing between two bins
% f=fc-bw/2:ft:fc+bw/2;   % Frequency range
tau=0:1/bw:1/ft;    % Calculating delay
load(strcat(str,'\smModel\iso\r0\channelMatrix.mat'), 'hf_los')
hft=hf_los(:,:,82);
htt=ifft(hft);
pdp=pow2db(squeeze(sum(abs(htt).^2,2)));
figure
plot(tau, pdp)
hold on
plot(tau, -106.5*ones(801,1),'--')
grid on
xlabel('Time delay [s]');ylabel('PDP [dB]');