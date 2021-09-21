
function scl=scale_ml(E0,x_czt,dxf,lambda, output_range,N,z0_eng)



wML_ref= 1.45190636935492e-06;    %this is calculate by Gaussian as reference

Ef=ASPW(E0, dxf, z0_eng, lambda, output_range);
If=abs(Ef).^2;
Isec=squeeze(sum(If,2));

wML_self=find_the_width(x_czt,Isec./max(Isec),exp(1))/2;
scl=(wML_self/wML_ref);
end








 
