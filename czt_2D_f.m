function [Eczt,Iczt_norm,x_czt,dx_czt]=czt_2D_f(E0,output_range,m,dxf)   % ifft , from f-space to x-space


f1=-output_range;                % define the transform axis_range 
f2=output_range;
df=1/(m*dxf);

fs_k=1/(df);          % dk: resolution in k_space
wy=exp(-1i*2*pi*(f2-f1)/(fs_k*m));
ay=exp(1i*2*pi*f1/fs_k);
tmp=czt(E0.',m,wy,ay);            %first czt the matrix along the y_axis
Exf=(tmp).';                      %transpose back the matrix 

wx=exp(-1i*2*pi*(f2-f1)/(fs_k*m));
ax=exp(1i*2*pi*f1/fs_k);
Eczt=czt(Exf,m,wx,ax);             %then czt the matrix along the x_axis


If_czt=abs(Eczt).^2;
Iczt_norm=If_czt./max(max(If_czt));   % calculate normalized intensity


dx_czt=(f2-f1)/m;          % define the resolution in x_czt coordinate
mPixel = (-m/2+1:(m/2));   % define the m*m sampling pixel coordinate; 
x_czt=mPixel.*dx_czt;      % calculate the czt_axis





