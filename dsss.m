clear;clc;
spreadFactor = 64;
sourceCodeNum = 5e4;
m_seq = kron(ones(1,sourceCodeNum),PnCodeGen(spreadFactor));
% stem(m_seq(1:3*spreadFactor));
fc = 3e6;
fs = 12.8e6;
soureRata = 10e3;
%% 扩频码自相关性能分析
% m_seq = PnCodeGen(5e3);
% m_seq = 2*(m_seq-0.5);
% [R_mm,R_lags] = xcorr(m_seq);
% figure(1);
% stem(R_lags,R_mm);

%% 高斯信道误码率分析
staNum = 10;
snr = 0:10;
roc = zeros(size(snr));
% 计算roc曲线
for j = 1:length(snr)
    ErrorRateSta = 0;
    for i = 1:staNum
        errorRate = ErrorRateAnalyse(spreadFactor,sourceCodeNum,...
        m_seq,fc,fs,soureRata,snr(j));
        ErrorRateSta = ErrorRateSta + errorRate;
    end
    ErrorRateSta = ErrorRateSta/staNum;
    roc(j) = ErrorRateSta;
end
plot(roc);
