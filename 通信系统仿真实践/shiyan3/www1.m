clc;
clear all;
close all;
M = 1000; % 循环次数
n_bins = round(M/10); % 四舍五入取整数运算
Nt = [1, 2, 4, 6, 8, 2*4, 2*6, 2*8]; % 发送端和接收端天线个数
SNR = 10; % 信噪比，单位为dB

for n = 1:length(Nt),
    N = Nt(n);
    for m = 1:M,
        H = (randn(2,N)+1i*randn(2,N))/sqrt(2);
        rho = 10^(SNR/10); 
        % 计算发送端未知信道状态信息情况下的容量
        CU(m,n) = log2(real(det(eye(2)+rho*H*H'/2)));
    end
    [cdf, c] = hist(CU(:,n), n_bins);
    plot(c, 1-(cumsum(cdf))/M)
    hold on;
end
legend('1x1', '2x2', '4x4', '6x6', '8x8', '2x4', '2x6', '2x8');
xlabel('容量');
ylabel('Pr');
title('发送端未知CSI情况下MIMO系统容量的CCDF');

% %平均容量
% for m = 1:M,
% H = (randn(N,N)+1i*randn(N,N))/sqrt(2);
% for snr_idx = 1:length(SNR),
% rho = 10^(SNR(snr_idx)/10); 
% CU(m,snr_idx) = log2(real(det(eye(N)+rho*H*H'/N)));
% [gamma,eigs] = pwr_modes(H,rho);
% CK(m,snr_idx) = sum(log2(real(1+eigs.*gamma*rho/N)));
% end
% end
% C_unknown(:,n) = mean(CU)
% C_known(:,n) = mean(CK)
% 
% %中断容量
% for snr_idx = 1:length(SNR),
% [cdf_u,co_u] = hist(CU(:,snr_idx),100);
% cdf_u = cumsum(cdf_u);
% idx_ten_percent = find(abs(cdf_u-100)==min(abs(cdf_u-100)));
% C_unknown_outage(snr_idx,n) = co_u(idx_ten_percent(1));
% [cdf_k,co_k] = hist(CK(:,snr_idx),100);
% cdf_k = cumsum(cdf_k);
% idx_ten_percent = find(abs(cdf_k-100)==min(abs(cdf_k-100)));
% C_known_outage(snr_idx,n) = co_k(idx_ten_percent);
% end
