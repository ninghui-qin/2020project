x_code=sign(mgen(19,11,2000)-0.5); %PN��
pn=rectpulse(x_code,8);%ÿ��α��Ԫ�ڲ���8����
plot(pn);
axis([0 1000 -1.5 1.5]);
title('α���������');
grid on;
figure(2)
code_length=20;  %��Ϣ��Ԫ����
N=1:code_length;
rand('seed',0);
x=sign(rand(1,code_length)-0.5);  %��Ϣ���0��1���б��-1��1����
x1=rectpulse(x,800);%ÿ����Ԫ�ڲ���800����
plot(x1);
axis([0 16000 -1.5 1.5]);
title('��Դ��Ϣ������');
grid on;
figure(3)
gt=x1.*pn;
plot(gt);
axis([0 1000 -1.5 1.5]);
title('����������');
grid on;
figure(4);
%��BPSK����
%fs=20e6;  
%f0=30e6;
f0=6000;%�ز�Ƶ��
fs=5*f0;%����Ƶ��
for i=1:2000
    AI=2;
    dt=fs/f0;
    n=0:dt/7:dt;   %һ���ز������ڲ���8����
    cI=AI*cos(2*pi*f0*n/fs);
    x_bpsk((1+(i-1)*8):i*8)=gt((1+(i-1)*8):i*8).*cI;
end
subplot(3,1,1)
plot(x_bpsk);
axis([0 200 -2.5 2.5]);
title('BPSK���ƺ�Ĳ���');
grid on;	
%gt1=multipath(x_bpsk,fs);%�����Ѿ���д�õĶྶ�������γɴ��ྶ���ŵĽ����ź�
SNR=10;
gt1=awgn(x_bpsk,SNR);%�Ӹ�˹�������γɽ����ź�
%sigma=0;
%nt=sigma*randn(1,20);
%nt1=rectpulse(nt,800);
%gt1=gt+nt1;
%fs=20e6;  
%f0=30e6;
f0=6000;%�ز�Ƶ��
fs=5*f0;%����Ƶ��
for i=1:2000
    dt=fs/f0;
    n=0:dt/7:dt;   %һ���ز������ڲ���8����
    cI=cos(2*pi*f0*n/fs);
    x_bpsk1((1+(i-1)*8):i*8)=gt1((1+(i-1)*8):i*8).*cI;
end
subplot(3,1,3)
plot(x_bpsk1);
axis([0 200 -2.5 2.5]);
title('������ѵ����Ĳ���');
grid on;
figure(6)
 %���
for i=1:2000 
    dt=fs/f0;
    n=0:dt/7:dt; %һ���ز������ڲ����˸���
    cI=cos(2*pi*f0*n/fs);
    s((1+(i-1)*8):i*8)= x_bpsk1((1+(i-1)*8):i*8).*cI;
end
plot(s);
axis([0 200 -2.5 2.5]);
title('�����Ĳ���');
grid on;
figure(7)
%��ؽ���
jk_code=s.*pn;
%��ͨ�˲�
wn=1/500;  
b=fir1(16,wn);
H=freqz(b,1,16000);
xx=filter(b,1,jk_code);
plot(xx);
axis([0 16000 -1.5 1.5]);
title('�������˲���Ĳ���');
grid on;
for i=1:16000
     if xx(i)<0
        xx1(i)=-1;
    else
        xx1(i)=1;
     end
end
%��Դ��Ϣ�����ն˻ָ����Ĳ��εıȽ�
figure(8)
subplot(2,1,1);
plot(x1);
axis([0 16000 -1.5 1.5]);
title('��Դ��Ϣ������');
grid on;
subplot(2,1,2);
plot(xx1);
axis([0 16000 -1.5 1.5]);
title('�ն˽��յ��Ĳ���');
grid on;
[m,n]=symerr(xx1,x1);%m��ʾ���������n��ʾ������

