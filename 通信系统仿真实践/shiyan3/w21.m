% 参数设置
SNR = 0:1:20; % 信噪比范围
num_antennas = 4; % 天线数目
num_iterations = 1000; % 迭代次数

% 初始化平均容量存储数组
average_capacity = zeros(1, length(SNR));

for i = 1:length(SNR)
    snr = SNR(i);
    capacity_sum = 0;
    
    for iter = 1:num_iterations
        % 生成随机信道
        H = (randn(num_antennas, num_antennas) + 1i * randn(num_antennas, num_antennas)) / sqrt(2);
        
        % 计算信道容量
        capacity = log2(1 + 10^(snr/10) * abs(trace(H*H')));
        capacity_sum = capacity_sum + capacity;
    end
    
    % 计算平均容量
    average_capacity(i) = capacity_sum / num_iterations;
end

% 绘制平均容量随信噪比变化的曲线
figure;
plot(SNR, average_capacity, '-o');
xlabel('SNR (dB)');
ylabel('Average Capacity (bits/s/Hz)');
grid on;

% 指出SNR = 2 dB时的平均容量
index_SNR_2dB = find(SNR == 2);
average_capacity_SNR_2dB = average_capacity(index_SNR_2dB);
disp(['当 SNR = 2 dB 时，平均容量为: ', num2str(average_capacity_SNR_2dB)]);