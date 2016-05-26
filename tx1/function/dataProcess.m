function [ outdata ] = dataProcess( indata, rayN, colN )
%DATAPROCESS make Impulse response raw data into matrix
% Warning: may cause wrong data if applying on data file whose last column
% is not received power. Thus only use this file for cir, dod, doa
% 
% outdata: 200x4xN matrix, N is the antenna number
%
% The four columns correspond to:
% x---------------------------------------------------------------------x
% | Ray number | Phase in degree | Time of arrival (s) | Power conveyed |
% x---------------------------------------------------------------------x
% h=importdata( 'Tx1Rx2IR15.txt');
% h=importdata( 'Tx1Rx2IR15.txt');
% indata=h.data;
%%

data=indata.';
dataIn=data(:);
antN=dataIn(1);
dataIn=dataIn(3:end);
dataT=dataIn;
lim=length(dataT);
%%
% m=dataT(1);
n=dataT(2); % Number of rays for each antenna
min=3;
% out=[];
out=zeros(rayN,colN,antN);
matS=rayN*colN;
for m=1:antN % !!!!!!!!!! Rx number here minus 1
len=4*n;
max=min+len-1;
temp=dataT(min:max);
temp(matS+1)=0;
temp(matS+1)=[];
% size(temp)
temp=reshape(temp,colN,rayN).';
% out=[out; temp];
out(:,:,m)=temp;
% m=dataT(max+1);
min=max+3;
if max<lim
    n=dataT(max+2);
end
end
%%
% IR15=out;
% save tx1Rx2IR15 IR15;

% In temp, add 0 to make ray number is equal to 'rayN', the received power
% of these rays are assumed to be -500 dBm
ind=false(size(out));
ind(:,colN,:)=out(:,colN,:)==0;
out(ind)=-500;
outdata=out;
end

