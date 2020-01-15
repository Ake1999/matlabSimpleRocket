%drawing thrown sphere trajectory in fluids
%board = rocket(v,a,r,m,d)
% inputs:
%   v: initial velocity(m/s)
%   a: launching angle(deg)
%   r: sphere radius(m)
%   m: mass(kg)
%   d: fluid density(kg/m^3)
% output:
%   rocket board(m)
function Ali=rocket(v,a,r,m,d)
    g=9.8;
    cd=0.47;
    s=0.01;
    A=pi*(r^2);
    drag=0.5*d*A*cd;
    a=a*pi/180;
    v0x=v*cos(a);
    v0y=v*sin(a);
    t=zeros(1,numel(1:s:floor(2*(v0y/g))));
    px=t;
    py=t;
    vx=t;
    vy=t;
    ax=t;
    ay=t;
    fdx=t;
    fdy=t;
    vx(1)=v0x;
    vy(1)=v0y;
    px(1)=0;
    py(1)=0;
    for i=1:numel(1:s:floor(5*(v0y/g)))
        t(i+1)=i*s;
        fdx(i)=-(drag*((vx(i))^2));
        ax(i)=(fdx(i)/m);
        if vy(i)>0
            fdy(i)=-(drag*((vy(i))^2));
        else
            fdy(i)=(drag*((vy(i))^2));
        end
         ay(i)=(fdy(i)/m)-g;
         vx(i+1)=(ax(i)*s)+vx(i);
         vy(i+1)=(ay(i)*s)+vy(i);
         px(i+1)=(((vx(i)+vx(i+1))/2)*s)+px(i);
         py(i+1)=(((vy(i)+vy(i+1))/2)*s)+py(i);
         if py(i+1)<=0
             break;
         end    
    end
    px((i+2):end)=[];
    py((i+2):end)=[];
    Ali=px(i+1);
    figure(1);
    axis equal;
    comet(px,py);
    hold on;
    figure(1);
    grid on;
    plot(px,py,'o-','color',[1 1 0],'linewidth',0.2,'markerfacecolor',[1 0.5 0]);
end
