% ************************beginning of file*****************************
% compoversamp2.m 
% 
% 此函数实现"sample"倍升采样
% 
 
function [iout,qout] = compoversamp2(iin, qin, sample) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% iin     输入序列实部
% qin     输入序列虚部
% iout    输出序列实部
% qout    输出序列虚部 
% sample  升采样的倍数
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
[h,v] = size(iin); 
 
iout = zeros(h,v*sample); 
qout = zeros(h,v*sample); 
 
iout(:,1:sample:1+sample*(v-1)) = iin; 
qout(:,1:sample:1+sample*(v-1)) = qin; 
 
%************************end of file**********************************
