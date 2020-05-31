% ************************beginning of file*****************************
% delay.m
% �˺�������ʵ���źŵ��ӳٴ���	
% 

function [iout,qout] = delay( idata, qdata , nsamp , idel )

%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     ��������ʵ��    
% qdata     ���������鲿     
% iout      �������ʵ�� 
% qout      ��������鲿
% nsamp     ����ĳ���ֵ���� 
% idel      �ӳٵĳ���ֵ����
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

iout=zeros(1,nsamp);
qout=zeros(1,nsamp);

if idel ~= 0 
  iout(1:idel) = zeros(1,idel);
  qout(1:idel) = zeros(1,idel);
end

iout(idel+1:nsamp) = idata(1:nsamp-idel);
qout(idel+1:nsamp) = qdata(1:nsamp-idel);

%************************end of file**********************************


