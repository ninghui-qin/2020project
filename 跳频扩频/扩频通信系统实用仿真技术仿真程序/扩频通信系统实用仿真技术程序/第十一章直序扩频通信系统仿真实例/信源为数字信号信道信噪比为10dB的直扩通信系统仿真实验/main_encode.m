clear;

load encode_in;

xxw=504;
m=252;
n=756;

liezhong=3;
hangzhong=9;

encode;              

for i=0:755
    outx1(1,(i+1))=0.001*i;
end
outx1(2,:)=xyuan;

save encode_out outx1
