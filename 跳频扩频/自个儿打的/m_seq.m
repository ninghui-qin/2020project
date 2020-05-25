function mseq=m_seq(prim_poly);
fbconnection=de2bi(oct2dec(prim_poly));
fbconnection=fbconnection(end-1:-1:1);
n=length(fbconnection);
N=2^n-1;
register=ones(1,n);
mseq=zeros(1,N);
mseq(1)=register(n);
for i=2:N
    newregister(1)=mod(sum(fbconnection.*register),2);
    for j=2:n
        newregister(j)=register(j-1);
    end
    register=newregister;
    mseq(i)=register(n);
end