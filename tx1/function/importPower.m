function [ output_args ] = importPower( input_args )
%IMPORTPOWER Summary of this function goes here
%   Detailed explanation goes here


di=dir(str);
% cirName=di.name;
numfiles=length(di);
% cir=cell(1, numfiles);
outdata=[];
for x=1:numfiles
    cir=importdata(di(x).name);
%     out=dataProcess(cir.data,rayN,colN);
    outdata=cat(4,outdata, out);
end

end

