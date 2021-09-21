close all;

% This main file define the PSFsliceYZ (cut), PSfsum (section) and the
% PSFXY, than illustrate them.
axis_plot= 5e-6;

fig1 = figure('Position', [225 50 250 500]);
%fig2 = figure('Position', [250 50 250 250]);
fig3 = figure('Position', [475 50 700 350]);
fig4 = figure('Position', [1200 50 700 350]);
%{
Ez=Gaussian.Ez;
z_range=Gaussian.z_range;
dz =2*z_range/num_z;      % z distance between planes in metres


%This only suit for when the waist is at y=0 position. 
[E0, I0,I0_norm]=complete_field_bfp(k0, NA_ill,N,'Gaussian',1,1);



% after generate the L-S select this 
scl=scale_ml(E0,x_czt,dxf,lambda, output_range,N,z0_eng);
[E0, I0,I0_norm]=complete_field_bfp(k0, NA_ill,N,'Airyrotate',scl,1);

%}






% input parameter:
axis_index = 1;           % 0 for small size PSF, 1 for large size PSF 
z_coor=((1:num_z)-1)*dz-z_range;

%z_coor=z_coor-z_coor(loc0);


% Plot the intensity and phase on bfp
set(0, 'CurrentFigure', fig1);
subplot(211)
imagesc([kx(1) kx(end)], [ky(1) ky(end)], I0_norm);   %I0_norm-min(min(I0_norm))   

set(gca,'FontSize',9.5);

set(gca,'YDir','normal');
axis square;
%axis tight; axis equal;

axis([-1 1,-1 1].*w0);
colormap(gray);

%title('Intensity on BFP','FontWeight','bold','FontSize',11);
%xlabel('kx (m^{-1})','FontWeight','bold','FontSize',9.7);
%ylabel('ky (m^{-1})','FontWeight','bold','FontSize',9.7);


subplot(212)
imagesc([kx(1) kx(end)], [ky(1) ky(end)], angle(E0));   %I0_norm-min(min(I0_norm))   
set(gca,'YDir','normal');
set(gca,'FontSize',9.5);

%axis tight; axis equal;
axis square;
axis([-1 1,-1 1].*w0);
colormap(gray);

%title('Phase on BFP','FontWeight','bold','FontSize',11);
%xlabel('kx (m^{-1})','FontWeight','bold','FontSize',9.7);
%ylabel('ky (m^{-1})','FontWeight','bold','FontSize',9.7);

Iz=abs(Ez).^2;
%Iz_norm=Iz./max(max(max(Iz)));
Iz_norm=Iz;
%%%%%%very  important
cx=N/2+1;
cy=cx;
az=z_coor;

centerline_z = squeeze(Iz_norm(cx,cy,:));
[maxIntZ, pos_maxIntZ] = max(centerline_z);

sliXY_0 = squeeze(Iz_norm(:,:,pos_maxIntZ));

%sliXZ = squeeze(Iz_norm(:,cy,:));
sliYZ = squeeze(Iz_norm(cx,:,:));

%PSFSumY=abs(squeeze(sum(Ez,2))).^2;

PSFSumY = squeeze(sum(Iz_norm,2)); % sumY is the view in the plane of y-z plane, sum along the x-coor,only fit for incoherent light


set(0, 'CurrentFigure', fig3);
subplot(211);

imagesc([az(1), az(end)],[x_czt(1) x_czt(end)],interp2(sliYZ,2));
if axis_index==0
    axis([0, az(end), -axis_plot ,axis_plot]);
end 
if axis_index==1
    axis tight; 
end

colormap(gray);
set(gca,'Ydir','normal')
set(gca,'FontSize',9.5);
colorbar('Position', [0.920952374314193 0.614285716883013 0.02 0.291428571055104],'LineWidth',1,'FontWeight','bold','FontName','Arial','FontSize',9.7);
xlabel('y [m]','FontWeight','bold','FontSize',9.7);
ylabel('z [m]','FontWeight','bold','FontSize',9.7);
title('YZcut ','FontWeight','bold','FontSize',11);


subplot(212);

imagesc([az(1), az(end)],[x_czt(1) x_czt(end)],interp2(PSFSumY,2));
if axis_index==0
    axis([0, az(end), -axis_plot ,axis_plot]);
end 
if axis_index==1
    axis tight;
end

colormap(gray);
set(gca,'Ydir','normal')
set(gca,'FontSize',9.5);

xlabel('y [m]','FontWeight','bold','FontSize',9.7);
ylabel('z [m]','FontWeight','bold','FontSize',9.7);
title('YZsection','FontWeight','bold','FontSize',11);

colorbar('Position',[0.919523802885621 0.142857145454442 0.02 0.291428571055104],'LineWidth',1,'FontWeight','bold','FontName','Arial','FontSize',9.7);

%plot and find the width
w_find_sli=zeros(1,num_z);
w_find_sec_x=w_find_sli;

w_find_eng=w_find_sli;

for j= 1:num_z
    

[w_find_sli(j),~,~,xo_y_sli,x1_y_sli,x2_y_sli]=find_the_width(x_czt,sliYZ(:,j)./max(sliYZ(:,j)),exp(1));
w_find_sli(j)=w_find_sli(j)/2;
[w_find_sec_x(j),~,~,xo_x_sec,x1_x_sec,x2_x_sec]=find_the_width(x_czt,PSFSumY(:,j)./max(PSFSumY(:,j)),exp(1));
w_find_sec_x(j)=w_find_sec_x(j)/2;

w_find_eng(j)=energy_width(PSFSumY(:,j),x_czt,N);
%w_find_eng(j)=osWidth_gui(PSFSumY(:,j), N,dx_czt);
w_find_eng(j)=w_find_eng(j)/2;

end
% define the waist position and index
%{
%This is only find for the SA - the shifted beam type but not for other type of beams
[w0_sli,loc0_sli]=min(w_find_sli);
[w0_sec,loc0_sec]=min(w_find_sec_x);
[w0_eng,loc0_eng]=min(w_find_eng);
%}
%
%for normal beams which have the waist at z=0

cz=num_z/2+1;

w0_sli=w_find_sli(cz);
w0_sec=w_find_sec_x(cz);
w0_eng=w_find_eng(cz);
loc0_sli=cz;
loc0_sec=cz;
loc0_eng=cz;

%}  

 
    


wR_sli=sqrt(2)*w0_sli;
wR_sec=sqrt(2)*w0_sec;
wR_eng=sqrt(2)*w0_eng;

% define the zR position and index
%%% for slice 
w_abs_sli=abs(w_find_sli-wR_sec);
w_sort_sli=sort(w_abs_sli);
[~,loc_sli]=find(w_abs_sli<=w_sort_sli(2));
z_find_sli=(loc_sli-1)*dz-z_range;

%%% for section 
w_abs_sec=abs(w_find_sec_x-wR_sec);
w_sort_sec=sort(w_abs_sec);
[~,loc_sec]=find(w_abs_sec<=w_sort_sec(3));
z_find_sec=(loc_sec-1)*dz-z_range;


%%% for OS
w_abs_eng=abs(w_find_eng-wR_eng);
w_sort_eng=sort(w_abs_eng);
[~,loc_eng]=find(w_abs_eng<=w_sort_eng(2));
z_find_eng=(loc_eng-1)*dz-z_range;


%plot the Xz slice  


figure('Position', [475 500 700 250]);
subplot(1,3,2)

   z_pos=loc0_eng;


zcal=((z_pos-1)*dz-z_range)*1e6;
sliXY = squeeze(Iz(:,:,z_pos));
%imagesc([x_czt(1) x_czt(end)],[x_czt(1) x_czt(end)],log(sliXY));
imagesc([x_czt(1) x_czt(end)],[x_czt(1) x_czt(end)],sliXY);
axis([-10e-6 ,10e-6, -10e-6 ,10e-6]);
axis square;
colormap(gray);
set(gca,'Ydir','normal')
xlabel('x [m]','FontWeight','bold','FontSize',9.7);
ylabel('z [m]','FontWeight','bold','FontSize',9.7);
title('Slice at y =', [ num2str(zcal), ' μm'],'FontWeight','bold','FontSize',11);
set(gca,'FontSize',9.5);
temp1=caxis;

colorbar('Position',...
    [0.931428571428571 0.195 0.02 0.655],'LineWidth',1,'FontWeight','bold','FontName','Arial','FontSize',9.7);
subplot(1,3,1)

 z_pos = loc_eng(1);

zcal=((z_pos-1)*dz-z_range)*1e6;
sliXY = squeeze(Iz(:,:,z_pos));
%imagesc([x_czt(1) x_czt(end)],[x_czt(1) x_czt(end)],log(sliXY));
imagesc([x_czt(1) x_czt(end)],[x_czt(1) x_czt(end)],sliXY);
axis([-10e-6 ,10e-6, -10e-6 ,10e-6]);
axis square;
colormap(gray);
set(gca,'Ydir','normal')
xlabel('x [m]','FontWeight','bold','FontSize',9.7);
ylabel('z [m]','FontWeight','bold','FontSize',9.7);
title('Slice at y =', [ num2str(zcal), ' μm'],'FontWeight','bold','FontSize',11);
set(gca,'FontSize',9.5);
caxis(temp1);



subplot(1,3,3)


  z_pos= loc_eng(end);


zcal=((z_pos-1)*dz-z_range)*1e6;
sliXY = squeeze(Iz(:,:,z_pos));
%imagesc([x_czt(1) x_czt(end)],[x_czt(1) x_czt(end)],log(sliXY));
imagesc([x_czt(1) x_czt(end)],[x_czt(1) x_czt(end)],sliXY);
axis([-10e-6 ,10e-6, -10e-6 ,10e-6]);
axis square;
colormap(gray);

caxis(temp1);
set(gca,'Ydir','normal')
xlabel('x [m]','FontWeight','bold','FontSize',9.7);
ylabel('z [m]','FontWeight','bold','FontSize',9.7);
title('Slice at y =', [ num2str(zcal), ' μm'],'FontWeight','bold','FontSize',11);
set(gca,'FontSize',9.5);

caxis(temp1);



%plot the slice, section, OS  

set(0, 'CurrentFigure', fig4);
%{
subplot(311)

plot(z_coor, w_find_sli,'r', [-num_z*dz/2, num_z*dz/2], [wR_sli, wR_sli], '--k');

axis([z_coor(1), z_coor(end), 0, 2*wR_sec]);
xlabel('y [m]');
ylabel('profile [m]');
%title('hwhm  along z find for YZ slice');
title('hw 1/e of maximum  along y find for YZ slice');
%text(z_find_sli,w_find_sli(loc_sli)/2,["zR\_sli =",char(vpa(z_find_sli,3))]);
text(0,w_find_sli(loc0_sli)/2,["w0\_sli =",char(vpa(w0_sli,3))]);
%}

subplot(211)

plot(z_coor, w_find_sec_x,'r', [-num_z*dz/2, num_z*dz/2], [wR_sec, wR_sec], '--k',[z_find_sec(1),z_find_sec(1)],[0,  2*wR_sec],'-m',[z_find_sec(end),z_find_sec(end)],[0,  2*wR_sec],'-m');
axis([z_coor(1), z_coor(end), 0, 2*wR_sec]);
xlabel('y [m]','FontWeight','bold','FontSize',9.7);
ylabel('w\_{ML} [m]','FontWeight','bold','FontSize',9.7);
%title('hwhm along z find for YZ section');
title('Main lobe thickness - YZsection','FontWeight','bold','FontSize',11);
%text(z_find_sec,w_find_sec_x(loc_sec)/2,["zR\_sec =",char(vpa(z_find_sec,3))]);
text(0,w_find_sec_x(loc0_sec)/2,["w0\_{ML} =",char(vpa(w0_sec,3))]);
set(gca,'FontSize',9.5);

%%%% Energy width
subplot(212)
z0_eng=(loc0_eng-1)*dz-z_range;
plot(z_coor, w_find_eng,'r', [-num_z*dz/2, num_z*dz/2], [wR_eng, wR_eng], '--k',[z_find_eng(1),z_find_eng(1)],[0,  2*wR_eng],'-m',[z_find_eng(end),z_find_eng(end)],[0,  2*wR_eng],'-m');

axis([z_coor(1), z_coor(end), 0, 2*wR_eng]);

xlabel('y [m]','FontWeight','bold','FontSize',9.7);
ylabel('w\_OS [m]','FontWeight','bold','FontSize',9.7);
title(['Optical sectioning - zR  = ',char(vpa(abs(z_find_eng(1)*1e6),3)),'\mum'],'FontWeight','bold','FontSize',11);
text(z_find_eng(end),1.5*w_find_eng(loc_eng(end)),'\color{magenta} zR','FontWeight','bold','FontSize',11);
text(z0_eng,w_find_eng(loc0_eng)/2,["w0\_{OS} =",char(vpa(w0_eng,3))]);

set(gca,'FontSize',9.5);







