%����������������������������-------------------��Ƶ�źţ�Alpha�ȶ��ֲ����������ƣ�����alpha>1,����ͽף�ֱ��stft


clear,clc,close all





%------------------------------------������Ƶ�ź�
fs=4*10^3;   %����Ƶ��
fk = [1.1 1.3 1.6 1.0 1.7 1.5 1.2 1.4]*10^3;   %��Ƶͼ����
th=50*10^(-3);   %��Ƶ���ڣ�ÿ��פ��ʱ��

ze = zeros(1,0);   %0��ʾ�ź��ӳ�Ϊ��
x = []; sig = ze;
t = 0:1/fs:th-1/fs;
for i = fk;
    x = cos(2*pi*i*t);
    sig = [sig x];   %sigΪ�����Ƶ�ź�
end

N = length(sig);
   
%----------------------------------����Alpha�ȶ��ֲ�����
         U=unifrnd(-pi/2,pi/2,1,1600);
        W=exprnd(1,1,1600);

       alpha=0.8;

        X=(sin(alpha*U)./cos(U).^(1/alpha)).*(cos(U-alpha*U)./W).^((1-alpha)/alpha); %����Alpha�ȶ��ֲ�

       m=2;
        
        sig_temp=sig.*(10.^m/20)./std(sig);   %������������µ����źŷ���

        sig=sig_temp+X;

    



%------------------------------------------------�Ľ���ĵͽ׾ض�ʱ����Ҷ�任
M=N/4+1;   %����������
W=hanning(M);
ye=zeros(N+M,1);
ye(M/2+1:M/2+N)=sig;

df=fs/M;    %Ƶ�ʷֱ���
fm=1900;    %���Ƶ��
L=round(fm/df); % the index of the max freq.
f=[0:L-1]*df;


i=1;

while i<=N
   
    p=0.2;                                            %�ͽ�ͳ�����Ľ���
   
    
    ye_p=abs(ye(i:i+M-1)).^p.*sign(ye(i:i+M-1));  %p�׾������һ�ֶ��壬
    
       


   s=ye_p.*W;
   sa=hilbert(s);
   
   S=fft(sa);
   B(:,i)=S(1:L);


   i=i+1;
end
 
SP = (1/N)*abs(B.*B);
SP = SP/max(max(SP));    % ��һ��


imagesc(SP)
set(gca,'YDir','normal');
title('FLOSTFTʱƵͼ');

xlabel('ʱ�������','fontsize',14);
ylabel('Ƶ�������','fontsize',14);

