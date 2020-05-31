% ************************beginning of file*****************************
% fade.m 
% 
% �˺���ʵ���ŵ�������˥�����
%  	 	 
 
function [iout,qout,ramp,rcos,rsin]=fade(idata,qdata,nsamp,tstp,fd,no,counter,flat) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     ��������ʵ��     
% qdata     ���������鲿      
% iout      �������ʵ�� 
% qout      ��������鲿  
% ramp      ����˥�� 
% rcos      ��������˥��
% rsin      ͬ�����˥�� 
% nsamp     ������      
% tstp      ��Сʱ��ֱ���                    
% fd        ��������Ƶ��               
% no        ���ڲ���˥��Ĳ���    
% counter   ˥�����                           
% flat      �Ƿ���ƽ̹˥�� 
% (1->flat (ֻ�з���˥��),0->nomal(��λ�ͷ��ȶ�˥��)     
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
if fd ~= 0.0   
    ac0 = sqrt(1.0 ./ (2.0.*(no + 1)));   
    as0 = sqrt(1.0 ./ (2.0.*no));          
    ic0 = counter;                       
  
    pai = 3.14159265;    
    wm = 2.0.*pai.*fd; 
    n = 4.*no + 2; 
    ts = tstp; 
    wmts = wm.*ts; 
    paino = pai./no;                         
 
    xc=zeros(1,nsamp); 
    xs=zeros(1,nsamp); 
    ic=[1:nsamp]+ic0; 
 
  for nn = 1: no 
	  cwn = cos( cos(2.0.*pai.*nn./n).*ic.*wmts ); 
	  xc = xc + cos(paino.*nn).*cwn; 
	  xs = xs + sin(paino.*nn).*cwn; 
  end 
 
  cwmt = sqrt(2.0).*cos(ic.*wmts); 
  xc = (2.0.*xc + cwmt).*ac0; 
  xs = 2.0.*xs.*as0; 
 
  ramp=sqrt(xc.^2+xs.^2);    
  rcos=xc./ramp; 
  rsin=xs./ramp; 
 
  if flat ==1 
    iout = sqrt(xc.^2+xs.^2).*idata(1:nsamp);   
    qout = sqrt(xc.^2+xs.^2).*qdata(1:nsamp);    
  else 
    iout = xc.*idata(1:nsamp) - xs.*qdata(1:nsamp);   
    qout = xs.*idata(1:nsamp) + xc.*qdata(1:nsamp);   
  end 
 
else   
  iout=idata; 
  qout=qdata; 
end 
 
%************************end of file**********************************

