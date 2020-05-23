close all
clear
SNR_arry=0:3:18;
erro_arry1=zeros(1,7);
for times=1:10
    erro_arry=ones(1,7);
    number1=1;
    for SNR=0:3:18
sig1=round(rand(l,63));
sig2=round(rand(1,63));
sig3=round(rand(1,63));
sig4=round(rand(l,63));
signal1 =[];
signal2 =[];
signal3 =[]; 
signal4 =[];
for k = 1:63
    if sig1(1,k) == 0
        sig=-ones(1,120); 
    else
        sig=ones(1,120);
    end
signal1=[signal1 sig]; 
end
subplot(4,1,1);
plot(signal1);
axis([-100 3100  -1.5 1.5]);
title('\bf\it 发送信号');
for k= 1:63
    if sig2(1,k) == 0
        sig=-ones(1,120);
    else
        sig=ones(1,120);
    end
    signal2 = [signal2 sig];
end
for k = 1:63
    if sig3(1,k)==0
        sig=-ones(1,120);
    else
        sig =ones(l,120);
    end
    signal3 =[signal3 sig];
end
for k= 1:63
    if sig4(1,k)==0
        sig=-ones(1,120);
    else
        sig=ones(1,120);
    end
    signal4=[signal4 sig];
end
%preparation of 8 new carrier frequencies
t1=[0:2*pi/119:2*pi];
t2=[0:4*pi/119:4*pi];
t3=[0:6*pi/119:6*pi];
t4=[0:8*pi/119:8*pi];
t5=[0:10*pi/119:10*pi];
t6=[0:12*pi/119:12*pi];
t7=[0:14*pi/119:14*pi];
t8=[0:16*pi/119:16*pi];
c1=cos(t1);
s1=sin(t1);
c2=cos(t2);
s2=sin(t2);
c3=cos(t3);
s3=sin(t3);
c4=cos(t4);
s4=sin(t4);
c5=cos(t5);
s5=sin(t5);
c6=cos(t6);
s6=sin(t6);
c7=cos(t7);
s7=sin(t7);
c8=cos(t8);
s8=sin(t8);
adr1=m_seq(103);
adr1=[adr1,adr1(1),adr1(2)];
fh_seq1=[];
fh_seq2=[];
fh_seq3=[];
fh_seq4=[];
for k=1:63
    seq_1=adr1(k)*2^2+adr1(k+1)*2+adr1(k+2);
  fh_seq1=[fh_seq1 seq_1];
  seq_2=xor(adr1(k),0)*2^2+xor(adr1(k+1),0)*2+xor(adr1(k+2),1);
  fh_seq2=[fh_seq2 seq_2];
  seq_3=xor(adr1(k),0)*2^2+xor(adr1(k+1),1)*2+xor(adr1(k+2),0);
  fh_seq3=[fh_seq3 seq_3];
  seq_4=xor(adr1(k),0)*2^2+xor(adr1(k+1),1)*2+xor(adr1(k+2),1);
  fh_seq4=[fh_seq4 seq_4];
end
spread_signal1=[];
spread_signal2=[];
spread_signal3=[];
spread_signal4=[];
help_despread_signal1=[];
help_despread_signal2=[];
help_despread_signal3=[];
help_despread_signal4=[];
for k=1:63
    c=fh_seq1(k);
    switch(c)
        case(1)
            spread_signal1=[spread_signal1 c1];
            help_despread_signal1=[help_despread_signal1 s1];
        case(2)
            spread_signal1=[spread_signal1 c2];
            help_despread_signal1=[help_despread_signal1 s2];
        case(3)
            spread_signal1=[spread_signal1 c3];
            help_despread_signal1=[help_despread_signal1 s3];
        case(4)
            spread_signal1=[spread_signal1 c4];
            help_despread_signal1=[help_despread_signal1 s4];
        case(5)
            spread_signal1=[spread_signal1 c5];
            help_despread_signal1=[help_despread_signal1 s5];
        case(6)
        spread_signal1=[spread_signal1 c6];
        help_despread_signal1=[help_despread_signal1 s6];
        case(7)
            spread_signal1=[spread_signal1 c7];
            help_despread_signal1=[help_despread_signal1 s7];
        case(0)
            spread_signal1=[spread_signal1 c8];
            help_despread_signal1=[help_despread_signal1 s8];
    end
end
for k=1:63
    c=fh_seq2(k);
    switch(c)
        case(1)
            spread_signal2=[spread_signal2 c1];
            help_despread_signal2=[help_despread_signal2 s1];
        case(2)
            spread_signal2=[spread_signal2 c2];
            help_despread_signal2=[help_despread_signal2 s2];
        case(3)
            spread_signal2=[spread_signal2 c3];
            help_despread_signal2=[help_despread_signal2 s3];
        case(4)
            spread_signal2=[spread_signal2 c4];
            help_despread_signal2=[help_despread_signal2 s4];
        case(5)
            spread_signal2=[spread_signal2 c5];
            help_despread_signal2=[help_despread_signal2 s5];
        case(6)
        spread_signal2=[spread_signal2 c6];
        help_despread_signal2=[help_despread_signal2 s6];
        case(7)
            spread_signal2=[spread_signal2 c7];
            help_despread_signal2=[help_despread_signal2 s7];
        case(0)
            spread_signal2=[spread_signal2 c8];
            help_despread_signal2=[help_despread_signal2 s8];
    end
end
for k=1:63
    c=fh_seq3(k);
    switch(c)
        case(1)
            spread_signal3=[spread_signal3 c1];
            help_despread_signal3=[help_despread_signal3 s1];
        case(2)
            spread_signal3=[spread_signal3 c2];
            help_despread_signal3=[help_despread_signal3 s2];
        case(3)
            spread_signal3=[spread_signal3 c3];
            help_despread_signal3=[help_despread_signal3 s3];
        case(4)
            spread_signal3=[spread_signal3 c4];
            help_despread_signal3=[help_despread_signal3 s4];
        case(5)
            spread_signal3=[spread_signal3 c5];
            help_despread_signal3=[help_despread_signal3 s5];
        case(6)
        spread_signal3=[spread_signal3 c6];
        help_despread_signal3=[help_despread_signal3 s6];
        case(7)
            spread_signal3=[spread_signal3 c7];
            help_despread_signal3=[help_despread_signal3 s7];
        case(0)
            spread_signal3=[spread_signal3 c8];
            help_despread_signal3=[help_despread_signal3 s8];
    end
end
for k=1:63
    c=fh_seq4(k);
    switch(c)
        case(1)
            spread_signal4=[spread_signal4 c1];
            help_despread_signal4=[help_despread_signal4 s1];
        case(2)
            spread_signal4=[spread_signal4 c2];
            help_despread_signal4=[help_despread_signal4 s2];
        case(3)
            spread_signal4=[spread_signal4 c3];
            help_despread_signal4=[help_despread_signal4 s3];
        case(4)
            spread_signal4=[spread_signal4 c4];
            help_despread_signal4=[help_despread_signal4 s4];
        case(5)
            spread_signal4=[spread_signal4 c5];
            help_despread_signal4=[help_despread_signal4 s5];
        case(6)
        spread_signal4=[spread_signal4 c6];
        help_despread_signal4=[help_despread_signal4 s6];
        case(7)
            spread_signal4=[spread_signal4 c7];
            help_despread_signal4=[help_despread_signal4 s7];
        case(0)
            spread_signal4=[spread_signal4 c8];
            help_despread_signal4=[help_despread_signal4 s8];
    end
end
%spreading BPSK Signal into wider band with total of 8 frequencies
frec_hopped_sig1=signal1.*spread_signal1;
frec_hopped_sig2=signal2.*spread_signal2;
frec_hopped_sig3=signal3.*spread_signal3;
frec_hopped_sig4=signal4.*spread_signal4;
subplot(4,1,2);
plot(freq_hopped_sig1)
axis([-100 3100 -1.5 1.5]);
title('\bf\it 扩频调制信号');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%进入信道 加上多用户干扰
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag2=fh_seq1-feq_seq2;
flag3=fh_seq1-feq_seq3;
flag4=fh_seq1-feq_seq4;
dis_sig2=[];
dis_sig3=[];
dis_sig4=[];
for k=1:63
    if flag2(k)==0
        flag2(k)==1;
    else
        flag2(k)==0;
    end
end
for k=1:63
    if flag3(k)==0
        flag3(k)==1;
    else
        flag3(k)==0;
    end
end
for k=1:63
    if flag4(k)==0
        flag4(k)==1;
    else
        flag4(k)==0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%对扩频信号分散点化
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:63
    if flag2(1,k)==0
        sig=zeros(1,120);
    else
        sig=ones(1,120);
    end
    dis_sig2=[dis_sig2 sig];
end
for k=1:63
    if flag3(1,k)==0
        sig=zeros(1,120);
    else
        sig=ones(1,120);
    end
    dis_sig3=[dis_sig3 sig];
end
for k=1:63
    if flag4(1,k)==0
        sig=zeros(1,120);
    else
        sig=ones(1,120);
    end
    dis_sig4=[dis_sig4 sig];
end
dis_signal2=dis_sig2.*freq_hopped_sig2;
dis_signal3=dis_sig3.*freq_hopped_sig3;
dis_signal4=dis_sig4.*freq_hopped_sig4;
A_dis_signal2=dis_sig2.*signal2;
A_dis_signal3=dis_sig3.*signal3;
A_dis_signal4=dis_sig4.*signal4;
A_all_dia_signal=A_dis_signal2+A_dis_signal3+A_dis_signal4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%接受到多用户干扰和高斯噪声的信号
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mix_sig=freq_hopped_sig2+dis_signal2+dis_signal3+dis_signal4;
%%%%%%%%%%%%%%%%%%%%%%%%
%加高斯白噪声
%%%%%%%%%%%%%%%%%%%%
awgn_signal=awgn(mix_sig,SNR,1/2);
subplot(4,1,3)
plot(awgn_signal);
axis([-100 3100 -1.5-1.5]);
title('\bf\it\加入多径干燥和白噪声的信号');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%解调，相干解调
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
de_spread_signal=spread_signal1;

recieve_signal=awgn_signal.*de_spread_signal;
A_high_fs=A_all_dis_signal+signal1;
Sout=1/2*A(t)+1/2*cos2t+n(t)*cost;
hf_signal=1/2*A_high_fs.*(spread_signail1.^2-help_despread_signal1.*2);
signal_out=recieve_signal-hf_signal;
%%%%%%%%%%%%%%%%%%
%抽样判决
%%%%%%%%%%%%%%%%
sentenced_signal=ones(1,63);
for k=1:63
    m=120*n-60;
    if signal_out(m)<0
        sentenced_signal(n)=0;
    end
end
sentenced_signal_wave=[];
for k=1:63
    if sentenced_signal(1,k)==0
        sig=-ones(1,120);
    else
        sig=ones(1,120);
    end
    sentenced.signal.wave=[sentenced_signal_wave sig];
end
subplot(4,1,4)
plot(sentenced_signal_wave);
axis([-100 3100 -1.5 1.5]);
title('\bf\it判决恢复后信号');
[Num,Ratio]=biterr(sentenced_signal,sig1);	%输出的信噪比和误码率
erro_arry(number1)=Ratio;
number1=number1+1;
    end
erro_arry1=erro_arry1+erro_arry;
end
erro_arry1=erro_arry1/10;
figure;	%输出信噪比误码率图形
plot(SNR_arry,erro_arry1);
title('误码率');
xlabel('信噪比'),ylabel('误码率');