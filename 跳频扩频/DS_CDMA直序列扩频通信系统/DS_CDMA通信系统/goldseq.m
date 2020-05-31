% ************************beginning of file*****************************
% goldseq.m 
% 
%此函数用于产生gold序列
% 

 
function [gout] = goldseq(m1, m2, n) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% m1     第一个m序列
% m2     第二个m序列 
% n      输出序列的数目
% gout   输出产生的gold序列
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
if nargin < 3 
    n = 1; 
end 
 
gout = zeros(n,length(m1)); 
 
for ii=1:n 
    gout(ii,:) = xor(m1,m2); 
    m2         = shift(m2,1,0); 
end 
 
%************************end of file**********************************
