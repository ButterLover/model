function [ outdata ] = p2mConSIMO( str, rayN, colN )
%P2MCONV :[ outdata ] = p2mConv( str, rayN, colN )
% 
% Outdata Dimension: 1st - rays index
%            2nd - properties(toa, phase, power ...)
%            3rd - Rx
%            4th - Tx
% 
% Convering p2m from ray tracer to matrix
% Only works for dod, doa, cir and toa.
% Input:
% str: name of multiple files. eg: '*.cir.*.p2m' for all Complex impulse response
% rayN: Number of rays set in ray tracer;
% colN: Number of columns in the imported file. eg. for cir has 4 columns
% (Ray index, phase, time of arrived, convery power)
% -------------------------------------------------------------------------
% Output:
% outdata: 3D Struct. Rows are rays. Columns are the same with them
% in file. Third dimension is Rx.
% 
% eg: 3Rx 3Rays of cir (outdata{x}.(:,:,1))
% x-------------------------------x
% | Ray index| Phase | TOA | Power| 1stTx
% ---------------------------------
% |     1    | ...                |
% |     2    | ...                | 1st Rx
% |     3    | ...                |
% ---------------------------------
% -------------------------------------------------------------------------

di=dir(str);
% cirName=di.name;
numfiles=length(di);
if numfiles==0
   '"p2mConSIMO" function should run under the files directions'
end
% cir=cell(1, numfiles);
% outdata=[];
for x=1:numfiles
    cir=importdata(di(x).name);
    out=dataProcess(cir.data,rayN,colN);
%     size(out):
%     outdata=cat(4,outdata, out);
    outdata{x}=out;
end


end

