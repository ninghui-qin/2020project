% main_DSCDMA.m
% ��������������ʵ��DS-CDMAͨ��ϵͳ���� 
% 
% 

 
%+++++++++++++++++++++++׼������+++++++++++++++++++++++++++ 

clear all;
clc 

sr   = 256000.0;          % ��������
ml   = 2;                 % ���ƽ��� 
br   = sr * ml;           % �������� 
nd   = 100;               % ������
SNR=-5:1:10;              % Eb/No 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
%+++++++++++++++++++++�˲�����ֵ�趨+++++++++++++++++++++++ 
 
irfn   = 21;              % �˲�������
IPOINT =  8;              % ����������
alfs   =  0.5;            % ��������
[xh]   = hrollfcoef(irfn,IPOINT,sr,alfs,1);                         
[xh2]  = hrollfcoef(irfn,IPOINT,sr,alfs,0);                        
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
%++++++++++++++++++++++++��Ƶ���ֵ�趨+++++++++++++++++++ 
user  = 1;                % �û���
seq   = 1;                % 1:m����  2:Gold����  3:����Gold���� 
stage = 3;                % ���н��� 
ptap1 = [1 3];            % ��һ��������λ�Ĵ�����ϵ��
ptap2 = [2 3];            % �ڶ���������λ�Ĵ�����ϵ��
regi1 = [1 1 1];          % ��һ��������λ�Ĵ����ĳ�ʼ��
regi2 = [1 1 1];          % �ڶ���������λ�Ĵ����ĳ�ʼ��
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

disp('--------------start-------------------');

%+++++++++++++++++��Ƶ��Ĳ���+++++++++++++++++ 
for ebn0=-5:1:10
switch seq 
case 1                                     % m����
    code = mseq(stage,ptap1,regi1,user); 
case 2                                     % Gold����
    m1   = mseq(stage,ptap1,regi1); 
    m2   = mseq(stage,ptap2,regi2); 
    code = goldseq(m1,m2,user); 
case 3                                     % ����Gold����
    m1   = mseq(stage,ptap1,regi1); 
    m2   = mseq(stage,ptap2,regi2); 
    code = [goldseq(m1,m2,user),zeros(user,1)]; 
end 
code = code * 2 - 1; 
clen = length(code); 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
%+++++++++++++++++++++�ŵ�˥����ֵ�趨+++++++++++++++++++++++ 
rfade  = 0;                             % ����˥�� 0:������ 1:����
itau   = [0,8];                         % ��ʱ 
dlvl1  = [0.0,40.0];                    % ˥����ƽ
n0     = [6,7];                         % ���ڲ���˥��Ĳ���
th1    = [0.0,0.0];                     % �ӳٲ��εĳ�ʼ��λ
itnd1  = [3001,4004];                   % ����˥�����
now1   = 2;                             % �������ӳٲ�������
tstp   = 1 / sr / IPOINT / clen;        % ʱ��ֱ���
fd     = 160;                           % ������Ƶ��[Hz] 
flat   = 1;                             % ƽ̹����˥�价��
itndel = nd * IPOINT * clen * 30;                                 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%++++++++++++++++++++++�������㿪ʼ++++++++++++++++++++++++ 
nloop = 1000;                           % ����ѭ������
noe   = 0; 
nod   = 0; 
 
for ii=1:nloop 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     
%++++++++++++++++++++++++�����++++++++++++++++++++++++++++ 
    data = rand(user,nd*ml) > 0.5; 
     
    [ich, qch]  = qpskmod(data,user,nd,ml);         % QPSK ����
    [ich1,qch1] = spread(ich,qch,code);             % ��Ƶ
    [ich2,qch2] = compoversamp2(ich1,qch1,IPOINT);  % ������
    [ich3,qch3] = compconv2(ich2,qch2,xh);          % �˲�
     
    if user == 1                                                    
        ich4 = ich3; 
        qch4 = qch3; 
    else 
        ich4 = sum(ich3); 
        qch4 = sum(qch3); 
    end 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     
%+++++++++++++++++++++++˥���ŵ�++++++++++++++++++++++++++  
    if rfade == 0 
        ich5 = ich4; 
        qch5 = qch4; 
    else 
        [ich5,qch5] = sefade(ich4,qch4,itau,dlvl1,th1,n0,itnd1, ... 
                             now1,length(ich4),tstp,fd,flat); 
        itnd1 = itnd1 + itndel; 
    end 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     
%+++++++++++++++++++++++++���ջ�++++++++++++++++++++++++++++ 
    spow = sum(rot90(ich3.^2 + qch3.^2)) / nd;    % ˥������ 
    attn = sqrt(0.5 * spow * sr / br * 10^(-ebn0/10)); 
     
    [ich6,qch6] = comb2(ich5,qch5,attn);          % ��Ӹ�˹������(AWGN) 
    [ich7,qch7] = compconv2(ich6,qch6,xh2);       % �˲�
     
    sampl = irfn * IPOINT + 1; 
    ich8  = ich7(:,sampl:IPOINT:IPOINT*nd*clen+sampl-1); 
    qch8  = qch7(:,sampl:IPOINT:IPOINT*nd*clen+sampl-1); 
     
    [ich9 qch9] = despread(ich8,qch8,code);            % ���� 
     
    demodata = qpskdemod(ich9,qch9,user,nd,ml);        % QPSK���
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     
%++++++++++++++++++++�����ʷ���++++++++++++++++++++ 
 
    noe2 = sum(sum(abs(data-demodata))); 
    nod2 = user * nd * ml; 
    noe  = noe + noe2; 
    nod  = nod + nod2; 
     
%     fprintf('%d\t%e\n',ii,noe2/nod2); 
     
end 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
%+++++++++++++++++++++++++�����ļ�++++++++++++++++++++++++++ 
ber = noe / nod; 
fprintf('%d\t%d\t%d\t%e\n',ebn0,noe,nod,noe/nod);                  
fid = fopen('BER.dat','a'); 
fprintf(fid,'%d\t%e\t%f\t%f\t\n',ebn0,noe/nod,noe,nod);           
fclose(fid); 
err_rate_final(ebn0+6)=ber;
end
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%+++++++++++++++++++++++++���ܷ���ͼ++++++++++++++++++++++++++ 
figure
semilogy(SNR,err_rate_final,'b-*');
xlabel('�����/dB')
ylabel('������')
axis([-5,10,0,1])
grid on

disp('--------------end-------------------'); 
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


