%����Ƶ�ʺϳ�������Ƶ�ʱ仯���ز�
clear all; 
clc; 
%---------��ʼ��---------------
MAXCLOCK=49;m=90;
PNSeq=mseq(1);
PNSeqNum=1; %�ڼ���ѡ��Ƶ��
SaveFrq=[];
CLOCK=0;
while CLOCK < MAXCLOCK
CLOCK=CLOCK+1;
%---------ѡ��Ƶ��---------------
if PNSeqNum>(m-6)
    PNSeqNum=1;
end
MixFrq=SelectFrq(PNSeq(PNSeqNum:PNSeqNum+6));
PNSeqNum=PNSeqNum+1;
SaveFrq=[SaveFrq MixFrq];
end