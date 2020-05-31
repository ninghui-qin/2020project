clear;
load encode_in.mat;
m=252;
n=756;
s=round(rand(1,504));
encode;              
for i=0:755
    encode_out(1,(i+1))=0.001*i;
end
for i=0:755
    if xyuan(1,(i+1))>0.5
        encode_out(2,(i+1))=-1;
    else encode_out(2,(i+1))=1;
    end
end
save encode_out encode_out
