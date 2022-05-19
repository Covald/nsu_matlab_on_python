clear
% движение с разными добавками
stop=1;
alpha =1;betta=0.01; dt=0.05;n=5E4; 
x=1.5;y=0; R=[x y];V=[0 0.6];%переменные для движения без добавки];%
xx=1.5;yy=0;Rq=[xx yy];U=[0 0.6];%
e=1.5;c=0;Rz=[e c];W=[0 0.6];%
size=4;
%
subplot(3,1,1);
h=animatedline(x,y,'color','k');%траектория
pl=animatedline(x,y,'color','r','linestyle','none','marker','*');%планета
hs=line(0,0,'color','b','marker','+');% центр поля
axis([-size size -size size]);axis square;% квадратная рамка
set(gca,'buttondownfcn','stop=0');% кликните на график и он остановится
title('motion in the potential fiel without adding');
%set(gca,'xtick',[],'ytick',[]);
% для показа движеня в поле с добавкой 1/r*r
subplot(3,1,2);
q=animatedline(xx,yy,'color','k');%траектория
body=animatedline(x,y,'color','k','linestyle','none','marker','*');%планета
hs=line(0,0,'color','b','marker','+');% центр поля
axis([-size size -size size]);axis square;% квадратная рамка
set(gca,'buttondownfcn','stop=0');
title('motion in the potential fiel with adding 1/r^2');
%set(gca,'xtick',[],'ytick',[]);
% для показа движения в поле с добавкой 1\r*r*r
subplot(3,1,3);
Q=animatedline(e,c,'color','k');%траектория
BODY=animatedline(e,c,'color','g','linestyle','none','marker','*');%планета
hs=line(0,0,'color','b','marker','+');% центр поля
axis([-size size -size size]);axis square;% квадратная рамка
set(gca,'buttondownfcn','stop=0');
title('motion in the potential fiel with adding 1/r^3');

R=R-V*dt;
pause
while stop
    if stop==0
        break;
    end;
    clearpoints(pl);clearpoints(body);clearpoints(BODY);
    R=R+V*dt;%координата планеты
    r=sqrt(R*R');%расстояние до центра
    ac=-alpha*R/(r.^3);%ускорение
    V=V+ac*dt; x=R(1);y=R(2);%вычислил скорости икоординаты х у
    addpoints(h,x,y); addpoints(pl,x,y);
    %вычисляю кординату в случае поля с добавкой betta/r*r
    Rq=Rq+U*dt; rq=sqrt(Rq*Rq');%
    acq=-alpha*Rq/(rq.^3)-2*betta*Rq/(rq.^4);%
    U=U+acq*dt; xx=Rq(1);yy=Rq(2);%вычислил скорости икоординаты х у
    addpoints(q,xx,yy); addpoints(body,xx,yy);%
    %вычисляю кординату в случае поля с добавкой betta/r*r*r
    Rz=Rz+W*dt; rz=sqrt(Rz*Rz');%
    acz=-alpha*Rz/(rz.^3)-3*betta*Rz/(rz.^5);%
    W=W+acz*dt; e=Rq(1);c=Rq(2); % вычислил скорости икоординаты х у
    addpoints(Q,e,c); addpoints(BODY,e,c);%
    drawnow
end;
