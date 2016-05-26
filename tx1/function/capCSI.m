function [ cap ] = capCSI( H, snr )
%CAPCSI Summary of this function goes here
%   Detailed explanation goes here

% normalization
[Mr, Mt, Nr]=size(H);
parfor x=1:Nr
    Hf(x)=norm(H(:,:,x),'fro');
end
Hf=sum(Hf.^2);
Hn=H*((Hf/(Nr*Mt*Mr))^(-0.5));

cap=zeros(Nr,length(snr));
for m=1:length(snr)
    snr_m=snr(m);
    parfor rep=1:Nr
        Hnt=Hn(:,:,rep);
        % Eigenvalue
        R=Hnt'*Hnt;
        lamda_t=eig(R);
        lamda_t=sort(real(lamda_t));
        lamda_t(lamda_t<0)=0;
        % Optimal Gamma
        lim=Mt;
        % Water level
        lvl_t=Mt./(snr_m*lamda_t);
        lvl=lvl_t(lvl_t<lim);
        % Optimal gamma
        gamma_t=waterfill2(lvl, lim);
        gamma=sort(gamma_t,'descend');
        % Eliminating unused mode
        lamda_t=sort(lamda_t,'descend');
        lamda=lamda_t(1:length(gamma));
        % Calculating capacity of each repetition
        cap_rep_snr(rep)=mean(sum(log2(1+lamda.*gamma*snr_m/Mt),1),2);      
    end
    cap(:,m)=cap_rep_snr;
end

end

