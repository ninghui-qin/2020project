% ************************beginning of file*****************************
% compconv2.m 
% 
% �˺�������ʵ�������źŵ��˲�
% 

 
function [iout, qout] = compconv2(idata, qdata, filter) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata      ��������ʵ��
% qdata      ���������鲿
% iout       �������ʵ�� 
% qout       ��������鲿 
% filter     �˲�����ϵ��
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
iout = conv2(idata,filter); 
qout = conv2(qdata,filter); 
 
%************************end of file**********************************
