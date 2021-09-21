

close all;

%run('initial_setup.m')    % NA_ill= 0.3 
% create figures and set their position




    


% Input parameter
    
z_range=100e-6;   % define the z range, from -z_range to z_range

%Prepare the input mask
%{  
%This only suit for when the waist is at y=0 position. 
[E0, I0,I0_norm]=complete_field_bfp(k0, NA_ill,N,'',1,0);



% after generate the L-S select this 
scl=scale(E0,x_czt,dxf,lambda, output_range,N,z0_eng);
[E0, I0,I0_norm]=complete_field_bfp(k0, NA_ill,N,'Gaussian',scl,1);

%}







% Fresnel calculation
absE0=abs(E0);
absE0_norm=absE0./max(max(absE0));  %  normalize the initial field at bfl
I0=abs(E0).^2;
I0_norm=I0./max(max(I0));   % normalize the initial Intensity at bfl

output_range=general_range;
m=N;




% czt parameter
f1=-output_range;                % define the transform axis_range 
f2=output_range;
df=1/(m*dxf);


dx_czt=(f2-f1)/m;          % define the resolution in x_czt coordinate
mPixel = (-m/2+1:(m/2));   % define the m*m sampling pixel coordinate; 
x_czt=mPixel.*dx_czt;      % calculate the czt_axis










  
  
  
  
  

% Plot the outcome 
subplot(121)

imagesc([kx(1) kx(end)], [ky(1) ky(end)], I0_norm);   %I0_norm-min(min(I0_norm))   

set(gca,'YDir','normal');
axis square;

%axis([-1 1,-1 1].*w0/6);    %k_range/10 = w0
axis([-1 1,-1 1].*w0);    %k_range/10 = w0
%axis tight;% axis equal;
colormap(gray);
%colorbar;
title('Intensity ','FontWeight','bold','FontSize',14);
xlabel('kx (m^{-1})');
ylabel('ky (m^{-1})');
set(gca,'FontSize',12);

subplot(122)

imagesc([kx(1) kx(end)], [ky(1) ky(end)], angle(E0));   %I0_norm-min(min(I0_norm))   
set(gca,'YDir','normal');
set(gca,'FontSize',12);
axis square;
axis([-1 1,-1 1].*w0);
%axis tight; %axis equal;
colormap(gray);
%colorbar;
title('Phase','FontWeight','bold','FontSize',14);
xlabel('kx (m^{-1})');
ylabel('ky (m^{-1})');

% Propagation parameter
num_z=200;        % define the number of sampling points in z axis

dz =2*z_range/num_z;      % z distance between planes in metres
%Ez=zeros([size(E0), num_z]);



%

for j = 1:num_z 
    
    
  z = (j-1)*dz-z_range;   

  Ez(:,:,j)=ASPW(E0, dxf, z, lambda,output_range);


end

%}



%save('Gaussian_len50_Ez.mat','Ez');



