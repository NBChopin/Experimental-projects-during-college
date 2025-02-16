clc;  
clear;  
close all;  
  
% ����QAM���ƽ���  
M1 = 16; % 16QAM  
M2 = 64; % 64QAM  
  
% ����������ݲ�����QAM����  
data1 = randi([0 M1-1], 1000, 1);  
dataSymbols1 = qammod(data1, M1);  
data2 = randi([0 M2-1], 1000, 1);  
dataSymbols2 = qammod(data2, M2);  
  
% ����ԭʼ�źŵ�����ͼ  
figure;  
scatterplot(dataSymbols1);  
title('16QAMԭʼ�ź�����ͼ');  
  
figure;  
scatterplot(dataSymbols2);  
title('64QAMԭʼ�ź�����ͼ');  
  
% ����SNR��Χ  
SNR_dB = [2, 10, 15, 16.82, 20, 15.76];  
BER1 = zeros(size(SNR_dB));  
BER2 = zeros(size(SNR_dB));  
BER1_windowed = zeros(size(SNR_dB));  
  
% ������ͬ��SNRֵ  
for i = 1:length(SNR_dB)  
    snr = 10^(SNR_dB(i)/10);  
      
    % ��Ӹ�˹����  
    noisySymbols1 = awgn(dataSymbols1, snr, 'measured');  
    noisySymbols2 = awgn(dataSymbols2, snr, 'measured');  
      
    % ����ź�  
    receivedData1 = qamdemod(noisySymbols1, M1);  
    receivedData2 = qamdemod(noisySymbols2, M2);  
      
    % ����������  
    [~, BER1(i)] = biterr(receivedData1, data1);  
    [~, BER2(i)] = biterr(receivedData2, data2);  
      
    % ���ƽ���źŵ�����ͼ  
    figure;  
    scatterplot(noisySymbols1);  
    title(['16QAM����ź�����ͼ��SNR = ', num2str(SNR_dB(i)), ' dB']);  
      
    figure;  
    scatterplot(noisySymbols2);  
    title(['64QAM����ź�����ͼ��SNR = ', num2str(SNR_dB(i)), ' dB']);  
      
    % �Ӵ������˴���Ϊʾ����δʵ�־��崰������  
    if any(SNR_dB(i) == [10, 15, 16.82, 20])  
        % ���贰��������ʵ��Ӧʵ�־��崰������  
        windowedSymbols1 = noisySymbols1; % ʾ����δ�ı��ź�  
        receivedData1_windowed = qamdemod(windowedSymbols1, M1);  
        [~, BER1_windowed(i)] = biterr(receivedData1_windowed, data1);  
    end  
end  
  
% ������������SNR�Ĺ�ϵ����  
figure;  
semilogy(SNR_dB, BER1, 'b-x');  
hold on;  
semilogy(SNR_dB, BER2, 'r-o');  
semilogy(SNR_dB([1, 3:5]), BER1_windowed([1, 3:5]), 'k-s'); % ע��������ӦSNRֵ  
legend('16QAM', '64QAM', '16QAM�Ӵ�');  
xlabel('SNR (dB)');  
ylabel('������');  
title('��������SNR�Ĺ�ϵ');  
grid on;