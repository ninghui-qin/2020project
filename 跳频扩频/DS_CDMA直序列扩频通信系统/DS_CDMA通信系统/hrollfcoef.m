% ************************beginning of file*****************************
% hrollfcoef.m 
% 
% 此函数用于产生Nyquist滤波器的系数
% 
 
 
function [xh] = hrollfcoef(irfn,ipoint,sr,alfs,ncc) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% irfn	  用于滤波的符号数 
% ipoint  每个符号的抽样值数
% sr      符号速率
% alfs    衰减截止频率 
% ncc     1 -- 发送端滤波  0 -- 接收端滤波 
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
xi=zeros(1,irfn*ipoint+1); 
xq=zeros(1,irfn*ipoint+1); 
 
point = ipoint; 
tr = sr ;   
tstp = 1.0 ./ tr ./ ipoint; 
n = ipoint .* irfn; 
mid = ( n ./ 2 ) + 1; 
sub1 = 4.0 .* alfs .* tr;	
 
for i = 1 : n  
 
  icon = i - mid; 
  ym = icon; 
 
  if icon == 0.0  
    xt = (1.0-alfs+4.0.*alfs./pi).* tr;  
  else  
    sub2 =16.0.*alfs.*alfs.*ym.*ym./ipoint./ipoint;  
    if sub2 ~= 1.0  
      x1=sin(pi*(1.0-alfs)/ipoint*ym)./pi./(1.0-sub2)./ym./tstp; 
      x2=cos(pi*(1.0+alfs)/ipoint*ym)./pi.*sub1./(1.0-sub2); 
      xt = x1 + x2;  
    else  
      xt = alfs.*tr.*((1.0-2.0/pi).*cos(pi/4.0/alfs)+(1.0+2.0./pi).*sin(pi/4.0/alfs))./sqrt(2.0); 
    end  
  end	 
 
  if ncc == 0	                        %当接收机情况 
    xh( i ) = xt ./ ipoint ./ tr;	 
  elseif ncc == 1                       %当发射机情况
    xh( i ) = xt ./ tr;         
  else 
    error('ncc error'); 
  end    
 
end  
 
%************************end of file**********************************
