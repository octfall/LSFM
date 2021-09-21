function field=creat_the_struct(field,z_range,w_find_eng,w_find_sec_x,loc0_eng)
field=struct(field);
%field.Ez=Ez;    % no enough room for storing
field.z_range= z_range;
field.wos=w_find_eng;
field.wml=w_find_sec_x;
field.loc0=loc0_eng;






