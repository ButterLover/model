function plot2D(tx,textstr, alignment, colorbarstr,x, y, c, ax,titlestr)
% plot2D(tx,textstr, alignment,x, y, c, ax)
    a=15;
    figure
    plot(tx(1),tx(2),'x');
    if alignment==1
        text(tx(1),tx(2),textstr);
    else
        text(tx(1),tx(2),textstr,'HorizontalAlignment','right');
    end
    hold on
    scatter(x,y,a,c,'filled')
    colormap jet
    h=colorbar;
    h.Label.String=colorbarstr;
    grid on
    legend('Tx','Rx')
    xlabel('x [m]');ylabel('y [m]');
    if length(ax)==4
        axis(ax);
    end
    if length(titlestr)>2
        title(titlestr);
    end
end

