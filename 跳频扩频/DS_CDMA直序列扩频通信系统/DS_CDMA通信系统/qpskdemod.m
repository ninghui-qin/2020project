% ************************beginning of file*****************************
% qpskdemod.m 
% 
% 此函数实现QPSK解调
% 
 
 
function [demodata]=qpskdemod(idata,qdata,para,nd,ml) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     输入数据的实部 
% qdata     输入数据的虚部
% demodata  解调后的数据
% para      并行的信道数
% nd        输入数据个数
% ml        调制阶数
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

demodata=zeros(para,ml*nd); 
demodata((1:para),(1:ml:ml*nd-1))=idata((1:para),(1:nd))>=0; 
demodata((1:para),(2:ml:ml*nd))=qdata((1:para),(1:nd))>=0; 
 
%************************end of file**********************************
