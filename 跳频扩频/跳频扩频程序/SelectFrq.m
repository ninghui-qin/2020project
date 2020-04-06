%---------根据m序列的8位状态，选择频率---------------
function Frq=SelectFrq(Code)
Frq=64*Code(7)+32*Code(6)+16*Code(5)+8*Code(4)+4*Code(3)+2*Code(2)+Code(1);
Frq=Frq*10+1000;