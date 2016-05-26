function [ H_out ] = times3d( Hi,Vi )
%TIMES3D Summary of this function goes here
%   Detailed explanation goes here

%%
% V1=[1 2 3; 4 5 6;  7 8 9; 10 11 12];
% for m=1:401
%     Vt(:,:,m)=V1+12*(m-1);
% end
% 
%  Hi=[1 2 3 4; 5 6 7 8;];
% for n=1:401
%     Ht(:,:,n)=H1+8*(n-1);
% end

% Hi=permute(Vt,[2 1 3]);
%%
[mx,nx,lx]=size(Hi);
[my,ny,ly]=size(Vi);

if lx==1 
    Hi=repmat(Hi,1,ly);
    Hi=reshape(Hi,mx,nx,[]);
end

if ly==1 
    Vi=repmat(Vi,1,lx);
    Vi=reshape(Vi,my,ny,[]);
end
%%
Ht=permute(Hi,[2 1 3]);
Ht=reshape(Ht,nx,[]);
Ht=Ht.';
Ht=repmat(Ht,1,ny);

Vt=reshape(Vi,1,[]);
Vt=repmat(Vt,mx,1);
Vt=reshape(Vt,mx,my*ny,[]);
Vt=permute(Vt,[2 1 3]);
Vt=reshape(Vt,my*ny,[]);
Vt=Vt.';
%%
He=Ht.*Vt;
parfor f=1:ny
    Hf(:,f)=sum(He(:,(nx*(f-1)+1):nx*f),2);
end
% Hf=[sum(He(:,1:3),2) sum(He(:,4:6),2) sum(He(:,7:9),2)];
%%
% Hf=Hf.';
% Hf=reshape(Hf,ny,mx,[]);
Hf=reshape(Hf.',ny,mx,[]);
H_out=permute(Hf,[2 1 3]);

end

