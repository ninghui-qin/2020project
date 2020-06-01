function mseq=m_seq(prim_poly)
clc;
%fbconnection=de2bi(oct2dec(prim_poly))
%fbconnection=fbconnection(end-1:-1:1)
%n=length(fbconnection)
%N=2^n-1;
%register=ones(1,n);
%mseq=zeros(1,N);
%mseq(1)=register(n);
%for i=2:n
%    newregister(1)=mod(sum(fbconnection.*register),2);
 %   for j=2:n
%        newregister(j)=register(j-1);
%    end
 %   register=newregister;
%    m_seq(i)=register(n);                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
%end

% x=dec2bin(base2dec(num2str(prim_poly),8))
% n=length (x)
% N=2^n-1
% reg =zeros(1,n);
% mseq=zeros(1,N+1);
% mseq(1) =reg(n);
% for i=2:N
%     reg0(1)=mod(sum(x.*reg),2);
%     for j=2:n
%         reg0(j)=reg(j-1);
%     end
%     reg=reg0;
%     mseq(i)=reg(n);
% end

%x=dec2bin(base2dec(num2str(prim_poly),8))
fbconnection=de2bi(oct2dec(prim_poly));
x=fbconnection(end-1:-1:1)
%下面产生m=8的序列
m=length(x);
N=2^m-1;
register=[ones(1,m-1) 1];  %移位寄存器的初始状态
new_register=zeros(1,m);
m_seq_out8=zeros(1,N+1);
m_seq_out8(1)=register(m);
for i=2:N
    new_register(1)=mod(sum(x.*register),2); %移存器与反馈系数进行模2加，更新移存器第1个数
    for j=2:m
        new_register(j)=register(j-1); %更新移存器其他数
    end
    register=new_register;
    m_seq_out8(i)=register(m);  %输出
end

mseq= m_seq_out8;