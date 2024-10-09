function [m_seq] = PnCodeGen(num)
coef = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1];
m = length(coef)-1;
len = 2^m-1;
seq=zeros(1,len); % 给生成的m序列预分配

registers = [1 zeros(1, m-2) 1];
for i = 1:len
    seq(i) = registers(m);
    reg_back = xor(registers(m-1),registers(m));
    registers = [reg_back registers(1:m-1)];
end
m_seq = seq(1:num);
end