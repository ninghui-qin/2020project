% ************************beginning of file*****************************
% comb2.m 
% 
% �˺���ʵ���ŵ��ĸ�˹������
% 
 
function [iout, qout] = comb2(idata, qdata, attn) 
 
%%+++++++++++++++++++++++variables++++++++++++++++++++++++++++
% idata    ��������ʵ��
% qdata    ���������鲿 
% iout     �������ʵ�� 
% qout     ��������鲿
% attn     ��������ȵõ����ź�˥��ˮƽ 
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
