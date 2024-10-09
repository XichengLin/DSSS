function [errorRate] = ErrorRateAnalyse(spreadFactor,sourceCodeNum,...
    m_seq,fc,fs,soureRata,snr)

% 随机信源
source = randi([0 1], 1, sourceCodeNum);
% stem(source);
% 扩频
soure_re = repelem(source, spreadFactor);
% figure(2);
% stem(soure_re);        %生成码元乘扩频因子个数的序列
soure_dsss = -(2*(soure_re-0.5)).*(2*(m_seq-0.5));  % 相乘扩频
% figure(3);
% stem(soure_dsss);    % 双极性码
N = 1/spreadFactor/soureRata/(1/fs);
soure_dsss_time =  repelem(soure_dsss, N);
n = 0:length(soure_dsss_time)-1;
% plot(soure_dsss_time);
% 调制
s1 = (soure_dsss_time+1)/2;
s2 = (-soure_dsss_time+1)/2;
s1 = s1 .* cos(2*pi*fc/fs*n);
s2 = s2 .* -cos(2*pi*fc/fs*n);
s = s1 + s2;
% plot((s(1:400)));
% 信道
s_awgn = awgn(s,snr,'measured');
% plot(s_awgn(1:1280));
% 解扩频
d_m_seq = 2*(repelem(m_seq, N)-0.5);
d_s = -d_m_seq.*s_awgn;
% plot(d_s);
% 相干解调
s_demodle = d_s.* cos(2*pi*fc/fs*n);
% plot(s_demodle);
% lpf 
n_fir = 70;
w_lp = 1.4*fc/(fs/2);
b = fir1(n_fir,w_lp);
% freqz(b,1,512);
s_lpf = filter(b,1,s_demodle);
% plot(s_lpf);
% 抽样判决
r_s = s_lpf(N*spreadFactor/2:N*spreadFactor:end);
r_s = (sign(r_s)+1)/2;
% stem(source);
% hold on;
% stem(r_s);
% 求误码率
errorNum = sum(abs(r_s - source));
errorRate = errorNum/sourceCodeNum

end