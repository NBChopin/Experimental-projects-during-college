clear,clc;
% function mimo_capacity_vs_snr()  
%     % 参数设置  
%     Nt = 2;  % 发射天线数  
%     Nr = 2;  % 接收天线数  
%     SNR_dB = 0:1:20;  % SNR范围，从0dB到20dB  
%     SNR = 10.^(SNR_dB/10);  % 将SNR转换为线性比例  
%   
%     % 初始化平均容量数组  
%     capacity = zeros(size(SNR));  
%   
%     % 循环计算每个SNR下的平均容量  
%     for i = 1:length(SNR)  
%         % 假设信道矩阵H为随机生成的复矩阵，代表平坦衰落MIMO信道  
%         H = (randn(Nr, Nt) + 1j*randn(Nr, Nt)) / sqrt(2);  
%   
%         % 计算信道矩阵的奇异值  
%         [U, S, V] = svd(H, 'econ');  
%         singular_values = diag(S);  
%   
%         % 计算平均容量  
%         % 假设发射功率均匀分配在所有天线上  
%         capacity(i) = sum(log2(1 + (SNR(i) / Nt) .* abs(singular_values).^2));  
%     end  
%   
%     % 绘制结果  
%     figure;  
%     plot(SNR_dB, capacity, 'b-o');  
%     xlabel('SNR (dB)');  
%     ylabel('Average Capacity (bits/s/Hz)');  
%     title('MIMO System Average Capacity vs. SNR');  
%     grid on;  
%   
%     % 输出SNR = 2dB时的平均容量  
%     idx_2dB = find(SNR_dB == 2, 1);  
%     if ~isempty(idx_2dB)  
%         fprintf('Average Capacity at SNR = 2dB: %.2f bits/s/Hz\n', capacity(idx_2dB));  
%     else  
%         fprintf('SNR = 2dB not found in the given range.\n');  
%     end  
% end
% 
% % 设置参数
% SNR_dB = 0:0.5:20; % 信噪比范围
% SNR = 10.^(SNR_dB/10); % 转换为倍数
% error_prob = [0.1, 0.2, 0.27]; % 中断概率
% num_antennas = 2; % 天线数量
% 
% % 初始化中断容量和中断概率
% outage_capacity = zeros(length(error_prob), length(SNR));
% outage_prob = zeros(length(error_prob), length(SNR));
% 
% % 计算中断容量和中断概率
% for i = 1:length(error_prob)
%     for j = 1:length(SNR)
%         outage_prob(i, j) = error_prob(i);
%         outage_capacity(i, j) = log2(1 + SNR(j) / (num_antennas * outage_prob(i)));
%     end
% end
% 
% % 绘制仿真曲线
% figure;
% hold on;
% for i = 1:length(error_prob)
%     plot(SNR_dB, outage_capacity(i, :), 'DisplayName', ['Outage Probability: ' num2str(error_prob(i))]);
% end
% hold off;
% xlabel('SNR (dB)');
% ylabel('中断容量');
% title('中断容量随信噪比变化的仿真曲线');
% legend;
% grid on;
% 
% % 分析中断容量与中断概率之间的关系
% figure;
% plot(outage_prob(:), outage_capacity(:), 'o-');
% xlabel('SNR(dB)');
% ylabel('中断容量');
% title('中断容量随信噪比变化的仿真曲线');
% grid on;

% % 设置参数
% SNR_dB = [2, 4, 6]; % 信噪比范围
% SNR = 10.^(SNR_dB/10); % 转换为倍数
% num_antennas = [2, 4, 8, 10]; % 天线数量
% 
% % 初始化平均容量
% average_capacity = zeros(length(SNR), length(num_antennas));
% 
% % 计算平均容量
% for i = 1:length(SNR)
%     for j = 1:length(num_antennas)
%         average_capacity(i, j) = log2(1 + SNR(i) / num_antennas(j));
%     end
% end
% 
% % 绘制仿真曲线
% figure;
% hold on;
% for i = 1:length(SNR)
%     scatter(num_antennas, average_capacity(i, :), 'DisplayName', ['SNR: ' num2str(SNR_dB(i)) ' dB']);
% end
% hold off;
% xlabel('天线数目');
% ylabel('平均容量(bits/s/Hz)');
% title('MIMO系统平均容量随天线数目变化的仿真曲线');
% legend;
% grid on;

% % 设置参数
% SNR_dB = [2, 4, 6]; % 信噪比范围
% SNR = 10.^(SNR_dB/10); % 转换为倍数
% error_prob = [0.1, 0.15, 0.2]; % 中断概率
% num_antennas = [2, 4, 6, 8]; % 天线��量
% 
% % 初始化中断容量
% outage_capacity = zeros(length(error_prob), length(num_antennas), length(SNR));
% 
% % 计算中断容量
% for i = 1:length(error_prob)
%     for j = 1:length(num_antennas)
%         for k = 1:length(SNR)
%             outage_capacity(i, j, k) = log2(1 + SNR(k) / (num_antennas(j) * error_prob(i)));
%         end
%     end
% end
% 
% % 绘制仿真曲线
% figure;
% hold on;
% for i = 1:length(error_prob)
%     for k = 1:length(SNR)
%         scatter(num_antennas, outage_capacity(i, :, k), 'DisplayName', ['Outage Probability: ' num2str(error_prob(i)) ', SNR: ' num2str(SNR_dB(k)) ' dB']);
%         plot(num_antennas, outage_capacity(i, :, k), 'DisplayName', ['Outage Probability: ' num2str(error_prob(i)) ', SNR: ' num2str(SNR_dB(k)) ' dB']);
%     end
% end
% hold off;
% xlabel('天线数目');
% ylabel('中断容量(bits/s/Hz)');
% title('MIMO系统10%、 15%、 20%中断容量随天线数目变化的仿真曲线');
% legend();
% grid on;

% 设置参数
SNR_dB = 0:20; % 信噪比范围：0到20 dB
SNR = 10.^(SNR_dB/10); % 转换为倍数

% 初始化平均容量
average_capacity = zeros(size(SNR));

% 计算平均容量
for i = 1:length(SNR)
    average_capacity(i) = log2(1 + SNR(i));
end

% 绘制仿真曲线
figure;
plot(SNR_dB, average_capacity);
xlabel('SNR (dB)');
ylabel('平均容量(bits/s/Hz)');
title('MIMO系统平均容量随信噪比变化的仿真曲线');

% 指出SNR = 2 dB时的平均容量
SNR_2dB_index = find(SNR_dB == 2);
average_capacity_at_2dB = average_capacity(SNR_2dB_index);
fprintf('在SNR = 2 dB时，平均容量为 %.2f bits/s/Hz\n', average_capacity_at_2dB);