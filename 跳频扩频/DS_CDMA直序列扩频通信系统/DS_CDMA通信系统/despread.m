% ************************beginning of file*****************************
% despread.m 
% 
% 此函数实现数据的解频
% 

 
function [iout, qout] = despread(idata, qdata, code1) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% idata     输入序列实部 
% qdata     输入序列虚部  
% iout      输出序列实部 
% qout      输出序列虚部 
% code1     扩频码序列
% %+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
switch nargin 
case { 0 , 1 } 
    error('lack of input argument'); 
case 2 
    code1 = qdata; 
    qdata = idata; 
end 
 
[hn,vn] = size(idata); 
[hc,vc] = size(code1); 
 
vn      = fix(vn/vc); 
 
iout    = zeros(hc,vn); 
qout    = zeros(hc,vn); 
 
for ii=1:hc 
    iout(ii,:) = rot90(flipud(rot90(reshape(idata(ii,:),vc,vn)))*rot90(code1(ii,:),3)); 
    qout(ii,:) = rot90(flipud(rot90(reshape(qdata(ii,:),vc,vn)))*rot90(code1(ii,:),3)); 
end 
 
%************************end of file**********************************
