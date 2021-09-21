% view of 
close all;

subplot (121)
PSFSum_0=PSFSumY(:,loc0_eng)./max(PSFSumY(:,loc0_eng));
plot(x_czt,PSFSum_0,...
[w_find_sec_x(loc0_eng),w_find_sec_x(loc0_eng)],[0,1],'--k',[-w_find_sec_x(loc0_eng),-w_find_sec_x(loc0_eng)],[0,1],'--k',...
[w_find_eng(loc0_eng),w_find_eng(loc0_eng)],[0,1],'--m',[-w_find_eng(loc0_eng),-w_find_eng(loc0_eng)],[0,1],'--m','Linewidth',1.5)
axis([-7e-6,7e-6,0,1])
text(w_find_sec_x(loc0_eng),0.05,' w\_ML','FontWeight','bold','FontSize',18)
text(w_find_eng(loc0_eng),0.2,' \color{magenta} w\_OS','FontWeight','bold','FontSize',18)
title('DG','y=0','FontWeight','bold','FontSize',30)
set(gca,'FontSize',15) 
subplot (122)
PSFSum_1=PSFSumY(:,loc_eng(1))./max(PSFSumY(:,loc_eng(1)));
plot(x_czt,PSFSum_1,...
    [w_find_sec_x(loc_eng(1)),w_find_sec_x(loc_eng(1))],[0,1],'--k',[-w_find_sec_x(loc_eng(1)),-w_find_sec_x(loc_eng(1))],[0,1],'--k',...
    [w_find_eng(loc_eng(1)),w_find_eng(loc_eng(1))],[0,1],'--m',[-w_find_eng(loc_eng(1)),-w_find_eng(loc_eng(1))],[0,1],'--m','Linewidth',1.5)
text(w_find_sec_x(loc_eng(1) ),0.05,' w\_ML','FontWeight','bold','FontSize',18)
text(w_find_eng(loc_eng(1)),0.2,'\color{magenta} w\_OS','FontWeight','bold','FontSize',18)
axis([-7e-6,7e-6,0,1])
title('y=zR', [char(vpa(abs(z_find_eng(1)*1e6),3)),'\mum'],'FontWeight','bold','FontSize',30)
set(gca,'FontSize',15) 