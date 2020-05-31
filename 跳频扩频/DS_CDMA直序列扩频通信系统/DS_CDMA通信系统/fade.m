% ************************beginning of file*****************************
% fade.m 
% 
% 此函数实现信道的瑞利衰减设计
%  	 	 
 
function [iout,qout,ramp,rcos,rsin]=fade(idata,qdata,nsamp,tstp,fd,no,counter,flat) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     输入序列实部     
% qdata     输入序列虚部      
% iout      输出序列实部 
% qout      输出序列虚部  
% ramp      幅度衰减 
% rcos      正交分量衰减
% rsin      同相分量衰减 
% nsamp     符号数      
% tstp      最小时间分辨率                    
% fd        最大多普勒频移               
% no        用于产生衰落的波数    
% counter   衰落计数                           
% flat      是否是平坦衰落 
% (1->flat (只有幅度衰落),0->nomal(相位和幅度都衰落)     
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

