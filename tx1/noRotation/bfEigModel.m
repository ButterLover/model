clear all; close all;
tic
load hf
%% Dominant eigenmode
elem_tx=32;
elem_rx=8;
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
cp_eig=zeros(rxN, 1);
parfor w=1:rxN
    H=Hf(:,:,:,w);
    sigma=zeros(1, Nf);
    for w1=1:Nf
%         lambda(:,w1)=eig(R(:,:,w1));
        [u, ~, vh]=svd(H(:,:,w1)); % The first column is the max singular vector
        uh=u(:, 1)';
        v=vh(:, 1);
        sigma(w1)=uh*H(:,:,w1)*v;
    end
%     lambda=sort(lambda,'descend');
    cp_t=log2(1+snr*abs(sigma).^2);
    cp_eig(w)=mean(cp_t);
end
cp_eig=cp_eig(:);
% save cpeig cp_eig
%%
% figure
% grid on
% plot(cp);
% hold on
% plot(cp_eig);
% legend('SM', 'Eig')
toc