%——————————————-------------------跳频信号（Alpha稳定分布）参数估计，对于alpha>1,无需低阶，直接stft


clear,clc,close all





%------------------------------------产生跳频信号
fs=4*10^3;   %采样频率
fk = [1.1 1.3 1.6 1.0 1.7 1.5 1.2 1.4]*10^3;   %跳频图案集
th=50*10^(-3);   %跳频周期，每跳驻留时间

ze = zeros(1,0);   %0表示信号延迟为零
x = []; sig = ze;
t = 0:1/fs:th-1/fs;
for i = fk;
    x = cos(2*pi*i*t);
    sig = [sig x];   %sig为输出跳频信号
end

N = length(sig);
   
%----------------------------------加入Alpha稳定分布噪声
         U=unifrnd(-pi/2,pi/2,1,1600);
        W=exprnd(1,1,1600);

       alpha=0.8;

        X=(sin(alpha*U)./cos(U).^(1/alpha)).*(cos(U-alpha*U)./W).^((1-alpha)/alpha); %产生Alpha稳定分布

       m=2;
        
        sig_temp=sig.*(10.^m/20)./std(sig);   %根据信噪比重新调整信号幅度

        sig=sig_temp+X;

    



%------------------------------------------------改进后的低阶矩短时傅里叶变换
M=N/4+1;   %汉宁窗窗长
W=hanning(M);
ye=zeros(N+M,1);
ye(M/2+1:M/2+N)=sig;

df=fs/M;    %频率分辨率
fm=1900;    %最高频率
L=round(fm/df); % the index of the max freq.
f=[0:L-1]*df;


i=1;

while i<=N
   
    p=0.2;                                            %低阶统计量的阶数
   
    
    ye_p=abs(ye(i:i+M-1)).^p.*sign(ye(i:i+M-1));  %p阶矩运算的一种定义，
    
       


   s=ye_p.*W;
   sa=hilbert(s);
   
   S=fft(sa);
   B(:,i)=S(1:L);


   i=i+1;
end
 
SP = (1/N)*abs(B.*B);
SP = SP/max(max(SP));    % 归一化


imagesc(SP)
set(gca,'YDir','normal');
title('FLOSTFT时频图');

xlabel('时域采样点','fontsize',14);
ylabel('频域采样点','fontsize',14);

