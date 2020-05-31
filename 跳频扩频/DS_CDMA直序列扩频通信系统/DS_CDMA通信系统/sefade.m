% ************************beginning of file*****************************
% sefade.m 
% 
% �˺�������ʵ���ŵ���Ƶ��ѡ����˥�����
%  

 
function[iout,qout,ramp,rcos,rsin]=sefade(idata,qdata,itau,dlvl,th,n0,itn,n1,nsamp,tstp,fd,flat) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     �����ʵ������     
% qdata     ������鲿����      
% iout      �����ʵ������
% qout      ������鲿���� 
% ramp      ����˥�� 
% rcos      ��������˥��
% rsin      ͬ�����˥�� 
% itau      ����ʱ��
% dlvl      ���ྶ˥����
% th        ���ྶ��ʼ��λ 
% n0        ���ڲ�������˥��Ĳ��� 
% itn       ���ྶ˥������ 
% n1        �����͸��ӳٲ������� 
% nsamp     ������  
% tstp      ��Сʱ��ֱ���  
% fd        ��������Ƶ��
% flat      �Ƿ���ƽ̹˥�� 
% (1->flat (ֻ�з���˥��),0->nomal(��λ�ͷ��ȶ�˥��)     
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
iout = zeros(1,nsamp); 
qout = zeros(1,nsamp); 
 
total_attn = sum(10 .^( -1.0 .* dlvl ./ 10.0)); 
 
for k = 1 : n1  
 
	atts = 10.^( -0.05 .* dlvl(k)); 
 
	if dlvl(k) >= 40.0  
	       atts = 0.0; 
	end 
 
	theta = th(k) .* pi ./ 180.0;	 
 
	[itmp,qtmp] = delay ( idata , qdata , nsamp , itau(k)); 
	[itmp3,qtmp3,ramp,rcos,rsin] = fade (itmp,qtmp,nsamp,tstp,fd,n0(k),itn(k),flat); 
	 
  iout = iout + atts .* itmp3 ./ sqrt(total_attn); 
  qout = qout + atts .* qtmp3 ./ sqrt(total_attn); 
 
end

%************************end of file**********************************
 