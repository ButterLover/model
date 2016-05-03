clear all; close all;
tic
load hf
%% Dominant eigenmode
elem_tx=32;
elem_rx=8;
Nb_rx=4;
Nf=801;
Hf=permute(hf, [2 1 3]);
Hf=reshape(Hf, elem_rx, elem_tx, Nf, []);
[~, ~, ~, rxN]=size(Hf);
clear hf
%%
bw=1e9; % System bandwidth
B=bw/(Nf-1);    % Frequency bins bandwidth
Ptx=-30;    % Transmitting power 0dBm=-30dBw
k=1.381*10e-23;
T=290;
No=k*T; % Noise level
snr=db2pow(Ptx)/(No*B);

for w=1:rxN
    H=Hf(:,:,:,w);
%     Hh=permute( conj(H), [ 2 1 3]);
%     R=times3d(H, Hh);
%     gamma=waterfill(H);
    for w1=1:Nf
%         lambda(:,w1)=eig(R(:,:,w1));
        [u, s, vh]=svd(H(:,:,w1)); % The first column is the max singular vector
        uh=u(:, 1:Nb_rx)'; % 4x8
        v=vh(:, 1:Nb_rx); % 32x4
        sigma(:,w1)=diag(uh*H(:,:,w1)*v); % 4x8 8x32 32x4
    end
%     lambda=sort(lambda,'descend');
    cp_t=sum( log2(1+snr*abs(sigma).^2./Nb_rx), 1); % 1x801
    cp_eig4(w)=mean(cp_t, 2);
end
cp_eig4=cp_eig4(:);
save cpeig4 cp_eig4
%% 
% figure
% grid on
% plot(cp);
% hold on
% plot(cp_eig);
% legend('SM', 'Eig')
toc