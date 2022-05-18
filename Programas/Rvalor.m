n=1000;
t=[0:(3*10^-3)/21:3*10^-3];
pvl=5;
ccms=10;
A=ones(22,1);
for i=1:n
[us]=mediciones_us(t,pvl,ccms);  %Quitar Plots
[iR]=mediciones_iR(t,pvl,ccms);
ix=(iR<=0.01);
iR(ix)=[];
us(ix)=[];
t(ix)=[];
A= us./iR;
R(i)=sum(A)/length(A);
endfor
Rp=sum(R)/length(R)
plot(R,'r*');