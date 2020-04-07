%控制频率合成器产生频率变化的载波
clear all; 
clc; 
%---------初始化---------------
MAXCLOCK=49;m=90;
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