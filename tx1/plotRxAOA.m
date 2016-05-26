%% Multiplexing Rx position
close all;
str=pwd;
rx1i=[ 10 19 44 67];
rx2i=[82 90 114 122];
op=1;
ed=132;

load(strcat(str,'\mulR.mat'))
a=10;
x=x(op:ed);
y=y(op:ed);
c=mul(op:ed);
figure
plot(tx(1),tx(2),'x');
% text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
for w=1:length(rx1i)
    rxt=rx1i(w);
    tstr=strcat('Rx #',num2str(rxt),'\rightarrow ');
    text(x(rxt),y(rxt),tstr,'HorizontalAlignment','right')
end
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
% caxis([cmin cmax])
h.Label.String='Channel multiplexing richness';
legend('Tx','Rx')
grid on
xlabel('x [m]');ylabel('y [m]')

figure
plot(tx(1),tx(2),'x');
% text(tx(1),tx(2),'Tx1\rightarrow  ','HorizontalAlignment','right')
for w=1:length(rx1i)
    rxt=rx2i(w);
    tstr=strcat('Rx #',num2str(rxt),'\rightarrow ');
    text(x(rxt),y(rxt),tstr,'HorizontalAlignment','right')
end
hold on
scatter(x,y,a,c,'filled')
colormap jet
h=colorbar;
% caxis([cmin cmax])
h.Label.String='Channel multiplexing richness';
legend('Tx','Rx')
grid on
xlabel('x [m]');ylabel('y [m]')