function [Width,w1,w2,xo,x1,x2,slope1,slope2]=find_the_width(x,y,width_index,xo)
% Code based on Tom O'Haver (toh@umd.edu) Version 2, July 2016
%
% input x,y, find the width and corresponding x_coordes of the
% max/width_index around xo, if xo is omitted, it is the x position
% corresponding to the maximum y-value; also output the sloop if needed.

if nargin==3,xo=x(val2ind(y,max(y)));end
try   
    indmax=val2ind(x,xo);
    maxy=y(indmax);
    oy=y-maxy/width_index;
    
    n=indmax;
    while oy(n)>0,
        n=n-1;
    end
    x1=interp1([y(n) y(n+1)],[x(n) x(n+1)],maxy/width_index);
    slope1=(y(n+1)-y(n))./(x(n+1)-x(n));
    
    n=indmax;
    while oy(n)>0,
        n=n+1;
    end
    x2= interp1([y(n-1) y(n)],[x(n-1) x(n)],maxy/width_index);
    slope2=(y(n-1)-y(n))./(x(n-1)-x(n));
    
    Width=x2-x1;
    w1=xo-x1;
    w2=x2-xo;
catch
    Width=NaN;
end