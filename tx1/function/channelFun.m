% Functions for ergodic channel capacity calculation with or without CSI
% By Qingbi Liao

function fh = channelFun
fh = localfunctions;
end

%% Channel normalization
function Hn = normChannel_1(Hc)
% NORMCHANNEL_1: calculating the Frobenius norm of a 3D matrix

% INPUT:
% Hc: 3D measurement channel matrix size [Mr, Mt, Nr].
% Mt: number of Tx antenna
% Mr: number of Rx antenna
% Nr: number of realizations

% OUTPUT
% Hn: 3D normalization channel

[Mr, Mt, Nr]=size(Hc);
parfor x=1:Nr
    Hf(x)=norm(Hc(:,:,x),'fro');
end
Hf=sum(Hf.^2);
Hn=Hc*((Hf/(Nr*Mt*Mr))^(-0.5));
end

%% Eigenvalue calculation of normalization channel
function lamda = eigenvalue_2( Hn )
% EIGENVALUE_2
% INPUT:
% OUTPUT:
[~, ~, Nr]=size(Hn);
parfor i=1:Nr
    R(:,:,i)=Hn(:,:,i)'*Hn(:,:,i);
    lamda(:,i)=eig(R(:,:,i))
end
% R=times3d(Hn,Hn');
% parfor x=1:Nr
%     lamda_t(:,x)=eig(R(:,:,x))
% end
lamda=sort(real(lamda));
% lamda=sort(lamda_t);
lamda(lamda<0)=0;
end

%% Gamma value calculation for CSI capacity
function gamma_t = optGamma_3( lamda, snr, lim )
% OPTGAMMA
% INPUT:
% lamda_t: eigenvalue of channel matrix
% snr: signal noise ratio
% lim: total energy constraint; in the textbook, it is denoted by M_T.

lamda=sort(lamda,'ascend');
[Mt,Nr]=size(lamda);
for x=1:length(snr)
    lvl_t=Mt./(snr(x)*lamda);
    lvl=lvl_t(lvl_t<lim);
    parfor m=1:Nr
        gamma_t(:,m)=waterfill2(lvl(:,m),lim);
    end

    gamma(:,:,x)=gamma_t;
end

end

%% Ergodic channel capacity without CSI
function Ce_noCSI = ergodic_noCSI_4( lamda, snr , Mt)
% ERGODIC_NOCSI Summary of this function goes here
% 
parfor x=1:length(snr)
    Ce_noCSI(x)=mean(sum(log2(1+lamda*snr(x)/Mt),1),2);
end
end

%% Ergodic channel capacity with CSI
function Ce_CSI = ergodic_CSI_5( lamda, gamma, snr, Mt )
%ERGODIC_CSI Summary of this function goes here
%   Detailed explanation goes here
parfor i=1:length(snr)
    temp=gamma(:,:,i);
    Ce_CSI(i)=mean(sum(log2(1+lamda.*temp*snr(i)/Mt),1),2);
end
end



