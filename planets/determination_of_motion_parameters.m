clear

%ОПРЕДЕЛИТЬ координаты перегилия,апогея, периода, фокусов, график энергий 
stop=1; xcold=0; ycold=0;% координаты второго фокуса элипса
alpha =1;betta=0.05; dt=0.03;radious=[];
T=0; per=0;apo=0;% период перигелий апогелий
x=1.6;y=1; R=[x y];
scalar=[]; % скалярное произведение скорости и радиус вектора
u=0; w=0.8;V=[u w];r=sqrt(R*R');%координаты и скорость V
XRADIOUS=[R(1)];YRADIOUS=[R(2)];% ЗАВОЖУ  массивы координат, чтобы потом 
%по значению скалярного произведения 
%понять в какой точке векторы скорости икоординаты перпендикулярны
XVELOCITY=[V(1)]; YVELOCITY=[V(2)];% 
E=V*V'/2-alpha/r.^2;%полная энергия
U=-alpha/r.^2;T=V*V'/2; %потенциальная и кинетическая
size=4;%размер окна

subplot(3,1,1);
h=animatedline(x,y,'color','k');%траектория
pl=animatedline(x,y,'color','r','linestyle','none','marker','*');%планета
hs=line(0,0,'color','b','marker','+');% центр поля
axis([-size size -size size]);axis square;% квадратная рамка
set(gca,'buttondownfcn','stop=0');% кликните на график и он остановится
title('motion in the potential fiel without adding');
set(gca,'xtick',[],'ytick',[]);
subplot(3,1,2);
hE=animatedline(r,E,'color','r');
hU=animatedline(r,U,'color','b');
hT=animatedline(r,T,'color','k');
axis([-size size -size size])
title('Energy');
p=legend('E','U','T');
 

subplot(3,1,3);
trace=line(XRADIOUS, YRADIOUS);

focus=line( xcold ,ycold,    'color','g','marker','+');% пока не знаем координаты второго фокуса
hs=line(0,0,'color','b','marker','+');% центр поля
axis([-size size -size size]);axis square;
title('trace');

%R=R-V*dt;
pause
xstart=R(1);ystart=R(2);
R=R+V*dt; 
XRADIOUS=[XRADIOUS R(1)];YRADIOUS=[YRADIOUS R(2)];%координата планеты
r=sqrt(R*R'); radious=[radious abs(r)];x=R(1);y=R(2);%расстояние до центра
ac=-alpha*R/(r.^3);%ускорение
V=V+ac*dt; 
XVELOCITY=[XVELOCITY V(1)]; YVELOCITY=[YVELOCITY V(2)];% 

%вычислил скорости икоординаты х у

while (abs(x-xstart)>0.01) || (abs(y-ystart)>0.01)% ура каев, работает делает один цикл
    if stop==0
        break;
    end;
    T=T+dt;
    clearpoints(pl);
    R=R+V*dt; 
    %RADIOUS=[RADIOUS R];
    XRADIOUS=[XRADIOUS R(1)];
    YRADIOUS=[YRADIOUS R(2)];
    %В МАССИВ КООРДИНАТ ДОБАВЛЯЮ ИКСЫ И ИГРИКИ
    %координата планеты
    r=sqrt(R*R'); radious=[radious abs(r)];%расстояние до центра и заношу в массив это. чтобы найти потом апогелий и перегелий 
    ac=-alpha*R/(r.^3);%ускорение
    V=V+ac*dt; x=R(1);y=R(2);%вычислил скорости икоординаты х у
    XVELOCITY=[XVELOCITY V(1)]; YVELOCITY=[YVELOCITY V(2)];% 
    E=V*V'/2-alpha/r.^2;%полная энергия
    U=-alpha/r.^2;T=V*V'/2; %потенциальная и кинетическая
    addpoints(h,x,y); addpoints(pl,x,y);
    addpoints(hE,r,E);addpoints(hT,r,T);addpoints(hU,r,U);
    drawnow
end;
len=length(XRADIOUS);
disp(len);
 number=[];
for i=1:len
    
    s=XRADIOUS(i)*XVELOCITY(i)+YRADIOUS(i)*YVELOCITY(i);
    %disp(scalar);
    if abs(s)<0.01
       
        number=[number i];
        disp('number');disp(number);% определили какие точки дают скалярное произведение ноль
    end;
end;
X=[];Y=[];%Vx=[];Vy=[];
radious=[];
for i=1:length(number)
    X=[X XRADIOUS(number(i))];Y=[Y YRADIOUS(number(i))];
    r=sqrt(XRADIOUS(number(i))*XRADIOUS(number(i))+YRADIOUS(number(i))*YRADIOUS(number(i))); 
    radious=[radious r];
   % Vx=[Vx XVELOCITY(i)]; Vy=[Vy XVELOCITY(i)]; % теперь у меня есть
   % массиы координат и скоростей 
end;
disp('X');disp(X);
disp('Y');disp(Y);
disp('radious');disp(radious);
%disp('max(radious)');disp(max(radious));
disp('R');disp(R);% показывает финаьлную точку в кругосветном путешествии
disp('T');disp(T);

N=find(radious==max(radious));
M=find(radious==min(radious));
xmin=X(M);ymin=Y(M);xmax=X(N);ymax=Y(N);
disp('xmin,ymin,xmax,ymax,');
disp(xmin);disp(ymin);disp(xmax);disp(ymax);
apo=max(radious);per=min(radious);% знаем апогелий и перегелий значит знаем 
%расстоние между фокусами, которое не менятся при переходе из одной ск в другую


xcold=xmin+xmax; % координата иксатфокуса в старой системе
ycold=ymin+ymax; % координата  игрика фокуса в старой системе

set(trace,'xdata',XRADIOUS,'ydata',YRADIOUS);
set(focus,'xdata',xcold,'ydata',ycold,'color','r','marker','+');
set(hs,'xdata',0,'ydata',0,'color','r','marker','+');
disp('xcold');disp(xcold);
disp('ycold');disp(ycold);
disp('ymin');disp(ymin);
disp('xmin');disp(xmin);
disp('ymax');disp(ymax);
disp('xmax');disp(xmax);
disp('min(radious)');disp(min(radious));
disp('max(radious)');disp(max(radious));

%Смотрите, вы знаете координаты Солнца (0,0), координаты апогелия и перигелия. 
%А еще мы знаем, что эллипс симметричный. Значит, расстояние от фокусов до локального минимума по радиусу должны быть одинаковыми.
 
%Получается что координаты второго фокуса (из-за нулевых координат Солнца) = это сумма координат перигелия и апогелия.

