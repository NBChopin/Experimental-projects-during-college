function H=Ric_model(K_dB,L)
K = 10^(K_dB/10);%将dB值描述的莱斯因?转换为幅度值
H = sqrt(K/(K+1)) +sqrt(1/(K+1))*Ray_model(L);