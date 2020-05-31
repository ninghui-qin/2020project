% ************************beginning of file*****************************
% crosscorr.m 
% 
% 此函数实现两个序列的互相关运算
% 
 
function [out] = crosscorr(indata1, indata2, tn) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% indata1      第一个输入序列 
% indata2      第二个输入序列
% tn           序列的周期长度
% out          互相关运算的结果 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

if nargin < 3 
    tn = 1; 
end 
 
ln  = length(indata1); 
out = zeros(1,ln*tn); 
 
for ii=0:ln*tn-1 
    out(ii+1) = sum(indata1.*shift(indata2,ii,0)); 
end 
 
%************************end of file**********************************

