function [E0, I0,I0_norm]=complete_field_bfp(k0, NA_ill,N,beam_mode,scl,apod)

if nargin==5
  %xo=x(val2ind(y,max(y)));
  apod = 0;
end

%Scale parameter
w0=k0*NA_ill;              % define the width parameter in k_space, w_k=k0*NA, corresponding to the real space of lambda/NA.
w=scl*w0;

% Define coordinate system           
% mask functions are written in k-space

nPixel = (-N/2:(N/2-1));   % define the N*N sampling pixel coordinate; 

% k_range may be important
k_range=6*w0;



dk=k_range/N;
xf_range=2*pi/dk;

dxf=xf_range/N;            % dxf=lambda/NA/10
xf=nPixel.*dxf;  
yf=xf;

kx=nPixel.*dk;
ky=kx;           


% Meshgrid the real space and the Fourier space, useful for particular function output.      
[Kx,Ky]=meshgrid(kx,ky);
[Xf,Yf]=meshgrid(xf,yf);  

Kr=sqrt(Kx.^2+Ky.^2);

Disc=@(rad) 1/2*(1+tanh(1.5/(sqrt(2)*dk)*(rad-Kr)));                         % define a smooth aperture disk

E0 = zeros(size(Kx));
A=zeros(size(Kx));
switch beam_mode

% Mask Function for projection 
% Consider mask in bfl (x,y), project through an object lens and the image in focal plane (u,v)
%a) One parameter beam: 



    case 'Gaussian' 
         %z_range=300e-6;
         w=w/6;
E0=exp(-(Kr/w).^2);   


    case 'flattop'
         %z_range=350e-6;  

w=w/6;
E0=Disc(w);
%E0(Kr < w) = 1;


    case 'Bessel'   
         %z_range=40e-6;  
%E0=abs(abs(Kr-w0)<=dk);
w=w/2;
eps=0.55;

Kc=w*(1+sqrt(eps))/2;
Kt=w*( 1-sqrt(eps))/2;

E0 = exp( -((Kr-Kc)/Kt).^2);

case 'lattice'
        

w=w/2;
gP=80*scl;
eps=0.55;

Kc=w*(1+sqrt(eps))/2;
Kt=w*( 1-sqrt(eps))/2;
E0 = exp( -((Kr-Kc)/Kt).^2);
        
grid = floor((mod(round(Kx/dk)-1,(gP))+1)/(gP));
%E0=1;
E0 = E0.* grid;



%a) Two parameter beam: 
    case 'DG'
       %z_range=60e-6;  
% the second parameter of the interval of the double Gaussian.
          w=w/6;    
w_int=w*3;
E0=exp(-(Kx.^2+(Ky-w_int).^2)/(w^2))+exp(-(Kx.^2+(Ky+w_int).^2)/(w^2));  % on y_axis
%E0=exp(-(Y.^2+(X-w_int).^2)/(w^2))+exp(-(Y.^2+(X+w_int).^2)/(w^2));  % on x_axis
    case 'Airy'
        %z_range=50e-6;  
        w=w/2;
a_airy=6;
E0=exp(1i.*a_airy.*((Kx./w).^3+(Ky./w).^3)).*Disc(w);

    case 'Airyrotate'
        %z_range=50e-6; 
a_airy=6;
w=w/2;
 rot_angle = pi/4;
 Kx_r = Kx * cos(rot_angle) - Ky * sin(rot_angle);
 Ky_r = Kx * sin(rot_angle) + Ky * cos(rot_angle);
E0=exp(1i.*a_airy.*((Kx_r./w).^3+(Ky_r./w).^3)).*Disc(w);

    
    case 'SA'
        %z_range=70e-6;
        w=w/2;
        SA_phase_amp=6;
        E0 = exp(1i * SA_phase_amp * (Kr/w).^4).*Disc(w);
  
end



if apod == 0
    A=1;
else
    A=Disc(w0);
    %A(Kr < w0) = 1;
end

E0=A.*E0;
% Fresnel calculation
I0=abs(E0).^2;
I0_norm=I0./max(max(I0));   % normalize the initial Intensity at bfl



