% ************************beginning of file*****************************
% qpskdemod.m 
% 
% �˺���ʵ��QPSK���
% 
 
 
function [demodata]=qpskdemod(idata,qdata,para,nd,ml) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     �������ݵ�ʵ�� 
% qdata     �������ݵ��鲿
% demodata  ����������
% para      ���е��ŵ���
% nd        �������ݸ���
% ml        ���ƽ���
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

demodata=zeros(para,ml*nd); 
demodata((1:para),(1:ml:ml*nd-1))=idata((1:para),(1:nd))>=0; 
demodata((1:para),(2:ml:ml*nd))=qdata((1:para),(1:nd))>=0; 
 
%************************end of file**********************************
