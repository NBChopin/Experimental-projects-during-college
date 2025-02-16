% 参数设置
SNR = [2, 4, 6]; % 信噪比
antenna_nums = [2, 4, 8, 10]; % 天线数目
num_iterations = 1000; % 迭代次数

% 初始化平均容量存储数组
average_capacity = zeros(length(SNR), length(antenna_nums));

% 开始仿真
for i = 1:length(SNR)
    snr = SNR(i);
    for j = 1:length(antenna_nums)
        antennas = antenna_nums(j);
        capacity_sum = 0;
        
        for iter = 1:num_iterations
            % 生成随机信道
            H = (randn(antennas, antennas) + 1i * randn(antennas, antennas)) / sqrt(2);
            
            % 计算信道容量
            capacity = log2(1 + 10^(snr/10) * abs(trace(H*H'))); % 最大比合并接收
            capacity_sum = capacity_sum + capacity;
        end
        
        % 计算平均容量
        average_capacity(i, j) = capacity_sum / num_iterations;
    end
end

% 绘制曲线
figure;
hold on;
for i = 1:length(SNR)
    plot(antenna_nums, average_capacity(i, :), '-o', 'DisplayName', ['SNR = ' num2str(SNR(i)) 'dB']);
end
xlabel('天线数目');
ylabel('平均容量 (bits/s/Hz)');
title('平均容量随天线数目变化的仿真曲线');
legend;
grid on;