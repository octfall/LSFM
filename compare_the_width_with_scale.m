% this matlab file is to give a view of frequency, run initial setup and
% main first.


% from E0 we get Ez then we can define the wos, compare all the wos and
% then do the 

% wo need to do the fitting to the residual  w_OS function  to fill the
% blank so that this actually function 


%{
 1) load function


Gaussian=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);


flattop=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);


DG=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);

Bessel=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);

Airyrotate_12=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);
Airyrotate_10=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);
Airyrotate_8=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);
Airyrotate_6=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);
Airyrotate_4=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);
Airyrotate_2=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);

SA=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);

lattice=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng);

%}

close all;
fig1 = figure('Position', [475 50 700 500]);
fig2 = figure('Position', [1200 50 700 500]);

set(0, 'CurrentFigure', fig1);
%{
plotwos(Gaussian);
plotwos(flattop);
plotwos(DG);
plotwos(Bessel);
plotwos(lattice);
plotwos(Airyrotate);
plotwos(SA);

%}

plotwos(Airyrotate_6);
plotwos(Airyrotate_4);
plotwos(Airyrotate_2);

%text(0,3.125e-06/2,"w0\_OS = 1.5625e-06");
axis([-150e-6, 150e-6, 0, 25e-6]);
set(gca,'FontName','Times New Roman','FontSize',15,'FontWeight','bold')
set(legend,'FontName','Times New Roman','FontSize',20,'FontWeight','bold')
legend;

set(0, 'CurrentFigure', fig2);
%{
plotwml(Gaussian);
plotwml(flattop);
plotwml(DG);
plotwml(Bessel);
plotwml(lattice);
plotwml(Airyrotate);
plotwml(SA);
%}

plotwml(Airyrotate_6);
plotwml(Airyrotate_4);
plotwml(Airyrotate_2);

axis([-150e-6, 150e-6, 0, 25e-6]);
set(gca,'FontName','Times New Roman','FontSize',15,'FontWeight','bold')
set(legend,'FontName','Times New Roman','FontSize',20,'FontWeight','bold')
legend;
%{
plotwml(Gaussian);
plotwml(flattop);
plotwml(DG);
%}
%save('FieldML.mat','Gaussian',"DG","flattop","Bessel","Airyrotate","SA",'lattice');
%save('lattice_os.mat','lattice');
