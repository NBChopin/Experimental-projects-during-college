clear,clc
% 生成发送端的64QAM信号
M = 64;
data = randi([0 M-1], 1000, 1);
txSig64QAM = qammod(data, M);

% 添加高斯噪声，模拟解调后的信号
rxSig64QAM = awgn(txSig64QAM, 10); % SNR=10dB

% 解调64QAM信号
rxData64QAM = qamdemod(rxSig64QAM, 64);

% 绘制64QAM发送端星座图
figure;
subplot(1, 2, 1);
scatterplot(txSig64QAM);
title('64QAM 发送端星座图');
grid on;

% 绘制解调后的64QAM信号星座图
subplot(1, 2, 2);
scatterplot(rxSig64QAM);
title('解调后 64QAM 信号星座图 (SNR=10dB)');
grid on;

