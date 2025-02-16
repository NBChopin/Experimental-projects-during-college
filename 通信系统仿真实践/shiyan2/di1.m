clear all;
close all;
clc;

M = 16; % 16QAM
msgLen = 10000; % 信号长度
SNR_dB = 2:0.5:15.76; % 信噪比范围
SNR = 10.^(SNR_dB/10);

% 生成随机的16QAM信号
data = randi([0 M-1],1,msgLen);
txSig = qammod(data, M);

% 绘制发送端16QAM信号星座图
scatterplot(txSig);
title('Transmitted 16QAM Signal Constellation');

% AWGN信道
rxSig = cell(length(SNR),1);
for i = 1:length(SNR)
    rxSig{i} = awgn(txSig, SNR(i), 'measured');
end

% 解调后16QAM信号星座图（不加窗）
scatterplot(rxSig{1});
title('Received 16QAM Signal Constellation without Equalization (SNR=2dB)');

% 解调后16QAM信号星座图（加窗）
rxSigEq = cell(length(SNR),1);
for i = 1:length(SNR)
    rxSigEq{i} = pamdemod(rxSig{i}, M, 0, 'gray');
end

scatterplot(rxSigEq{1});
title('Received 16QAM Signal Constellation with Equalization (SNR=2dB)');

% 计算误码率并绘制误码率 vs SNR曲线
errRate_noEq = zeros(1,length(SNR));
errRate_Eq = zeros(1,length(SNR));
for i = 1:length(SNR)
    dataRx_noEq = qamdemod(rxSig{i}, M);
    dataRx_Eq = qamdemod(rxSigEq{i}, M);
    [~,errRate_noEq(i)] = biterr(data,dataRx_noEq);
    [~,errRate_Eq(i)] = biterr(data,dataRx_Eq);
end

figure;
semilogy(SNR_dB,errRate_noEq,'b',SNR_dB,errRate_Eq,'r');
xlabel('SNR (dB)');
ylabel('误码率');
title('误码率 vs SNR曲线');
legend('不加窗','加窗');

