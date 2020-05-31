% ************************beginning of file*****************************
% compoversamp2.m 
% 
% �˺���ʵ��"sample"��������
% 
 
function [iout,qout] = compoversamp2(iin, qin, sample) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% iin     ��������ʵ��
% qin     ���������鲿
% iout    �������ʵ��
% qout    ��������鲿 
% sample  �������ı���
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
[h,v] = size(iin); 
 
iout = zeros(h,v*sample); 
qout = zeros(h,v*sample); 
 
iout(:,1:sample:1+sample*(v-1)) = iin; 
qout(:,1:sample:1+sample*(v-1)) = qin; 
 
%************************end of file**********************************
