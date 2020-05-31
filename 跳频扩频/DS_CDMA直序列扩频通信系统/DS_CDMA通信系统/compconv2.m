% ************************beginning of file*****************************
% compconv2.m 
% 
% 此函数用于实现有用信号的滤波
% 

 
function [iout, qout] = compconv2(idata, qdata, filter) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata      输入序列实部
% qdata      输入序列虚部
% iout       输出序列实部 
% qout       输出序列虚部 
% filter     滤波器的系数
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
iout = conv2(idata,filter); 
qout = conv2(qdata,filter); 
 
%************************end of file**********************************
