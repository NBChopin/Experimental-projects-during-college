clear,clc

scale=1e-9;
Ts=10*scale; 
t_rms=30*scale; 
num_ch=10000; 

pow_3=[0.9 1.38 0.3]; delay_3=[0 t_rms t_rms*2.63 ]/scale;
H_3 = [Ray_model(num_ch); 
Ray_model(num_ch); Ray_model(num_ch)].'*diag(sqrt(pow_3));
avg_pow_h_3 = mean(H_3.*conj(H_3));
% Ray_model(num_ch)].'*diag(sqrt(pow_3));

% clear,clc
% 
% scale=1e-9;
% Ts=10*scale; 
% t_rms=30*scale; 
% num_ch=10000; 
% 
% pow_3=[0.9 1.38 0.3]; 
% delay_3=[0, t_rms, t_rms*2.63]/scale;
% H_3 = zeros(num_ch, 3);
% 
% for i = 1:3
%     H_3(:,i) = Ray_model(num_ch).*sqrt(pow_3(i));
% end
% 
% avg_pow_h_3 = mean(abs(H_3).^2);
% 
figure;
hold on;
scatter(delay_3,pow_3,50,'b');
scatter(delay_3,avg_pow_h_3,10,'r');

title('三径信道模型');
xlabel('delay[ns]');
ylabel('Chinnel Power');
hold off;