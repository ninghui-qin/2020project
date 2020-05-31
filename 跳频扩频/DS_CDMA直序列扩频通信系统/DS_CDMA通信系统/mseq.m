% ************************beginning of file*****************************
% mseq.m 
% 
% �˺�������m����
% 
% �Ծ�һ���� 
%    stg     = 3 
%    taps    = [ 1 , 3 ] 
%    inidata = [ 1 , 1 , 1 ] 
%    n       = 2 
% 

 
function [mout] = mseq(stg, taps, inidata, n) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% stg       m���н���
% taps      ������λ�Ĵ�����ϵ��
% inidata   ���еĳ�ʼ��
% n         ������е���Ŀ 
% mout      �����m����
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
if nargin < 4 
    n = 1; 
end 
 
mout = zeros(n,2^stg-1); 
fpos = zeros(stg,1); 
 
fpos(taps) = 1; 
 
for ii=1:2^stg-1 
     
    mout(1,ii) = inidata(stg);         % ������ݵĴ洢 
    num        = mod(inidata*fpos,2);  % �������ݵļ���
     
    inidata(2:stg) = inidata(1:stg-1); % ������λ�Ĵ�����һ����λ
    inidata(1)     = num;              % ���ط���ֵ 
     
end 
 
if n > 1 
    for ii=2:n 
        mout(ii,:) = shift(mout(ii-1,:),1,0); 
    end 
end 
 
%************************end of file**********************************
