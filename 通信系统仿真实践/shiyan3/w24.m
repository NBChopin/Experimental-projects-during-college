clear,clc;
% 参数设置
SNR = [2, 4, 6]; % 信噪比
antenna_nums = [2, 4, 6, 8]; % 天线数目
interrupt_percentages = [0.10, 0.15, 0.20]; % 中断概率
num_iterations = 1000; % 迭代次数

% 初始化中断容量存储数组
interrupt_capacity = zeros(length(interrupt_percentages), length(antenna_nums));

% 开始仿真
for snr_idx = 1:length(SNR)
    snr = SNR(snr_idx);
    
    for i = 1:length(antenna_nums)
        num_antennas = antenna_nums(i);
        
        for j = 1:length(interrupt_percentages)
            interrupt_percentage = interrupt_percentages(j);
            capacity_sum = 0;
            
            for iter = 1:num_iterations
                % 生成随机信道
                H = (randn(num_antennas, num_antennas) + 1i * randn(num_antennas, num_antennas)) / sqrt(2);
                
                % 计算信道容量
                capacity = log2(1 + 10^(snr/10) * abs(trace(H*H')));
                
                % 根据中断概率计算中断容量
                interrupted_capacity = capacity * (1 - interrupt_percentage);
                
                capacity_sum = capacity_sum + interrupted_capacity;
            end
            
            % 计算平均中断容量
            average_interrupt_capacity = capacity_sum / num_iterations;
            interrupt_capacity(j, i) = average_interrupt_capacity;
        end
    end
    
    % 绘制中断容量随天线数目变化的曲线
    figure;
    hold on;
    for k = 1:length(interrupt_percentages)
        plot(antenna_nums, interrupt_capacity(k, :), '-o', 'DisplayName', ['Interrupt Percentage = ' num2str(interrupt_percentages(k)*100) '%']);
    end
    xlabel('天线数目');
    ylabel('中断容量 (bits/s/Hz)');
    title(['中断容量随天线数目变化的仿真曲线 SNR = ' num2str(snr) ' dB']);
    legend;
    grid on;
end