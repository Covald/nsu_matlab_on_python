clear
stop=1;
alpha1=1; betta=0.025; %взаимодействие между планетами
dt=0.03;n=5E4; 
x1=2.0;y1=0; R1=[x1 y1];V=[0 0.6]; rad1=[];%переменные для 1 тела
X1RAD=[R1(1)];Y1RAD=[R1(2)];
T1=0; PERIOD1=[];
X1VEL=[V(1)]; Y1VEL=[V(2)];
a=0;T=0;% переменные чтобы показать закон кеплера
interaction=0; size=5;
%%
subplot(2,2,1);
trace=animatedline(x1,y1,'color','blue','linestyle','--');%траектория
planet=animatedline(x1,y1,'color','blue','linestyle','none','marker','*');%планета
hs=line(0,0,'color','b','marker','+');% центр поля
axis([-size size -size size]);axis square;% квадратная рамка
set(gca,'buttondownfcn','stop=0');% кликните на график и он остановится
title('planets');

%%
subplot(2,2,2);
kepler=animatedline(a,T,'color', 'red');
axis([0 100 0 1000*size]);
xlim([0 100]);ylim([0 1000*size]);
xlabel('a^3');ylabel('T^2');
axe1=[];% массив полусосей
x1start=x1;y1start=y1;
pause; 
count=0; %буду считать сколько планеток мы создали
for i=1:100000%
    if stop==0
        break;
    end;
        clearpoints(planet);
        R1=R1+V*dt; 
        X1RAD=[X1RAD R1(1)];Y1RAD=[Y1RAD R1(2)];%координата планеты
        r1=sqrt(R1*R1'); x1=R1(1);y1=R1(2);%расстояние до центра
    %relR1(1)=x31;relR1(2)=y31;%
    %RR1=sqrt(relR1*relR1');% модуль расстояние между планетами
        ac1=-alpha1*R1/(r1.^3) ;%-interaction*relR1/(RR1.^3);%ускорение с учетом взаимодействия.
        V=V+ac1*dt; 
        X1VEL=[X1VEL V(1)]; Y1VEL=[Y1VEL V(2)];% \\
        addpoints(trace,x1,y1); addpoints(planet,x1,y1);
    %%
        T1=T1+dt;
        if ((abs(x1-x1start)<0.01) && (abs(y1-y1start)<0.01)) && T1-dt>1  %если встречаем новый год то смотрим на часики и вычисляем полуось
        PERIOD1=[PERIOD1 T1];% положил в массив период подсчитанный в данном проходе
        %% считаю большую ось
            number1=[];
            len1=length(X1RAD);
            for i=1:len1
                s=X1RAD(i)*X1VEL(i)+Y1RAD(i)*Y1VEL(i);
                if abs(s)<0.01
                   number1=[number1 i];
                end;
            end;
    
            X1=[];Y1=[];%Vx=[];Vy=[];
        %disp( 'X1RAD(100)');disp( X1RAD(100));
            for i=1:length(number1)
                X1=[X1 X1RAD(number1(i))];Y1=[Y1 Y1RAD(number1(i))];
                r1=sqrt(X1RAD(number1(i))*X1RAD(number1(i))+Y1RAD(number1(i))*Y1RAD(number1(i))); 
                rad1=[rad1 r1];
            end;
        %для закона кеплера нужна большая полуось - апогелий 
            N1=find(rad1==max(rad1));M1=find(rad1==min(rad1));
            xmin1=X1(M1);ymin1=Y1(M1);xmax1=X1(N1);ymax1=Y1(N1);
            halfbigaxes1=sqrt(0.5*(xmax1-xmin1).^2+0.5*(ymax1-ymin1).^2);
            axe1=[axe1 halfbigaxes1];
        %x1start=X1RAD(length(X1RAD));y1start=Y1RAD(length(Y1RAD));
            X1RAD=[];Y1RAD=[];X1VEL=[];Y1VEL=[];rad1=[];
            disp('axe1');disp(axe1);
            disp('PERIOD1');disp(PERIOD1); T1=0;
            x1start=x1start+0.5;
            x1=x1start; y1=0; R1(1)=x1; R1(2)=y1; V=V-0.05; alpha1=alpha1 -0.05;
            count=count+1;
           % disp('axe1');disp(axe1);
        % если я прошел круг то начинаю считать все заново
        end;
        drawnow;

end;
for i=1:count
    a=axe1(i).^3;
    T=PERIOD1(i).^2;
    addpoints(kepler,a,T);
    drawnow;
   
end;
