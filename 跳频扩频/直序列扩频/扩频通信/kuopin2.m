x_code=sign(mgen(19,11,2000)-0.5); %PN码
pn=rectpulse(x_code,8);%每个伪码元内采样8个点
plot(pn);
axis([0 1000 -1.5 1.5]);
title('伪随机码序列');
grid on;
figure(2)
code_length=20;  %信息码元个数
N=1:code_length;
rand('seed',0);
x=sign(rand(1,code_length)-0.5);  %信息码从0、1序列变成-1、1序列
x1=rectpulse(x,800);%每个码元内采样800个点
plot(x1);
axis([0 16000 -1.5 1.5]);
title('信源信息码序列');
grid on;
figure(3)
gt=x1.*pn;
plot(gt);
axis([0 1000 -1.5 1.5]);
title('复合码序列');
grid on;
figure(4);
%用BPSK调制
%fs=20e6;  
%f0=30e6;
f0=6000;%载波频率
fs=5*f0;%采样频率
for i=1:2000
    AI=2;
    dt=fs/f0;
    n=0:dt/7:dt;   %一个载波周期内采样8个点
    cI=AI*cos(2*pi*f0*n/fs);
    x_bpsk((1+(i-1)*8):i*8)=gt((1+(i-1)*8):i*8).*cI;
end
subplot(3,1,1)
plot(x_bpsk);
axis([0 200 -2.5 2.5]);
title('BPSK调制后的波形');
grid on;	
%gt1=multipath(x_bpsk,fs);%调用已经编写好的多径函数，形成带多径干扰的接收信号
SNR=10;
gt1=awgn(x_bpsk,SNR);%加高斯白噪声形成接收信号
%sigma=0;
%nt=sigma*randn(1,20);
%nt1=rectpulse(nt,800);
%gt1=gt+nt1;
%fs=20e6;  
%f0=30e6;
f0=6000;%载波频率
fs=5*f0;%采样频率
for i=1:2000
    dt=fs/f0;
    n=0:dt/7:dt;   %一个载波周期内采样8个点
    cI=cos(2*pi*f0*n/fs);
    x_bpsk1((1+(i-1)*8):i*8)=gt1((1+(i-1)*8):i*8).*cI;
end
subplot(3,1,3)
plot(x_bpsk1);
axis([0 200 -2.5 2.5]);
title('加噪后已调波的波形');
grid on;
figure(6)
 %解调
for i=1:2000 
    dt=fs/f0;
    n=0:dt/7:dt; %一个载波周期内采样八个点
    cI=cos(2*pi*f0*n/fs);
    s((1+(i-1)*8):i*8)= x_bpsk1((1+(i-1)*8):i*8).*cI;
end
plot(s);
axis([0 200 -2.5 2.5]);
title('解调后的波形');
grid on;
figure(7)
%相关解扩
jk_code=s.*pn;
%低通滤波
wn=1/500;  
b=fir1(16,wn);
H=freqz(b,1,16000);
xx=filter(b,1,jk_code);
plot(xx);
axis([0 16000 -1.5 1.5]);
title('解扩并滤波后的波形');
grid on;
for i=1:16000
     if xx(i)<0
        xx1(i)=-1;
    else
        xx1(i)=1;
     end
end
%信源信息码与收端恢复出的波形的比较
figure(8)
subplot(2,1,1);
plot(x1);
axis([0 16000 -1.5 1.5]);
title('信源信息码序列');
grid on;
subplot(2,1,2);
plot(xx1);
axis([0 16000 -1.5 1.5]);
title('收端接收到的波形');
grid on;
[m,n]=symerr(xx1,x1);%m表示误码个数，n表示误码率

