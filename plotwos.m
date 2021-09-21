
function plotwos(field)




dz=2*field.z_range/200;
z_coor=((1:200)-1)*dz-field.z_range;
x=z_coor-z_coor(field.loc0);

y=field.wos;



wR_eng=sqrt(2)*y(field.loc0);
w_abs_eng=abs(y-wR_eng);
w_sort_eng=sort(w_abs_eng);
[~,loc_eng]=find(w_abs_eng<=w_sort_eng(2));
z_find_eng=[x(loc_eng(1)),x(loc_eng(end))];

title('Optical Sectioning Comparison of all Beams','FontWeight','bold','FontSize',24);

plot(x, y,'LineWidth',2,'DisplayName',[inputname(1),' zR=', char(vpa(z_find_eng,3))]);

%plot([z_find_eng(1),z_find_eng(1)],[0, wR_eng],'--k',[z_find_eng(end),z_find_eng(end)],[0,  wR_eng],'--k');

%text(0,3.125e-06,[inputname(1),"w0_OS=3.125e-06"]);

xlabel('y [m]','FontSize',20,'FontWeight','bold');
ylabel('w\_OS [m]','FontSize',20,'FontWeight','bold');

hold on;






