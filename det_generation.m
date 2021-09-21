%{
% Generate the detection PSF, then give the LSFM-PSF
NA_det=0.8;
E0_det = zeros(size(Kx));
[E0_det, I0_det,I0_det_norm]=complete_field_bfp(k0, NA_det,N,'flattop',6); % give a normal flattop detection range
z_det_range=25e-6;
dz_det=2*z_det_range/num_z;
for j = 1:num_z 
  
  z_det = (j-1)*dz_det-z_det_range;   

  Ez_det(:,:,j)=ASPW(E0_det, dxf, z_det, lambda,output_range);
end

z_det_coor=((1:num_z)-1)*dz_det-z_det_range;
Iz_det=abs(Ez_det).^2;
Iz_shift=shiftdim(Iz_det,2);
PSFSumY_det = squeeze(sum(Iz_shift,2));
clear('Iz_det','Ez_det','Iz_shift');
%}
close all;






fig1 = figure('Position', [50 325 450 450]);
fig2 = figure('Position', [500 600 450 450]);
fig3 = figure('Position', [950 600 450 450]);
fig4 = figure('Position', [500 50 450 450]);
fig5 = figure('Position', [950 50 450 450]);

set(0, 'CurrentFigure', fig1);






%
%interp the PSFSumY_det from 200*1024 to 1024*1024

PSFSumY_det_q=interp1(z_det_coor,PSFSumY_det,x_czt);

%}


imagesc([x_czt(1) x_czt(end)],[z_det_coor(1), z_det_coor(end)],PSFSumY_det_q);

axis square;
colormap(gray);
set(gca,'Ydir','normal')
xlabel('x [m]');
ylabel('z [m]');
title('PSFSum-det');

set(gca,'FontSize',14) 






set(0, 'CurrentFigure', fig2);
% create the light sheet slice in y=0, & y=zR positions, then multiply is
% with our detion PSF

% 1)For y=0, zR, extract the intensity information, the details shohld be
% the PSFSUMY's value at y=0, and y= z_R, then I get 2 arrays(curves), 
PSFill_val_0=squeeze(PSFSumY(:,loc0_eng));


%  then expend it to a constant slice 

%initialzie the constant illumination light-sheet slice  
%{
%this is for generating a 200*1024*1024 3D array
xi_q=linspace(-25e-6,25e-6,num_z);
PSFill_val_0_q=interp1(x_czt,PSFill_val_0,xi_q);
%}
PSFill_val_0_xz_q=repmat(PSFill_val_0,[1,1024]);
%{


% PSFill_val_0_xz=repmat(PSFill_val_0_q,[1024,1]);    _q means from 1024*1024 to 200 *1024,fit for the 3D operation




PSFill_val_0_xz=PSFill_val_0_xz';
for i= 1: N
            LSill_0(:,:,i)=PSFill_val_0_xz;             %generate the illumination L-S of y=0;
end
%}

%PSFSumLSill_0=squeeze(sum(LSill_0,3));


%imagesc([x_czt(1) x_czt(end)],[z_det_coor(1), z_det_coor(end)],PSFSumLSill_0); 
imagesc([x_czt(1) x_czt(end)],[z_det_coor(1), z_det_coor(end)],PSFill_val_0_xz_q); 
axis square;
colormap(gray);
set(gca,'Ydir','normal')
xlabel('x [m]');
ylabel('z [m]');
title('IPSF\_LS y = 0');

set(gca,'FontSize',14) 


set(0, 'CurrentFigure', fig3);


%  y= z_R, 

PSFill_val_zR=squeeze(PSFSumY(:,loc_eng(1)));

%  then expend it to a constant slice 


PSFill_val_zR_xz_q=repmat(PSFill_val_zR,[1,1024]);
%{


% PSFill_val_0_xz=repmat(PSFill_val_0_q,[1024,1]);    _q means from 1024*1024 to 200 *1024,fit for the 3D operation




PSFill_val_0_xz=PSFill_val_0_xz';
for i= 1: N
            LSill_0(:,:,i)=PSFill_val_0_xz;             %generate the illumination L-S of y=0;
end
%}

%PSFSumLSill_0=squeeze(sum(LSill_0,3));


%imagesc([x_czt(1) x_czt(end)],[z_det_coor(1), z_det_coor(end)],PSFSumLSill_0); 
imagesc([x_czt(1) x_czt(end)],[z_det_coor(1), z_det_coor(end)],PSFill_val_zR_xz_q); 
axis square;
colormap(gray);
set(gca,'Ydir','normal')
xlabel('x [m]');
ylabel('z [m]');
title(['IPSF\_LS  y = ',char(vpa(abs(z_coor(loc_eng(1))-z_coor(loc0_eng))*1e6,3)),'\mum']);
set(gca,'FontSize',14) 
set(0, 'CurrentFigure', fig4);



% multiply Iz_det with constant LS of y=0 and y=zR




%PSF_LSFM =Iz_shift.* LSill_0;
%PSFSumY_LSFM=squeeze(sum(PSF_LSFM,2));
%PSF_LSFM_max=max(max(max(PSF_LSFM)));
%{
figure();
temp=squeeze(PSF_LSFM(100,:,:)/PSF_LSFM_max);
imagesc([x_czt(1) x_czt(end)],[x_czt(1) x_czt(end)],temp);
axis square;
%caxis([0 1]);
colorbar;


colormap(gray);
set(gca,'Ydir','normal')
xlabel('y [m]');
ylabel('x [m]');
title('PSF-LSFM  z=0');

figure();
temp=squeeze(PSF_LSFM(150,:,:)/PSF_LSFM_max);
imagesc([x_czt(1) x_czt(end)],[x_czt(1) x_czt(end)],temp);
axis square;
%caxis([0 1]);
colorbar;
colormap(gray);
set(gca,'Ydir','normal')
xlabel('y [m]');
ylabel('x [m]');
title('PSF-LSFM z=',(150-100)*dz_det);

figure();
temp=squeeze(PSF_LSFM(200,:,:)/PSF_LSFM_max);
imagesc([x_czt(1) x_czt(end)],[x_czt(1) x_czt(end)],temp);
%caxis([0 1]);
colormap(gray);
set(gca,'Ydir','normal')
xlabel('y [m]');
ylabel('x [m]');
title('PSF-LSFM  z=',(200-100)*dz_det);
axis square;
colorbar;
%}


%PSFSumY_LSFM=PSFSumLSill_0.*PSFSumY_det_q;

PSFSumY_LSFM_q_0=PSFSumY_det_q.*PSFill_val_0_xz_q;

imagesc([x_czt(1) x_czt(end)],[z_det_coor(1), z_det_coor(end)],PSFSumY_LSFM_q_0);


%axis([z_coor_q(location_y)-25e-6,z_coor_q(location_y)+25e-6, -25e-6 ,25e-6]);
axis square;
colormap(gray);
set(gca,'Ydir','normal')
xlabel('x [m]');
ylabel('z [m]');
title('IPSF\_LSFM  y = 0');

set(gca,'FontSize',14) 
set(0, 'CurrentFigure', fig5);



% multiply Iz_det with constant LS of y=0 and y=zR


%PSFSumY_LSFM=PSFSumLSill_0.*PSFSumY_det_q;

PSFSumY_LSFM_q_zR=PSFSumY_det_q.*PSFill_val_zR_xz_q;

imagesc([x_czt(1) x_czt(end)],[z_det_coor(1), z_det_coor(end)],PSFSumY_LSFM_q_zR);


%axis([z_coor_q(location_y)-25e-6,z_coor_q(location_y)+25e-6, -25e-6 ,25e-6]);
axis square;
colormap(gray);
set(gca,'Ydir','normal')
xlabel('x [m]');
ylabel('z [m]');
title(['IPSF\_LSFM  y = ',char(vpa(abs(z_coor(loc_eng(1))-z_coor(loc0_eng))*1e6,3)),'\mum']);

set(gca,'FontSize',14) 


