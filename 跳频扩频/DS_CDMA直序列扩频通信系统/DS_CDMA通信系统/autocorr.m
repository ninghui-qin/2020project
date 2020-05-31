% ************************beginning of file*****************************
% autocorr.m 
% 
% 此函数实现一个序列的自相关运算
% 
 
function [out] = autocorr(indata, tn) 
 
%%+++++++++++++++++++++++variables++++++++++++++++++++++++++++
% indata    输入序列
% tn        序列的周期长度
% out       自相关函数 
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if nargin < 2 
    tn = 1; 
end 
 
ln  = length(indata); 
out = zeros(1,ln*tn); 
 
for ii=0:ln*tn-1 
    out(ii+1) = sum(indata.*shift(indata,ii,0)); 
end 
 
%************************end of file**********************************