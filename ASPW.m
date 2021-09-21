function U = ASPW(E0, dx, z, lambda, output_range)
% This function receives a coherent monochromatic field U0 (the complex field on BFP) at wavelength lambda
% and returns the field U after distance z, utilizing the ASPW-czt propagator
% dx, dy, are spatial resolution.


[ny, nx] = size(E0); 
m=nx;
dy=dx;
Lx = dx * nx;
Ly = dy * ny;

dfx = 1./Lx;
dfy = 1./Ly;

u = ones(nx,1)*((0:nx-1)-nx/2)*dfx;    
v = ((0:ny-1)-ny/2)'*ones(1,ny)*dfy;   

O = E0;
H = exp(-1i*pi*z*lambda*(u.^2+v.^2));   %bi-directional ASPW
%H = exp(1i*2*pi*z*sqrt((1/lambda)^2-(u.^2+v.^2)));         
U = czt_2D_f(O.*H,output_range,m,dx);     % the 2D-czt interpretion of inverse fourier transform 
end

