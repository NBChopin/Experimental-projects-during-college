% 参数设置
SNR = 0:1:20; % 信噪比范围
interrupt_percentages = [0.1, 0.2, 0.27]; % 中断百分比
num_antennas = 4; % 天线数目
num_iterations = 1000; % 迭代次数

% 初始化中断容量存储数组
interrupt_capacity = zeros(length(interrupt_percentages), length(SNR));
interrupt_probability = zeros(length(interrupt_percentages), length(SNR));

% 开始仿真
for i = 1:length(interrupt_percentages)
    interrupt_percentage = interrupt_percentages(i);
    
    for j = 1:length(SNR)
        snr = SNR(j);
        num_interrupt = round(interrupt_percentage * num_antennas); % 计算中断天线数量
        
        capacity_sum = 0;
        interrupt_count = 0;
        
        for iter = 1:num_iterations
            % 生成随机信道
            H = (randn(num_antennas, num_antennas) + 1i * randn(num_antennas, num_antennas)) / sqrt(2);
            
            % 计算信道容量
            capacity = log2(1 + 10^(snr/10) * abs(trace(H*H')));
            capacity_sum = capacity_sum + capacity;
            
            % 判断是否中断
            eigenvalues = eig(H*H');
            interrupt_threshold = (sort(eigenvalues, 'descend'));(num_interrupt);
            if min(eigenvalues) >= interrupt_threshold
                interrupt_count = interrupt_count + 1;
            end
        end
        
        % 计算中断容量和中断概率
        interrupt_capacity(i, j) = capacity_sum / num_iterations; % 中断容量
        interrupt_probability(i, j) = interrupt_count / num_iterations; % 中断概率
    end
end

% 绘制中断容量随信噪比变化的曲线
figure;
hold on;
for i = 1:length(interrupt_percentages)
    plot(SNR, interrupt_capacity(i, :), '-o', 'DisplayName', ['Interrupt Percentage = ' num2str(interrupt_percentages(i)*100) '%']);
end
xlabel('SNR (dB)');
ylabel('中断容量(bits/s/Hz)');
title('中断容量随信噪比变化的仿真曲线');
legend;
grid on;

% 绘制中断概率随信噪比变化的曲线
figure;
hold on;
for i = 1:length(interrupt_percentages)
    plot(SNR, interrupt_probability(i, :), '-o', 'DisplayName', ['Interrupt Percentage = ' num2str(interrupt_percentages(i)*100) '%']);
end
xlabel('SNR (dB)');
ylabel('中断容量');
legend;
grid on;