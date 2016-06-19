% Plot patch antenna pattern for thesis using
% 
% 
clear all; close all;

%%
load patchYPattern

phi=linspace(-180,180,180);
theta=linspace(0,180,90);
[phi2, theta2]=meshgrid(phi,theta);
phi2=degtorad(phi2);
theta2=degtorad(theta2);
gain2=abs(pat);

x=gain2.*sin(theta2).*cos(phi2);
y=gain2.*sin(phi2).*sin(theta2);
z=gain2.*cos(theta2);
c=gain2;
figure
surf(x,y,z,c,'EdgeColor','none')
colormap gray
% title('Verifying "psht" function: 8x4 XZ plane array')
xlabel('X');ylabel('Y');zlabel('Z');
shading interp
h=colorbar;
h.Label.String='Antenna gain';
%%
load patchPattern

phi=linspace(-180,180,180);
theta=linspace(0,180,90);
[phi2, theta2]=meshgrid(phi,theta);
phi2=degtorad(phi2);
theta2=degtorad(theta2);
gain2=abs(patch);

x=gain2.*sin(theta2).*cos(phi2);
y=gain2.*sin(phi2).*sin(theta2);
z=gain2.*cos(theta2);
c=gain2;
figure
surf(x,y,z,c,'EdgeColor','none')
h=colorbar;
h.Label.String='Antenna gain';
colormap gray
% title('Verifying "psht" function: 8x4 XZ plane array')
xlabel('X');ylabel('Y');zlabel('Z');
shading interp
