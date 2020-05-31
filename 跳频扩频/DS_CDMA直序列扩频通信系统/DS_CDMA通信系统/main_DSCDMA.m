% main_DSCDMA.m
% 这个仿真程序用于实现DS-CDMA通信系统仿真 
% 
% 

 
%+++++++++++++++++++++++准备部分+++++++++++++++++++++++++++ 

clear all;
clc 

sr   = 256000.0;          % 符号速率
ml   = 2;                 % 调制阶数 
br   = sr * ml;           % 比特速率 
nd   = 100;               % 符号数
SNR=-5:1:10;              % Eb/No 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
%+++++++++++++++++++++滤波器初值设定+++++++++++++++++++++++ 
 
irfn   = 21;              % 滤波器阶数
IPOINT =  8;              % 过采样倍数
alfs   =  0.5;            % 滚降因子
[xh]   = hrollfcoef(irfn,IPOINT,sr,alfs,1);                         
[xh2]  = hrollfcoef(irfn,IPOINT,sr,alfs,0);                        
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
%++++++++++++++++++++++++扩频码初值设定+++++++++++++++++++ 
user  = 1;                % 用户数
seq   = 1;                % 1:m序列  2:Gold序列  3:正交Gold序列 
stage = 3;                % 序列阶数 
ptap1 = [1 3];            % 第一个线性移位寄存器的系数
ptap2 = [2 3];            % 第二个线性移位寄存器的系数
regi1 = [1 1 1];          % 第一个线性移位寄存器的初始化
regi2 = [1 1 1];          % 第二个线性移位寄存器的初始化
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

disp('--------------start-------------------');

%+++++++++++++++++扩频码的产生+++++++++++++++++ 
for ebn0=-5:1:10
switch seq 
case 1                                     % m序列
    code = mseq(stage,ptap1,regi1,user); 
case 2                                     % Gold序列
    m1   = mseq(stage,ptap1,regi1); 
    m2   = mseq(stage,ptap2,regi2); 
    code = goldseq(m1,m2,user); 
case 3                                     % 正交Gold序列
    m1   = mseq(stage,ptap1,regi1); 
    m2   = mseq(stage,ptap2,regi2); 
    code = [goldseq(m1,m2,user),zeros(user,1)]; 
end 
code = code * 2 - 1; 
clen = length(code); 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
%+++++++++++++++++++++信道衰减初值设定+++++++++++++++++++++++ 
rfade  = 0;                             % 瑞利衰减 0:不考虑 1:考虑
itau   = [0,8];                         % 延时 
dlvl1  = [0.0,40.0];                    % 衰减电平
n0     = [6,7];                         % 用于产生衰落的波数
th1    = [0.0,0.0];                     % 延迟波形的初始相位
itnd1  = [3001,4004];                   % 设置衰落计数
now1   = 2;                             % 主径和延迟波形总数
tstp   = 1 / sr / IPOINT / clen;        % 时间分辨率
fd     = 160;                           % 多普勒频移[Hz] 
flat   = 1;                             % 平坦瑞利衰落环境
itndel = nd * IPOINT * clen * 30;                                 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%++++++++++++++++++++++仿真运算开始++++++++++++++++++++++++ 
nloop = 1000;                           % 仿真循环次数
noe   = 0; 
nod   = 0; 
 
for ii=1:nloop 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     
%++++++++++++++++++++++++发射机++++++++++++++++++++++++++++ 
    data = rand(user,nd*ml) > 0.5; 
     
    [ich, qch]  = qpskmod(data,user,nd,ml);         % QPSK 调制
    [ich1,qch1] = spread(ich,qch,code);             % 扩频
    [ich2,qch2] = compoversamp2(ich1,qch1,IPOINT);  % 过采样
    [ich3,qch3] = compconv2(ich2,qch2,xh);          % 滤波
     
    if user == 1                                                    
        ich4 = ich3; 
        qch4 = qch3; 
    else 
        ich4 = sum(ich3); 
        qch4 = sum(qch3); 
    end 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     
%+++++++++++++++++++++++衰减信道++++++++++++++++++++++++++  
    if rfade == 0 
        ich5 = ich4; 
        qch5 = qch4; 
    else 
        [ich5,qch5] = sefade(ich4,qch4,itau,dlvl1,th1,n0,itnd1, ... 
                             now1,length(ich4),tstp,fd,flat); 
        itnd1 = itnd1 + itndel; 
    end 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     
%+++++++++++++++++++++++++接收机++++++++++++++++++++++++++++ 
    spow = sum(rot90(ich3.^2 + qch3.^2)) / nd;    % 衰减计算 
    attn = sqrt(0.5 * spow * sr / br * 10^(-ebn0/10)); 
     
    [ich6,qch6] = comb2(ich5,qch5,attn);          % 添加高斯白噪声(AWGN) 
    [ich7,qch7] = compconv2(ich6,qch6,xh2);       % 滤波
     
    sampl = irfn * IPOINT + 1; 
    ich8  = ich7(:,sampl:IPOINT:IPOINT*nd*clen+sampl-1); 
    qch8  = qch7(:,sampl:IPOINT:IPOINT*nd*clen+sampl-1); 
     
    [ich9 qch9] = despread(ich8,qch8,code);            % 解扩 
     
    demodata = qpskdemod(ich9,qch9,user,nd,ml);        % QPSK解调
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     
%++++++++++++++++++++误码率分析++++++++++++++++++++ 
 
    noe2 = sum(sum(abs(data-demodata))); 
    nod2 = user * nd * ml; 
    noe  = noe + noe2; 
    nod  = nod + nod2; 
     
%     fprintf('%d\t%e\n',ii,noe2/nod2); 
     
end 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
%+++++++++++++++++++++++++数据文件++++++++++++++++++++++++++ 
ber = noe / nod; 
fprintf('%d\t%d\t%d\t%e\n',ebn0,noe,nod,noe/nod);                  
fid = fopen('BER.dat','a'); 
fprintf(fid,'%d\t%e\t%f\t%f\t\n',ebn0,noe/nod,noe,nod);           
fclose(fid); 
err_rate_final(ebn0+6)=ber;
end
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%+++++++++++++++++++++++++性能仿真图++++++++++++++++++++++++++ 
figure
semilogy(SNR,err_rate_final,'b-*');
xlabel('信噪比/dB')
ylabel('误码率')
axis([-5,10,0,1])
grid on

disp('--------------end-------------------'); 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


