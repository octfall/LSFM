
function scl=scale(E0,x_czt,dxf,lambda, output_range,N,z0_eng)



w0S_Ref= 1.26953125e-06  ;    %this is calculate reference Gaussian with w=w0/6;

Ef=ASPW(E0, dxf, z0_eng, lambda, output_range);
If=abs(Ef).^2;
Isec=squeeze(sum(If,2));
wOS_self=energy_width(Isec,x_czt,N)/2;
scl=(wOS_self/w0S_Ref);
end








 
