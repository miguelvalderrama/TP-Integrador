t=[0:(3*10^-3)/59:3*10^-3];
pvl=5;
ccms=10;

[us]=mediciones_us(t,pvl,ccms);  %Quitar Plots
[iR]=mediciones_iR(t,pvl,ccms);
[iL]=mediciones_iL(t,pvl,ccms);