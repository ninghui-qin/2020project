% ************************beginning of file*****************************
% delay.m
% 此函数用以实现信号的延迟传输	
% 

function [iout,qout] = delay( idata, qdata , nsamp , idel )

%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     输入序列实部    
% qdata     输入序列虚部     
% iout      输出序列实部 
% qout      输出序列虚部
% nsamp     仿真的抽样值数量 
% idel      延迟的抽样值数量
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


