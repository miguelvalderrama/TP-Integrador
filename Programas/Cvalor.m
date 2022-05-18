n=1000;
pvl=5;
ccms=10;
ue=10;
t=[0:(3*10^-3)/22:3*10^-3]; 
for i=1:n
[us]=mediciones_us(t,pvl,ccms);  %Quitar Plots
[iL]=mediciones_iL(t,pvl,ccms);
[iR]=mediciones_iR(t,pvl,ccms);
uc=ue.-us;
ix=(uc<=abs(0.01));
uc(ix)=[];
iL(ix)=[];
iR(ix)=[];
t(ix)=[];
Il = simpsons(iL,t(),t(end),[]);
Ir = simpsons(iR,t(1),t(end),[]);
C=(Il+Ir)./uc';
Cp(i)=sum(C)/length(C);
endfor
C=sum(Cp)/length(Cp)
plot(Cp,'r*');