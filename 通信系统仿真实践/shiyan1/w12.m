N=200000; %��?200000���ŵ�ϵ����ͳ��ʹ��
level=30; %ͳ�����䱻���ֵķ�����
K_dB=[-39.4 0 15];%��˹��?Ϊ-39.4dB��0dB��15dB
gss=['r-*'; 'b-o'; 'm-+';'g-^'];%�������ߵ���?���������־����
%Rayleigh_ch=zeros(1,N);
% ����ģ��
Rayleigh_ch=Ray_model(N);%����Ray_model?���򣬲�?�����ֲ�����ϵ��
[temp,x]=hist(abs(Rayleigh_ch(1,:)),level);%ͳ�����ݷֲ�
plot(x,temp,gss(1,:))
hold on
%��˹ģ��
for i=1:length(K_dB);%�Բ�ͬ��˹��?��?�ŵ�ģ�ͷ���
Rician_ch(i,:) = Ric_model(K_dB(i),N);%����Ric_model��?��˹�ֲ�����ϵ��
[temp x] = hist(abs(Rician_ch(i,:)),level);%ͳ�����ݷֲ�
plot(x,temp,gss(i+1,:))
end