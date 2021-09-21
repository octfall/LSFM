%the first is to check the theory of plane Gaussian's PSF waist variationn
%third, SUMYZ and the third the energy waist.
close all;
syms w
w_frac=double(vpasolve(erf(w)==1-exp(-1))); %w_frac=w_OS/w
w0=NA_ill*k0/12;
sliYZ = squeeze(Iz_norm(cx,:,:));
PSFSumY = squeeze(sum(Iz_norm,2)); % sumY is the view in the plane of y-z plane, sum along the x-coor
w_find_sli=zeros(1,num_z);
w_find_sec_x=zeros(1,num_z);
w_find_eng=zeros(1,num_z);


for j= 1:num_z
    

[w_find_sli(j),~,~,xo_y_sli,x1_y_sli,x2_y_sli]=find_the_width(x_czt,sliYZ(:,j)./max(sliYZ(:,j)),exp(2));
w_find_sli(j)=w_find_sli(j)/2;
[w_find_sec_x(j),~,~,xo_x_sec,x1_x_sec,x2_x_sec]=find_the_width(x_czt,PSFSumY(:,j)./max(PSFSumY(:,j)),exp(2));
w_find_sec_x(j)=w_find_sec_x(j)/2;
w_find_eng(j)=energy_width(PSFSumY(:,j),x_czt,N);
%w_find_eng(j)=osWidth_gui(PSFSumY(:,j), N,dx_czt);
w_find_eng(j)=w_find_eng(j)/2;
end


wR_eng=sqrt(2)*w_find_eng(1);
wR_sec_x=sqrt(2)*w_find_sec_x(1);
wR_sli=sqrt(2)*w_find_sli(1);

w_range=15e-6;
%%%% Section check
figure(2)
subplot(211)

[~,loc_sec_x]=min(abs(w_find_sec_x-wR_sec_x)); 
z_find_sec_x=(loc_sec_x-1)*dz;
plot(z_coor, w_find_sec_x,'r', [0, num_z*dz], [wR_sec_x, wR_sec_x], '--k',[z_find_sec_x,z_find_sec_x],[0,  w_range],'-m');
axis([z_coor(1), z_coor(end), 0, w_range]);
xlabel('y [m]');
ylabel('Main lobe width wML [m]');
title('hw 1/e^2 of maximum Intensity, YZ section');
text(z_find_sec_x,w_find_sec_x(loc_sec_x)/2,["zR\_sec =",char(vpa(z_find_sec_x,3))]);
text(0,w_find_sec_x(1)/2,["w0\_sec =",char(vpa(w_find_sec_x(1),3))]);

subplot(212)
w_0_theo=2*pi/(pi*w0);       % w_0_theo is set as Rayleugh length of field
w_R_theo=w_0_theo*sqrt(2);           % this is sqrt(2)*w_0_field

z_find_theo=pi*w_0_theo^2/lambda;        %  z_R field 

z_R=z_find_theo;

w_find_theo=w_0_theo*sqrt(1+z_coor.^2/(z_find_theo.^2));

plot(z_coor, w_find_theo,'r', [0, num_z*dz], [w_R_theo, w_R_theo], '--k',[z_find_theo,z_find_theo],[0, w_range],'-m');
axis([z_coor(1), z_coor(end), 0, w_range]);
xlabel('y [m]');
ylabel('Main lobe width\_theo [m]');
title('SectionYZ theoretical outcome');
text(z_find_theo,w_find_sli(loc_sli)/2,["zR\_theo =",char(vpa(z_find_theo,3))]);
text(0,w_find_theo(1)/2,["w0\_ML\_theo =",char(vpa(w_find_theo(1),3))]);



%%%% SliceYZ check
figure(1)
subplot(211)

[~,loc_sli]=min(abs(w_find_sli-wR_sli)); 
z_find_sli=(loc_sli-1)*dz;
plot(z_coor, w_find_sli,'r', [0, num_z*dz], [wR_sli, wR_sli], '--k',[z_find_sli,z_find_sli],[0,  w_range],'-m');
axis([z_coor(1), z_coor(end), 0, w_range]);
xlabel('y [m]');
ylabel('Main lobe width\_theo [m]');
%title('hwhm find for YZ cut');
title('hw 1/e^2 of maximum y,YZ cut');
text(z_find_sli,w_find_sli(loc_sli)/2,["zR\_sli =",char(vpa(z_find_sli,3))]);
text(0,w_find_sli(1)/2,["w0\_sli =",char(vpa(w_find_sli(1),3))]);

subplot(212)
w_0_theo=2*pi/(pi*w0);       % w0 is the width on k-space of field,w_0_theo is the width of Intensity,i.e.,w_0_int=w_0_field/sqrt(2)
w_R_theo=w_0_theo*sqrt(2);           % this is sqrt(2)*w_0_field

z_find_theo=pi*w_0_theo^2/lambda;            %  z_R field 
z_R=z_find_theo;
w_find_theo=w_0_theo*sqrt(1+z_coor.^2/(z_find_theo.^2));

plot(z_coor, w_find_theo,'r', [0, num_z*dz], [w_R_theo, w_R_theo], '--k',[z_find_theo,z_find_theo],[0, w_range],'-m');
axis([z_coor(1), z_coor(end), 0, w_range]);
xlabel('y [m]');
ylabel('Main lobe width\_theo [m]');
title('YZ cut theoretical outcome');
text(z_find_theo,w_find_sli(loc_sli)/2,["zR\_theo =",char(vpa(z_find_theo,3))]);
text(0,w_find_theo(1)/2,["w0\_ML\_theo =",char(vpa(w_find_theo(1),3))]);




%%%% WOS check 

figure(3)

subplot(211)



[~,loc_eng]=min(abs(w_find_eng-wR_eng)); 
z_find_eng=(loc_eng-1)*dz;
plot(z_coor, w_find_eng,'r', [0, num_z*dz], [wR_eng, wR_eng], '--k',[z_find_eng,z_find_eng],[0,  w_range],'-m');
axis([z_coor(1), z_coor(end), 0, w_range]);

xlabel('y [m]');
ylabel('w\_OS [m]');
title('Optical sectioning width w\_OS for YZsection');
text(z_find_eng,w_find_eng(loc_eng)/2,["zR\_OS =",char(vpa(z_find_eng,3))]);
text(0,w_find_eng(1)/2,["w0\_OS =",char(vpa(w_find_eng(1),2))]);


subplot(212)
w_0_theo=w_frac*2*pi/(pi*w0)/sqrt(2);       % w0 is the width on k-space of field,w_0_theo is the width on x-space of Intensity
w_R_theo=w_0_theo*sqrt(2);
z_find_OS=pi*w_0_theo^2/lambda;             % z_R_intensity
z_find_theo=2/w_frac^2*z_find_OS;             %  z_R field 
 
w_find_theo=w_0_theo*sqrt(1+z_coor.^2/((z_find_theo).^2));

plot(z_coor, w_find_theo,'r', [0, num_z*dz], [w_R_theo, w_R_theo], '--k',[z_find_theo,z_find_theo],[0, w_range],'-m');
axis([z_coor(1), z_coor(end), 0, w_range]);
xlabel('y [m]');
ylabel('w\_OS\_theo [m]');
title('w\_OS theoretical outcome');
text(z_find_theo,w_find_sli(loc_sli)/2,["zR\_theo =",char(vpa(z_find_theo,3))]);
text(0,w_find_theo(1)/2,["w0\_OS\_theo =",char(vpa(w_find_theo(1),2))]);





