function [ gamma_opt ] = waterfill( H )
%WATERFILL [ gamma_opt ] = waterfill( H )
%  Input:
%  H - transfer function of one pari antenna element. [Mr, Mt, Nf]=size(H);
% 
%  Output:
%  gamma_opt - waterfilling in descening order. Make sure its corresponding
%  lambda is also in descending order!
% 
% 
% 

%%
% Normalization
[Mr, Mt, Nr]=size(H);
parfor x=1:Nr
    Hf(x)=norm(H(:,:,x),'fro');
end
Hf=sum(Hf.^2);
Hn=H*((Hf/(Nr*Mt*Mr))^(-0.5));

rho=1;
lim=Mt;
Hn_h=permute(conj(Hn), [2 1 3]);
R=times3d(Hn, Hn_h);
% R=hf*hf';
gamma_opt=zeros(Mr, Nr);
parfor x=1:Nr
    lambda=eig(R(:,:,x));
%     lambda_out(:,x)=sort(lambda,'descend');
    lambda=round(lambda);
    lambda=lambda(lambda>0);
    lvl=Mt./(rho*lambda);
    lvl=sort(lvl,'descend');
    lvl=lvl(isfinite(lvl));
    [r,~] = size(lvl);
    p = 1;
    mu = lim/(r-p+1)*(1+(1./rho)*sum(1./lambda(1:r-p+1)));
    gamma = (mu-lvl);
    gamma2 = gamma;
    %%
    % iteration
    while find(gamma2 < 0 & p < r)
        p = p+1;
        mu = lim/(r-p+1)*(1+(1./rho)*sum(1./lambda(1:r-p+1)));
        gamma = (mu-lvl);
        gamma2 = gamma(1:r-p+1);
    end
    gamma_t = flipud(max(gamma,0));
    gamma_t(Mr+1)=0;
    gamma_t(end)=[];
    gamma_opt(:, x)=gamma_t;
    
end

end

