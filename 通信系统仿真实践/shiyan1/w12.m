N=200000; %产?200000个信道系数供统计使用
level=30; %统计区间被划分的分数。
K_dB=[-39.4 0 15];%莱斯因?为-39.4dB、0dB、15dB
gss=['r-*'; 'b-o'; 'm-+';'g-^'];%绘制曲线的颜?、线形与标志符号
%Rayleigh_ch=zeros(1,N);
% 瑞利模型
Rayleigh_ch=Ray_model(N);%调用Ray_model?程序，产?瑞利分布幅度系数
[temp,x]=hist(abs(Rayleigh_ch(1,:)),level);%统计数据分布
plot(x,temp,gss(1,:))
hold on
%莱斯模型
for i=1:length(K_dB);%对不同莱斯因?进?信道模型仿真
Rician_ch(i,:) = Ric_model(K_dB(i),N);%调用Ric_model产?莱斯分布幅度系数
[temp x] = hist(abs(Rician_ch(i,:)),level);%统计数据分布
plot(x,temp,gss(i+1,:))
end