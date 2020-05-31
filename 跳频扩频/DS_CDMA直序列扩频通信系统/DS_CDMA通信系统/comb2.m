% ************************beginning of file*****************************
% comb2.m 
% 
% 此函数实现信道的高斯白噪声
% 
 
function [iout, qout] = comb2(idata, qdata, attn) 
 
%%+++++++++++++++++++++++variables++++++++++++++++++++++++++++
% idata    输入序列实部
% qdata    输入序列虚部 
% iout     输出序列实部 
% qout     输出序列虚部
% attn     根据信噪比得到的信号衰减水平 
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
v = length(idata); 
h = length(attn); 
 
iout = zeros(h,v); 
qout = zeros(h,v); 
 
for ii=1:h 
    iout(ii,:) = idata + randn(1,v) * attn(ii); 
    qout(ii,:) = qdata + randn(1,v) * attn(ii); 
end  
%************************end of file**********************************
