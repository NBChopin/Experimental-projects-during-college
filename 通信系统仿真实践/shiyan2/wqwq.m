clc;  
clear;  
close all;  
  
% 定义QAM调制阶数  
M1 = 16; % 16QAM  
M2 = 64; % 64QAM  
  
% 生成随机数据并进行QAM调制  
data1 = randi([0 M1-1], 1000, 1);  
dataSymbols1 = qammod(data1, M1);  
data2 = randi([0 M2-1], 1000, 1);  
dataSymbols2 = qammod(data2, M2);  
  
% 绘制原始信号的星座图  
figure;  
scatterplot(dataSymbols1);  
title('16QAM原始信号星座图');  
  
figure;  
scatterplot(dataSymbols2);  
title('64QAM原始信号星座图');  
  
% 定义SNR范围  
SNR_dB = [2, 10, 15, 16.82, 20, 15.76];  
BER1 = zeros(size(SNR_dB));  
BER2 = zeros(size(SNR_dB));  
BER1_windowed = zeros(size(SNR_dB));  
  
% 遍历不同的SNR值  
for i = 1:length(SNR_dB)  
    snr = 10^(SNR_dB(i)/10);  
      
    % 添加高斯噪声  
    noisySymbols1 = awgn(dataSymbols1, snr, 'measured');  
    noisySymbols2 = awgn(dataSymbols2, snr, 'measured');  
      
    % 解调信号  
    receivedData1 = qamdemod(noisySymbols1, M1);  
    receivedData2 = qamdemod(noisySymbols2, M2);  
      
    % 计算误码率  
    [~, BER1(i)] = biterr(receivedData1, data1);  
    [~, BER2(i)] = biterr(receivedData2, data2);  
      
    % 绘制解调信号的星座图  
    figure;  
    scatterplot(noisySymbols1);  
    title(['16QAM解调信号星座图，SNR = ', num2str(SNR_dB(i)), ' dB']);  
      
    figure;  
    scatterplot(noisySymbols2);  
    title(['64QAM解调信号星座图，SNR = ', num2str(SNR_dB(i)), ' dB']);  
      
    % 加窗处理（此处仅为示例，未实现具体窗函数）  
    if any(SNR_dB(i) == [10, 15, 16.82, 20])  
        % 假设窗函数处理（实际应实现具体窗函数）  
        windowedSymbols1 = noisySymbols1; % 示例中未改变信号  
        receivedData1_windowed = qamdemod(windowedSymbols1, M1);  
        [~, BER1_windowed(i)] = biterr(receivedData1_windowed, data1);  
    end  
end  
  
% 绘制误码率与SNR的关系曲线  
figure;  
semilogy(SNR_dB, BER1, 'b-x');  
hold on;  
semilogy(SNR_dB, BER2, 'r-o');  
semilogy(SNR_dB([1, 3:5]), BER1_windowed([1, 3:5]), 'k-s'); % 注意索引对应SNR值  
legend('16QAM', '64QAM', '16QAM加窗');  
xlabel('SNR (dB)');  
ylabel('误码率');  
title('误码率与SNR的关系');  
grid on;