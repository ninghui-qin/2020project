% ************************beginning of file*****************************
% mseq.m 
% 
% 此函数产生m序列
% 
% 试举一例： 
%    stg     = 3 
%    taps    = [ 1 , 3 ] 
%    inidata = [ 1 , 1 , 1 ] 
%    n       = 2 
% 

 
function [mout] = mseq(stg, taps, inidata, n) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% stg       m序列阶数
% taps      线性移位寄存器的系数
% inidata   序列的初始化
% n         输出序列的数目 
% mout      输出的m序列
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
if nargin < 4 
    n = 1; 
end 
 
mout = zeros(n,2^stg-1); 
fpos = zeros(stg,1); 
 
fpos(taps) = 1; 
 
for ii=1:2^stg-1 
     
    mout(1,ii) = inidata(stg);         % 输出数据的存储 
    num        = mod(inidata*fpos,2);  % 反馈数据的计算
     
    inidata(2:stg) = inidata(1:stg-1); % 线形移位寄存器的一次移位
    inidata(1)     = num;              % 返回反馈值 
     
end 
 
if n > 1 
    for ii=2:n 
        mout(ii,:) = shift(mout(ii-1,:),1,0); 
    end 
end 
 
%************************end of file**********************************
