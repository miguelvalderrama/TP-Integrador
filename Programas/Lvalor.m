n=1000;
t=[0:((3*10^-3))/22:3*10^-3];
t1=[0.001:((3*10^-3)-0.001)/22:3*10^-3];
pvl=5;
ccms=10;
for i=1:n
[us]=mediciones_us(t,pvl,ccms);  %Quitar Plots
[iL]=mediciones_iL(t1,pvl,ccms);
ul=us;
ix=(iL<=abs(0.009));
iL(ix)=[];
ul(ix)=[];
t(ix)=[];
t1(ix)=[];
I = simpsons(ul,t(1),t(end),[]);
L=I./iL;
Lp(i)=sum(L)/length(L);
endfor
L=sum(Lp)/length(Lp)
plot(Lp,'r*');