

% Initial Setup
lambda=550*10^(-9);        % define the wavelength of illumination(excitation) light  /m;
k0=2*pi/lambda;            % define the wave vector in vaccum;
N=1024;                    % define the sampling point;
%%%%%   it is very important of thinking how to select a correct NA       
NA_ill=0.3;
num_z=200;
field=struct;
% define the numerical aperture of illumination; NA_ill=(x_range/2)/efl, NA start
f=20e-2;                   % define the illumination objective lens's focal length /m;
%Scale parameter
%w0=k0*NA_ill;              % define the width parameter in k_space, w_k=k0*NA, corresponding to the real space of lambda/NA.
general_range=50E-6/2;          %50 um
% Define coordinate system           
% mask functions are written in k-space
nPixel = (-N/2:(N/2-1));   % define the N*N sampling pixel coordinate; 

k_range=6*k0*NA_ill;    % k_range is important should be larger then 4w0 
w0=NA_ill*k0;


dk=k_range/N;
xf_range=2*pi/dk;
dxf=xf_range/N;            % dxf=lambda/NA/10
xf=nPixel.*dxf;  
yf=xf;

kx=nPixel.*dk;
ky=kx;           
% Meshgrid the real sp  ace and the Fourier space, useful for particular function output.      
[Kx,Ky]=meshgrid(kx,ky);
[Xf,Yf]=meshgrid(xf,yf);  
Kr=sqrt(Kx.^2+Ky.^2);



%czt modify the xf,xy coordinate
m=N;
output_range=general_range;
f1=-output_range;                % define the transform axis_range 
f2=output_range;
dx_czt=(f2-f1)/m;          % define the resolution in x_czt coordinate
mPixel = (-m/2+1:(m/2));   % define the m*m sampling pixel coordinate; 
x_czt=mPixel.*dx_czt;      % calculate the czt_axis
z0_eng=0;
