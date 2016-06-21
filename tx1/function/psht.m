function [ outdata, dt ] = psht( array, dir, fc, norm_flag, sp )
% PSHT: [ outdata, dt ] = psht( array, dir, fc, norm_flag )
% Calculating the phase shift of each element antenna with half
% wavelength spacing.
% 
%   Input: 
%   array: Antenna element number in three directions [x y z]
%   dir: direction of rays [phi theta] in degree;
%   fc: Carrier frequency in Hz
%   norm_flag: Tx needs normalization (true/ false)
%   sp: element spacing (0.5 mean lambda/2)
% 
%   Output:
%   phaseShift: Each column is an antenna with different phas shift,
%   each row is different direction
%   dt: Antenna coordiante
% 
%   eg:
%   An antenna array alligned at x and z directions with 8 and 4 antenna
%   elments. array=[8 1 4]
%   
% -------------------------------------------------------

% f=15e9;
c=3e8;  % Light speed
lambda=c/fc; % wavelength
theta=degtorad(dir(:,2));
phi=degtorad(dir(:,1));
% ste_phi=degtorad(ste_phi);
% ste_theta=degtorad(ste_theta);

% Spacing to original antenna element
d=zeros(array);
[x, y, z]=ind2sub(size(d),find(d==0));
x=x(:);
y=y(:);
z=z(:);
dt=[(x-1) (y-1) (z-1)]*lambda.*sp;
dx=dt(:,1).';
dy=dt(:,2).';
dz=dt(:,3).';
dr=sin(theta).*cos(phi)*dx+(sin(theta).*sin(phi))*dy+cos(theta)*dz;
phaseShift=exp(-1j*2*pi*dr/lambda);
% strShift=exp(-1j*2*pi*dz*cos(ste_theta)/lambda).*exp(-1j*2*pi*dy*sin(ste_phi)/lambda).*exp(-1j*2*pi*dx*cos(ste_phi)/lambda);
% strShift
% outdata=bsxfun(@times,phaseShift,strShift);
if norm_flag
    N=prod(array);
    outdata=phaseShift./sqrt(N);
else
    outdata=phaseShift;
end

end

