% ************************beginning of file*****************************
% sefade.m 
% 
% 此函数用于实现信道的频率选择性衰落设计
%  

 
function[iout,qout,ramp,rcos,rsin]=sefade(idata,qdata,itau,dlvl,th,n0,itn,n1,nsamp,tstp,fd,flat) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     输入的实部数据     
% qdata     输入的虚部数据      
% iout      输出的实部数据
% qout      输出的虚部数据 
% ramp      幅度衰减 
% rcos      正交分量衰减
% rsin      同相分量衰减 
% itau      各径时延
% dlvl      各多径衰减量
% th        各多径初始相位 
% n0        用于产生各径衰落的波数 
% itn       各多径衰减计数 
% n1        主径和各延迟波形总数 
% nsamp     符号数  
% tstp      最小时间分辨率  
% fd        最大多普勒频移
% flat      是否是平坦衰落 
% (1->flat (只有幅度衰落),0->nomal(相位和幅度都衰落)     
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
 