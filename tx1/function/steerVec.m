function [ outdata ] = steerVec( array, al, dir, fc, Nb)
% [ outdata ] = steerVec( array, al, dir, fc, Nb)
%STEERVEC Calculating steering phase shift for antenna array
%
%   Input:
%   array - antenna allocation
%   al - Complex Impulse response with array pattern( rays x Tx number )
%   dir - steering direction in degree [phi theta]
%   fc - carrier frequence for calculating spacing
%   Nb - number of beams
%
%   Output:
%   outdata - antenna steering phase shift

if Nb==0
%     alstr=al;
    outdata=ones( 1, prod(array));
else
    c=3e8;  % Light speed
    lambda=c/fc; % wavelength
    d=zeros(array);
    phi=degtorad(dir(:,1));
    theta=degtorad(dir(:,2));
    phi=phi(:).';
    theta=theta(:).';
    an=prod(array);
    
    [x, y, z]=ind2sub(size(d),find(d==0));
    x=x(:);
    y=y(:);
    z=z(:);
    dt=[(x-1) (y-1) (z-1)]*lambda/2;
    dx=dt(:,1);
    dy=dt(:,2);
    dz=dt(:,3);
    % Make sure dx dy dz are column vectors here
    dx=dx(:);
    dy=dy(:);
    dz=dz(:);
    % Steering vector
    bn=exp(-1j*2*pi*dx*(sin(theta).*cos(phi))/lambda).*exp(-1j*2*pi*dy*(sin(theta).*sin(phi))/lambda).*exp(-1j*2*pi*dz*cos(theta)/lambda);
%     wh=sum(abs(bn).^2,1);
    bn=bn./sqrt(an);
%     sum(abs(bn).^2,1)
    % Find the largest received power
    alste=al*bn;
    powste=mag2db(abs(sum(alste,1)));
    % [~,ind]=max(powste);
    powste=powste(:).';
    tn=[bn; powste].';
    tn=sortrows(tn,an+1);
    tn=tn(1:Nb,:);
    tn(:,end)=[];
    % outdata=bn(:,ind);
    % outdata=sum(tn,1);
    outdata=tn;
%     if Nb==1
%         alstr=bsxfun(@times, al, outdata(:).');
%     else
%         alstr=al;
%     end
end

end

