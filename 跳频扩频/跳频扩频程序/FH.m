clear all 
clc
%控制频率合成器产生频率变化的载波
%---------初始化---------------
MAXCLOCK=63; 
m=90;
PNSeq=mseq(1);
PNSeqNum=1; %第几次选择频率
SaveFrq=[];
CLOCK=0;
while CLOCK < MAXCLOCK
CLOCK=CLOCK+1;
%---------选择频率---------------
if PNSeqNum>(m-6)
    PNSeqNum=1;
end
MixFrq=SelectFrq(PNSeq(PNSeqNum:PNSeqNum+6));
PNSeqNum=PNSeqNum+1;
SaveFrq=[SaveFrq MixFrq];
end
%---------初始化---------------
Ts=0.00001; fs=1/Ts;
EndTime=2-Ts; %2s
%---------产生信息序列(双极性不归零码)---------------
Tm=0.25; fm=1/Tm; %码率
[u,time] = gensig('square',2*Tm,EndTime,Ts);
y = 2*(u-0.5);
%---------FSK调制---------------
T0=0.1; f0=1/T0;
T1=0.2; f1=1/T1;
[u0,time]=gensig('sin',T0,EndTime,Ts);
[u1,time]=gensig('sin',T1,EndTime,Ts);
y0=u0.*sign(-y+1);
y1=u1.*sign(y+1);
SignalFSK=y0+y1; % FSK信号
%---------FSK调制的频谱---------------
nfft=fs+1; 
Y = fft(SignalFSK,nfft);
PSignalFSK = Y.* conj(Y)/nfft;
f = fs*(0:nfft/2)/nfft; 
%---------FSK调制后，低通滤波---------------
cof_low=fir1(64,25/fs); 
SignalFSK_l=filter(cof_low,1,SignalFSK);
YSignalFSK_l = fft(SignalFSK_l,nfft);
PSignalFSK_l = YSignalFSK_l.* conj(YSignalFSK_l)/nfft;
f = fs*(0:nfft/2)/nfft;
%---------混频-------------- 
i=1;
while(i<MAXCLOCK)
    i=i+1;
    fc=SaveFrq(i);
    Tc=1/fc; %频点
    [Carrier,time] = gensig('sin',Tc,EndTime,Ts); %产生扩频载波
    MixSignal=SignalFSK_l.*Carrier;
    %---------带通滤波--------
    cof_band=fir1(64,[fc-12.5,fc+12.5]/fs);
    yMixSignal=filter(cof_band,1,MixSignal);
    YMixSignal = fft(yMixSignal,nfft);
    PMixSignal = YMixSignal.* conj(YMixSignal)/nfft;
    f = fs*(0:nfft/2)/nfft;
    figure(8);
    plot(f,PMixSignal(1:nfft/2+1));
    title('经过带通滤波的混频信号频谱');
    xlabel('frequency (Hz)');
    axis([1000 2200 -inf inf]);
    %----------传输信道--------------
    Sign_send=yMixSignal; 
    Sign_rec=Sign_send;
    %----------传输信道---------------
    %----------接收端---------------
    %----------解扩----------------  
    Tc=1/fc;
    [Carrier,time]=gensig('sin',Tc,EndTime,Ts); %产生扩频载波
    Sign_rec=Sign_send;
    ySign_rec=Sign_rec.*Carrier;
    %----------低通滤波,取下边频------------
    yrr=ySign_rec;
    cof_low=fir1(64,25/fs);
    Sign_rec_l=filter(cof_low,1,ySign_rec);
    YSign_rec_l = fft(Sign_rec_l,nfft);
    PSign_rec_l = YSign_rec_l.* conj(YSign_rec_l)/nfft;
    f = fs*(0:nfft/2)/nfft;
    %----------FSK译码--------------
    cof_f0=fir1(64,[f0-0.25,f0+0.25]/fs);
    cof_f1=fir1(64,[f1-0.25,f1+0.25]/fs);
    DeFSK0=filter(cof_f0,1,Sign_rec_l);
    DeFSK1=filter(cof_f1,1,Sign_rec_l);
    rDeFSK0=DeFSK0.*u0;
    rDeFSK1=DeFSK1.*u1;
    rDeFSK=rDeFSK0-rDeFSK1;
    %-----------采样判决---------------
    Sampletime=0.25/Ts;
    Message=[];
    Num=0;
    while(Num<2/Ts)
    if(mod(Num,Sampletime)==0)
    Message=[Message ones(1,Sampletime+1)*sign(sum(rDeFSK((Num+1):(Num+Sampletime))))];
    end 
    Num=Num+Sampletime;
    end 
    figure(13);
    plot((1:length(Message))/fs,Message);
    title('恢复的信息');
    xlabel('time (seconds)');
    axis([-2 4 -2 2]);
end