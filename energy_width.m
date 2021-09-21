function w_os = energy_width(Prof,x_czt,N)

sum_En_0 = trapz(x_czt,Prof);

cj=N/2+1;
j=0;
En_c_0 = 0;

while En_c_0 <= sum_En_0*(1-exp(-1))
     j=j+1;
    Ej=cj-j:cj+j;
    En_c_0 = trapz(x_czt(Ej),Prof(Ej));
    
end

dx_czt=4.8828125e-08;
j=j-1;
Ej=cj-j:cj+j;
w_os=(x_czt(Ej(end))-x_czt(Ej(1)));
