
function plotwml(field)


dz=2*field.z_range/200;
z_coor=((1:200)-1)*dz-field.z_range;
x=z_coor-z_coor(field.loc0);


y=field.wml;

%[m,n]=max(field.wml);

plot(x, y,'LineWidth',2,'DisplayName',[inputname(1),' w0=',char(vpa(field.wml(field.loc0),3))] );


%axis([0, 350e-6, 0, 10e-6]);

%text(x(n),m,[inputname(1),"w0=",char(vpa(field.wml(field.loc0),3))]);

xlabel('y [m]','FontWeight','bold','FontSize',20);
ylabel('w\_ML [m]','FontWeight','bold','FontSize',20);
title('Main Lobe Thickness Comparison of all Beams','FontWeight','bold','FontSize',24);


hold on;



