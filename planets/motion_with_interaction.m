%относительное движение, и учитывание взаимодействия планет

clear
stop=1;
alpha1=1; betta=0.025; %взаимодействие между планетами
dt=0.03;n=5E4; 
x1=1;y1=0; R1=[x1 y1];V=[0 0.6]; rad1=[];%переменные для 1 тела
X1RAD=[R1(1)];Y1RAD=[R1(2)];
T1=0; PERIOD1=[];
X1VEL=[V(1)]; Y1VEL=[V(2)];
%%
alpha2=0.4;%взаимодествие между солнцем и марсом
x2=3.5;y2=0;R2=[x2 y2];U=[0 0.3];rad2=[];
X2RAD=[R2(1)];Y2RAD=[R2(2)];
X2VEL=[U(1)]; Y2VEL=[U(2)];
T2=0; PERIOD2=[];
size=8;
%%
relR1=[]; %координаты вектора относительного расстояния
x31=x1-x2;y31=y1-y2;
relR1(1)=x31;relR1(2)=y31;%радиус вектор от марса до земли
x32=x2-x1;y31=y2-y1;
relR2(1)=x31;relR2(2)=y31;%радиус вектор от земли до марса
answer=input(' хотите ввести взаимодейстиве между планетами? 42-йес, другое число-нет');
if answer==42
    interaction=0.02; % коэф. взаимодействия между земдей и марсом
    name='motion with interaction';
else
    interaction=0.0;
    name='motion without interaction';
end;
%%
subplot(2,2,1);
earthtrace=animatedline(x1,y1,'color','blue','linestyle','--');%траектория
marstrace=animatedline(x2,y2,'color','red','linestyle',':');%траектория
earth=animatedline(x1,y1,'color','blue','linestyle','none','marker','*');%планета

mars=animatedline(x2,y2,'color','red','linestyle','none','marker','.');%планета
hs=line(0,0,'color','b','marker','+');% центр поля
axis([-size size -size size]);axis square;% квадратная рамка
w1=legend('Earth','Mars')
set(gca,'buttondownfcn','stop=0');% кликните на график и он остановится
title(name);% название определили выше
%%
%относительное движение
subplot(2,2,2);
relativitytracemars=animatedline(x31,y31,'color','red','linestyle','-');%траектория
relativitytracesun=animatedline(-x1,-y1,'color','green','linestyle','-');%траектория
relativitymars=animatedline(x31,y31,'color','red','linestyle','none','marker','.');%планета
relativitysun=animatedline(-x1,-y1,'color','red','linestyle','none','marker','.');%планета
axis([-size size -size size]);axis square;% квадратная рамка
w1=legend('Mars','a star called the sun')
set(gca,'buttondownfcn','stop=0');% кликните на график и он остановится
title('relativity motion');
%%
%начальные данные для земли
%хотим ввести взаимодействие между планетами 
%%
pause
x1start=R1(1);y1start=R1(2);
R1=R1+V*dt; 
X1RAD=[X1RAD R1(1)];Y1RAD=[Y1RAD R1(2)];%координата планеты
r1=sqrt(R1*R1'); x1=R1(1);y1=R1(2);%расстояние до центра
x31=x1-x2;y31=y1-y2;
relR1(1)=x31;relR1(2)=y31;%
RR1=sqrt(relR1*relR1');% модуль расстояние между планетами
ac1=-alpha1*R1/(r1.^3) -interaction*relR1/(RR1.^3);%ускорение с учетом взаимодействия.
V=V+ac1*dt; 
X1VEL=[X1VEL V(1)]; Y1VEL=[Y1VEL V(2)];% 
%%
%начальные данные для марса
x2start=R2(1);y2start=R2(2);
R2=R2+V*dt; 
X2RAD=[X2RAD R2(1)];Y2RAD=[Y2RAD R2(2)];%координата планеты
r2=sqrt(R2*R2'); x2=R2(1);y2=R2(2);%расстояние до центра
x32=x2-x1;y32=y2-y1;
relR2(1)=x32;relR2(2)=y32;
RR2=sqrt(relR2*relR2');
ac2=-alpha2*R2/(r2.^3)-interaction*relR2/RR2.^3;%ускорение с учетом взаимодействия. 
U=U+ac2*dt; 
X2VEL=[X2VEL U(1)]; Y2VEL=[Y2VEL U(2)];% 
%%
%(abs(x-xstart)>0.01) || (abs(y-ystart)>0.01)% ура каев, работает делает один цикл
count1=0; %считает количество периодов
count2=0;
Tprevious=0;
for i=1:100000%
    if stop==0
        break;
    end;
    clearpoints(earth);
    clearpoints(mars);
    clearpoints(relativitymars);
    clearpoints(relativitysun);
    %%

    T1=T1+dt;
    if ((abs(x1-x1start)<0.01) && (abs(y1-y1start)<0.01)) && T1-dt>1 %считаю период для земли для 1 только в 1 проходе
        %T1>2 ужно для того чтобы исключить попадания под условия на
        %координаты первые шаги, когда х и у еще очень мал
        count1=count1+1;

        PERIOD1=[PERIOD1 T1/count1];
    end;
    
    %% для земли
    R1=R1+V*dt; 
    X1RAD=[X1RAD R1(1)];Y1RAD=[Y1RAD R1(2)];%координата планеты
    r1=sqrt(R1*R1'); x1=R1(1);y1=R1(2);%расстояние до центра
    x31=x1-x2;y31=y1-y2;
    relR1(1)=x31;relR1(2)=y31;%
    RR1=sqrt(relR1*relR1');% модуль расстояние между планетами
    ac1=-alpha1*R1/(r1.^3) -interaction*relR1/(RR1.^3);%ускорение с учетом взаимодействия.
    V=V+ac1*dt; 
    X1VEL=[X1VEL V(1)]; Y1VEL=[Y1VEL V(2)];% 
    addpoints(earthtrace,x1,y1); addpoints(earth,x1,y1);
    %%
    T2=T2+dt;
    if ((abs(x2-x2start)<0.004) && (abs(y2-y2start)<0.004)) && T2-Tprevious>1  %считаю период для 
        count2=count2+1;
        disp('T2');disp(T2);
       PERIOD2=[PERIOD2 T2/count2];
       disp('count2');disp(count2);
       disp(PERIOD2);
       Tprevious=T2;
    end;
    
    %%
    x2start=R2(1);y2start=R2(2);
    R2=R2+U*dt; 
    X2RAD=[X2RAD R2(1)];Y2RAD=[Y2RAD R2(2)];%координата планеты
    r2=sqrt(R2*R2'); x2=R2(1);y2=R2(2);%расстояние до центра
    x32=x2-x1;y32=y2-y1;
    relR2(1)=x32;relR2(2)=y32;
    RR2=sqrt(relR2*relR2');
    ac2=-alpha2*R2/(r2.^3)-interaction*relR2/RR2.^3;%ускорение с учетом взаимодействия. 
    U=U+ac2*dt; 
    X2VEL=[X2VEL U(1)]; Y2VEL=[Y2VEL U(2)];%
    addpoints(marstrace,x2,y2); addpoints(mars,x2,y2);
    %%
    addpoints(relativitymars,x31,y31);
    addpoints(relativitytracemars,x31,y31);
    addpoints(relativitysun,-x1,-y1);
    addpoints(relativitytracesun,-x1,-y1);
    drawnow
end;
%%
%считаем большую  полуось для земли
 number1=[];
 len1=length(X1RAD);
for i=1:len1
    s=X1RAD(i)*X1VEL(i)+Y1RAD(i)*Y1VEL(i);
    if abs(s)<0.01
        number1=[number1 i];
    end;
end;
X1=[];Y1=[];%Vx=[];Vy=[];
for i=1:length(number1)
    X1=[X1 X1RAD(number1(i))];Y1=[Y1 Y1RAD(number1(i))];
    r1=sqrt(X1RAD(number1(i))*X1RAD(number1(i))+Y1RAD(number1(i))*Y1RAD(number1(i))); 
    rad1=[rad1 r1];
end;
%для закона кеплера нужна большая полуось - апогелий 
N1=find(rad1==max(rad1));M1=find(rad1==min(rad1));
xmin1=X1(M1);ymin1=Y1(M1);xmax1=X1(N1);ymax1=Y1(N1);
halfbigaxes1=sqrt(0.5*(xmax1-xmin1).^2+0.5*(ymax1-ymin1).^2)
disp(halfbigaxes1);disp('halfbigaxes1');
%%
number2=[];
len2=length(X2RAD);
for i=1:len2
    s=X2RAD(i)*X2VEL(i)+Y2RAD(i)*Y2VEL(i);
    if abs(s)<0.01
        number2=[number2 i];
    end;
end;
X2=[];Y2=[];%Vx=[];Vy=[];
for i=1:length(number2)
    X2=[X2 X1RAD(number2(i))];Y2=[Y2 Y2RAD(number2(i))];
    r2=sqrt(X2RAD(number2(i))*X2RAD(number2(i))+Y2RAD(number2(i))*Y2RAD(number2(i))); 
    rad2=[rad2 r2];
end;
%для закона кеплера нужна большая полуось - апогелий 
N2=find(rad2==max(rad2));M2=find(rad2==min(rad2));
xmin2=X2(M2);ymin2=Y2(M2);xmax2=X2(N2);ymax2=Y2(N2);
halfbigaxes2=sqrt(0.5*(xmax2-xmin2).^2+0.5*(ymax2-ymin2).^2)
disp(halfbigaxes2);disp('halfbigaxes2');
%%
