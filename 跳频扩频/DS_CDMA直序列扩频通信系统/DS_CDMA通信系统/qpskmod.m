% ************************beginning of file*****************************
% qpskmod.m 
% 
% 此函数实现QPSK调制
% 

 
function [iout,qout]=qpskmod(paradata,para,nd,ml) 
 
%+++++++++++++++++++++++variables++++++++++++++++++++++++++++ 
% paradata     输入数据
% iout         输出的实部数据
% qout         输出的虚部数据
% para         并行信道数
% nd           输入数据个数
% ml           调制阶数  
% %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 
m2=ml./2; 
 
paradata2=paradata.*2-1; 
count2=0; 
 
for jj=1:nd 
 
	isi = zeros(para,1); 
	isq = zeros(para,1); 
 
	for ii = 1 : m2  
  		isi = isi + 2.^( m2 - ii ) .* paradata2((1:para),ii+count2); 
  		isq = isq + 2.^( m2 - ii ) .* paradata2((1:para),m2+ii+count2); 
	end 
 
	iout((1:para),jj)=isi; 
	qout((1:para),jj)=isq; 
 
	count2=count2+ml; 
 
end 
 
%************************end of file**********************************

