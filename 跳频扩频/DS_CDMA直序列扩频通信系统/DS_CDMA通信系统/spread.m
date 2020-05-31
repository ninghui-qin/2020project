% ************************beginning of file*****************************
% spread.m 
% 
%此函数用于实现扩频调制
% 

 
function [iout, qout] = spread(idata, qdata, code1) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     输入序列实部 
% qdata     输入序列虚部 
% iout      输出序列实部 
% qout      输出序列虚部
% code1     扩频码序列
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
switch nargin 
case { 0 , 1 } 
    error('lack of input argument'); 
case 2 
    code1 = qdata; 
    qdata = idata; 
end 
 
[hn,vn] = size(idata); 
[hc,vc] = size(code1); 
 
if hn > hc 
    error('lack of spread code sequences'); 
end 
 
iout = zeros(hn,vn*vc); 
qout = zeros(hn,vn*vc); 
 
for ii=1:hn 
    iout(ii,:) = reshape(rot90(code1(ii,:),3)*idata(ii,:),1,vn*vc); 
    qout(ii,:) = reshape(rot90(code1(ii,:),3)*qdata(ii,:),1,vn*vc); 
end 
 
%************************end of file**********************************
