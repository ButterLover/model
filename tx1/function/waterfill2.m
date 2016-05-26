function gamma_out = waterfill2(level, lim)

% INPUT
% 1) level: the given water levels; 
% in the textbook, it is denoted as M_T*N_0/(E_s*lambda).
% lambda(i) is in ascending order such that level(i) is in descending order.
%
% 2) lim: total energy constraint;
% in the textbook, it is denoted by M_T.
% 
% OUTPUT
% 1) gamma_out: the "optimal" energy allocation;
% in the textbook, it is denoted by gamma^{opt}.
% gamma_out(i) is in ascending order.
% 
% Note: the code is found from internet
% Edited by Ruiyuan.Tian@eit.lth.se, 2009/08/31

[r,~] = size(level);
% 
% if level(end) < level(1)
% level = flipud(level);
% end
% initialization

p = 1;
mu = lim/(r-p+1)*(1+sum(level(1:r-p+1))/lim); 
gamma = (mu-level);
gamma2 = gamma;
 
% iteration
while find(gamma2 < 0)
    p = p+1;
    mu = lim/(r-p+1)*(1+sum(level(1:r-p+1))/lim); 
    gamma = (mu-level);
    gamma2 = gamma(1:r-p+1);
end
gamma_out = flipud(max(gamma,0));


