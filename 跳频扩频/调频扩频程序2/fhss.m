clc;
clear all;
N=8;
begin=0;
 picture=[0 1 0 1 0 0 1 1 0 1 1 1 0 0 0 1 0 1 1 0 1 0 0 1 0];         
if begin==0                                                       
    temp=25*rand;
    begin=floor(temp)+1;
    if (begin<19)
        n=picture(begin:begin+7);
    else
      n=[picture(begin:25),picture(1:begin-18)];
    end
else                                                          
    begin=begin+1;
    if begin==26
        begin=1;
    end
    if (begin<19)
        n=picture(begin:begin+7);
    else
      n=[picture(begin:25),picture(1:begin-18)];
    end
end
PN=n;
%PN=[0 1 2 3 0 1 2 3];
b=PN;
z=zeros(N,101);
%��Ϣ��Ԫ
figure,subplot(2,1,1)
for i=1:8,
    if(b(i)==0)
        m=zeros(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    else
        m=b(i)*ones(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    end;   
end;
xlabel('��Ϣ��Ԫ');
axis([0 8 -2 2]);
grid on;
hold off;
%----------------------------------------------------
  %FSK����
 b=PN;
subplot(2,1,2)
for i=1:8,
    if(b(i)==0)
        m=zeros(1,101);
        t=i-1:0.01:i; 
        y=sin(t.*(2)*pi);
        plot(t,y);
        hold on;
    else
        m=b(i)*ones(1,101);
        t=i-1:0.01:i;
         y=sin(t.*(2+4*m)*pi);
        plot(t,y);
        hold on;
    end;
   %y=sin(t.*(2+2*m)*pi); 
   z(i,:)=y;
  % plot(t,y);   
end;
xlabel('FSK����');
axis([0 8 -2 2]);
grid on;
hold off;
y1=z;
yfsk=[];

for i=1:8
    yfsk=[yfsk,y1(i,1:100)];
end
figure,  
yfsk=[yfsk,0];
lnx=length(yfsk);
nfft=lnx+1;
f = lnx*(0:nfft/2)/nfft;
%freq=-pi:2*pi/(lnx-1):pi;% the frequency vectorƵ������������Ϊnum
X=fft(yfsk,nfft);
%plot(freq/pi, abs(X));ylabel('|X|');axis([0 pi/pi min(abs(X)) max(abs(X))]);
plot(f,abs(X(1:nfft/2+1)));
title('FSK�ź�Ƶ��ͼ');
N=8;
 picture=[0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0];          %��Ƶͼ��
if begin==0                                           %�ж��Ƿ�����Ƶ��ʼʱ��
    temp=25*rand;
    begin=floor(temp)+1;
    if (begin<19)
        n=picture(begin:begin+7);
    else
      n=[picture(begin:25),picture(1:begin-18)];
    end
else                                                     %����Ƶͼ��˳������
    begin=begin+1;
    if begin==26
        begin=1;
    end
    if (begin<19)
        n=picture(begin:begin+7);
    else
      n=[picture(begin:25),picture(1:begin-18)];
    end  
end
PN=n;
%PN=[0 1 2 3 0 1 2 3];
b=PN;
z=zeros(N,101);
%----------------------------------------------------
  %��PN�������ֱ��ͼ
%axes(e1);
figure,subplot(2,1,1)
for i=1:8,
    if(b(i)==0)
        m=zeros(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    else
        m=b(i)*ones(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    end;
end;
xlabel('��Ƶ��');
axis([0 8 -0.2 6.2]);
grid on;
hold off;
%---------------------------------------------------------
   %��Ƶ�ʺϳɺ��ͼ
subplot(2,1,2)
for i=1:N  
a=b(i);
%ΪƵ�ʺϳɲ���
if(a==0)
    m=zeros(1,101);
elseif(a==1)
    m=ones(1,101);
elseif(a==2)
    m=2*ones(1,101);
elseif(a==3)
    m=3*ones(1,101);
end;    
 t=i-1:0.01:i;
y=sin(t.*(16+16*m)*pi);
   z(i,:)=y;
   plot(t,y)
   xlabel('��Ƶͼ��');
   axis([-0.2,8.2,-1.2,1.2]);
   hold on;
end;
 %title('α�����');
grid on;
hold off;
t=0:0.01:8;
%------------------------------------------------------------
y2=z;
ytiaopintuan=[];
for i=1:8
    ytiaopintuan=[ytiaopintuan,y2(i,1:100)];
end
figure,  
ytiaopintuan=[ytiaopintuan,0];
lnx=length(ytiaopintuan);
nfft=lnx+1;
f = lnx*(0:nfft/2)/nfft;
%freq=-pi:2*pi/(lnx-1):pi;% the frequency vectorƵ������������Ϊnum
X=fft(ytiaopintuan,nfft);
%plot(freq/pi, abs(X));ylabel('|X|');axis([0 pi/pi min(abs(X)) max(abs(X))]);
plot(f,abs(X(1:nfft/2+1)));
title('ytiaopintuan�ź�Ƶ��ͼ');
m=y1.*y2;
y3=[];
y3duibi=[];
for i=1:8
    y3=[y3,m(i,1:100)];
end;
   
y3=[y3,0];
%axes(e);
t=0:0.01:8;
figure,
plot(t,y3);   
axis([-0.2,8.2, -1.2,1.2]);
xlabel('Ƶ�ʺϳ�ͼ');
figure,
lnx=length(y3);
nfft=lnx+1;
f = lnx*(0:nfft/2)/nfft;
%freq=-pi:2*pi/(lnx-1):pi;% the frequency vectorƵ������������Ϊnum
X=fft(y3,nfft);
%plot(freq/pi, abs(X));ylabel('|X|');axis([0 pi/pi min(abs(X)) max(abs(X))]);
plot(f,abs(X(1:nfft/2+1)));
title('y3�ź�Ƶ��ͼ');
t=0:0.01:8;
%-----����------
%snr=input('�����������ʵ�λdB:');
snr=0.1;%10��5�η�����ʮDB
sgma=sqrt(1/snr)/2;
for i=1:100*8+1, 
u=rand/2;
z=sgma*(sqrt(2*log(1/(1-u))));
u=rand/2;
n=z*cos(2*pi*u);
    y(i)=n;
    y4(i)=y3(i)+n;
end
    t=0:0.01:8;
    figure,
    plot(t,y);
    xlabel('����ͼ');
    t=0:0.01:8;
    figure,                         %����ͼ
    plot(t,y4);  
    %������������ź�
    xlabel('�����ź�ͼ');
    grid on;
    %-----------�������Ƶ�ʺϳ�-----------
    PNs=PN;
    N=8;
b=PNs;
z=zeros(N,101);
%----------------------------------------------------
  %��PN�������ֱ��ͼ
%axes(e1);
figure,subplot(2,1,1)
for i=1:8,
    if(b(i)==0)
        m=zeros(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    else
        m=b(i)*ones(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    end;
end;
axis([-0.2 8.2 -0.2 3.2]);
grid on;
hold off;
%---------------------------------------------------------
   %��Ƶ�ʺϳɺ��ͼ
subplot(2,1,2)
for i=1:N  
    a=b(i);
    if(a==0)
    m=zeros(1,101);
elseif(a==1)
    m=ones(1,101);
elseif(a==2)
    m=2*ones(1,101);
elseif(a==3)
    m=3*ones(1,101);
end;
 t=i-1:0.01:i;
y=sin(t.*(16+16*m)*pi);
yduibi=sin(t.*(16)*pi);
   z(i,:)=y;
zduibi(i,:)=yduibi;
   plot(t,y)
   axis([-0.2,8.2,-1.2,1.2]);
   hold on;
end;
grid on;
hold off;
y=z;
y5=y;
y=[];
for i=1:8
    y=[y,y5(i,1:100)];
end;
y5=[y,0];
y6=y4.*y5;
t=0:0.01:8;
figure,subplot(2,1,1)
plot(t,y6);   
axis([-0.2,8.2, -1.2,1.2]);
xlabel('��Ƶ���');
grid on; 
%----��Ƶ�������----
figure,subplot(2,1,1)
t=0:0.01:8;
plot(t,y6);
subplot(2,1,2)
for i=1:8,
    t=i-1:0.01:i;
    y=y6(1,100*(i-1)+1:100*i+1);
ts=0.001; fs=1/ts; df=0.3;
m=y;
fs=1/ts;
%if nargin==2
  %  n1=0;
%else
    n1=fs/df;
%end
n2=length(m);
n=2^(max(nextpow2(n1),nextpow2(n2)));
M=fft(m,n);
m=[m,zeros(1,n-n2)];
df=fs/n;
Y=M;
Y=Y/fs;
y=m;
df1=df;
f=[0:df1:df1*(length(y)-1)]-fs/2; 
%function dem=DSB_jietiao(fs,df1,t,Y,f)
f_cutoff=120;  %�˲�����ֹƵ��
n_cutoff=floor(120/df1); %����˲���
H=zeros(size(f));
H(1:n_cutoff)=2*ones(1,n_cutoff);
H(length(f)-n_cutoff+1:length(f))=2*ones(1,n_cutoff);
DEM=H.*Y;  %�˲���������ѵ��źţ�Ƶ��
dem=real(ifft(DEM))*fs;  %�˲���������ѵ��źţ�
dem=dem(1:length(t));
    plot(t,dem)
    xlabel('�������FSK�ź�');
    grid on;
    hold on;
    y7(1,100*(i-1)+1:100*i+1)=dem;
end;
ym=y7;
Wn=0.04;
[B,A]=butter(6,Wn,'low');
yS1=filter(B,A,y7);
 t=0:0.01:8;
    figure,subplot(2,1,1)
    plot(t,yS1);
    axis([-0.2,8.2,-1.5,1.5]);
     xlabel('����ͨ�˲����ź�w1');
     grid on;
Wn=0.04;
[B,A]=butter(6,Wn,'high');
yS2=filter(B,A,ym);
 t=0:0.01:8;
    subplot(2,1,2)
    plot(t,yS2);
    axis([-0.2,8.2,-1.5,1.5]);
     xlabel('����ͨ�˲����ź�w2');
     grid on;
     figure,subplot(2,1,1)
 t=0:0.01:8;
 y=sin(2*pi*t);
 Wn=0.04;
[B,A]=butter(6,Wn,'low');
yS1_1=filter(B,A,y);
 plot(t,yS1_1);
    axis([-0.2,8.2,-1.5,1.5]);
     xlabel('�������ź�w1');
     grid on;
     subplot(2,1,2)
rdefsk1=yS1.*yS1_1;
 plot(t,rdefsk1);
    axis([-0.2,8.2,-1.5,1.5]);
     xlabel('��w1��˺���ź�');
     grid on;
     figure,subplot(2,1,1)
     t=0:0.01:8;
 y=sin(6*pi*t);
 Wn=0.04;
[B,A]=butter(6,Wn,'high');
yS2_2=filter(B,A,y);
 plot(t,yS2_2);
    axis([-0.2,8.2,-1.5,1.5]);
     xlabel('�������ź�w2');
     grid on;
     subplot(2,1,2)
rdefsk2=yS2.*yS2_2;
 plot(t,rdefsk2);
    axis([-0.2,8.2,-1.5,1.5]);
     xlabel('��w2��˺���ź�');
     grid on;
     t=0.4:0.01:8.4;
figure,subplot(2,1,1)
Wn=0.02;
[B,A]=butter(2,Wn,'low');
yS1_2=1.6*filter(B,A,rdefsk1);
 plot(t,yS1_2);
    axis([0,8.9,-1.5,1.5]);
     xlabel('w1��ͨ�˲�');
     grid on;
    Wn=0.025;
    subplot(2,1,2)
[B,A]=butter(2,Wn,'low');
yS2_3=1.6*filter(B,A,rdefsk2);
 plot(t,yS2_3);
    axis([0,8.9,-1.5,1.5]);
     xlabel('w2��ͨ�˲�');
grid on;
%-----------�о�-----------------
figure,subplot(3,1,1)
for i=1:8,
    j=80+100*(i-1);
    if(yS1_2(j)>0.3)
        m=-1*ones(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    else
        m=zeros(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    end;  
    z(i,:)=m;
end;
xlabel('����������ź�1');
axis([0 8 -2 2]);
grid on;
hold off;
y1=z;
yjiet1=[];
for i=1:8
    yjiet1=[yjiet1,y1(i,1:100)];
end 
yjiet1=[yjiet1,0];
subplot(3,1,2)
for i=1:8,
    j=80+100*(i-1);
    if(yS2_3(j)>0.3)
        m=ones(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    else
        m=zeros(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    end;
    z(i,:)=m;
end;
xlabel('����������ź�2');
axis([0 8 -2 2]);
grid on;
hold off;
y2=z;
yjiet2=[];
for i=1:8
    yjiet2=[yjiet2,y2(i,1:100)];
end 
yjiet2=[yjiet2,0];
yjietiaohout=yjiet2+yjiet1;
subplot(3,1,3)
for i=1:8,
    j=50+100*(i-1);
    if(yjietiaohout(j)>0)
        m=ones(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    else
        m=zeros(1,101);
        t=i-1:0.01:i;
        plot(t,m)
        hold on;
    end; 
end;
xlabel('����������ź�');
axis([0 8 -2 2]);
grid on;
hold off;
