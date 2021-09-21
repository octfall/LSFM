% this matlab file is to give a view of frequency, run initial setup and
% main first.
close all;
%%%%%input
%{
Ez=SA.Ez;
dz=SA.z_range*2/200;
w_find_eng=BesselAp.wos;
%}
%%%%%




fig1 = figure('Position', [50 50 800 800]);
fig2 = figure('Position', [850 50 800 800]);
% z=0   

set(0, 'CurrentFigure', fig1);
z_shift=z_coor-z_coor(loc0_eng);
z_temp=z_shift(loc0_eng);
subplot(211)

imagesc([az(1), az(end)],[x_czt(1) x_czt(end)],interp2(PSFSumY,2));
if axis_index==0
    axis([az(1), az(end), -axis_plot ,axis_plot]);
end 
if axis_index==1
    axis tight;
end
colormap(gray);
set(gca,'Ydir','normal')
xlabel('y [m]','FontWeight','bold','FontSize',15);
ylabel('z [m]','FontWeight','bold','FontSize',15);
title('YZsection','FontWeight','bold','FontSize',18);
set(gca,'FontSize',15) 


%set(0, 'CurrentFigure', fig2);
subplot(212)
PSFSumY_freq=zeros(size(PSFSumY));
%
for k=1:1:num_z


PSFSumY_freq(:,k) = abs(fftshift(fft(ifftshift(PSFSumY(:,k)))));
end

df_czt=1/(N*dx_czt);
f_czt=nPixel*df_czt;

%}


imagesc([az(1), az(end)],[f_czt(1) f_czt(end)],interp2((PSFSumY_freq),2));

colormap(gray);
set(gca,'Ydir','normal')
xlabel('y [m]','FontWeight','bold','FontSize',15);
ylabel('freq. [m^{-1}] ','FontWeight','bold','FontSize',15);
title('Freq. domain','FontWeight','bold','FontSize',18);
set(gca,'FontSize',15) 
axis([az(1), az(end), -w0/pi,w0/pi]);
%axis([-350e-6, 350e-6, -w0/10,w0/10]);


set(0, 'CurrentFigure', fig2);

PSFSumY_freq_0=log(PSFSumY_freq(:,101));
PSFSumY_freq_zR_1=log(PSFSumY_freq(:,loc_eng(1)));
PSFSumY_freq_zR_2=log(PSFSumY_freq(:,loc_eng(end)));

plot(f_czt,PSFSumY_freq_0,f_czt,PSFSumY_freq_zR_1,f_czt,PSFSumY_freq_zR_2,'Linewidth',2);
hold on;

title('Freq. domain of YZsection - OTF','FontWeight','bold','FontSize',20);
axis([-2*w0/pi,2*w0/pi,0,30])
xlabel('f [m]','FontWeight','bold','FontSize',15);
ylabel('log(freq.)','FontWeight','bold','FontSize',15);
set(gca,'FontSize',15) 
hold on;
plot([-w0/pi,-w0/pi],[0,30],'-k');
plot([w0/pi,w0/pi],[0,30],'-k');
text(w0/pi,3,'  f_{Abbe} (Cut-off)','FontWeight','bold','FontSize',15);

%{
plot([-w0/pi,-w0/pi]/6*scl,[0,30],'--k');
plot([w0/pi,w0/pi]/6*scl,[0,30],'--k');
text(w0/pi/6*scl,3,' f_{self} (Cut-off)','FontWeight','bold','FontSize',12);
%}
legend('y=0',[ 'zR(\mum) y=',char(vpa(z_shift(loc_eng(1))*1e6,3))],[ 'zR(\mum) y=',char(vpa(z_shift(loc_eng(end))*1e6,3))],'FontWeight','bold','FontSize',15)

%title('y=zR (um)',z_shift(loc_eng(1))*1e6);







