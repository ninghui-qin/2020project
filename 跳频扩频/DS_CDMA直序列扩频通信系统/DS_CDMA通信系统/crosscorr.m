% ************************beginning of file*****************************
% crosscorr.m 
% 
% �˺���ʵ���������еĻ��������
% 
 
function [out] = crosscorr(indata1, indata2, tn) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% indata1      ��һ���������� 
% indata2      �ڶ�����������
% tn           ���е����ڳ���
% out          ���������Ľ�� 
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

