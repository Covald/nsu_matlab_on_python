clear

%���������� ���������� ���������,������, �������, �������, ������ ������� 
stop=1; xcold=0; ycold=0;% ���������� ������� ������ ������
alpha =1;betta=0.05; dt=0.03;radious=[];
T=0; per=0;apo=0;% ������ ��������� ��������
x=1.6;y=1; R=[x y];
scalar=[]; % ��������� ������������ �������� � ������ �������
u=0; w=0.8;V=[u w];r=sqrt(R*R');%���������� � �������� V
XRADIOUS=[R(1)];YRADIOUS=[R(2)];% ������  ������� ���������, ����� ����� 
%�� �������� ���������� ������������ 
%������ � ����� ����� ������� �������� ����������� ���������������
XVELOCITY=[V(1)]; YVELOCITY=[V(2)];% 
E=V*V'/2-alpha/r.^2;%������ �������
U=-alpha/r.^2;T=V*V'/2; %������������� � ������������
size=4;%������ ����

subplot(3,1,1);
h=animatedline(x,y,'color','k');%����������
pl=animatedline(x,y,'color','r','linestyle','none','marker','*');%�������
hs=line(0,0,'color','b','marker','+');% ����� ����
axis([-size size -size size]);axis square;% ���������� �����
set(gca,'buttondownfcn','stop=0');% �������� �� ������ � �� �����������
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

focus=line( xcold ,ycold,    'color','g','marker','+');% ���� �� ����� ���������� ������� ������
hs=line(0,0,'color','b','marker','+');% ����� ����
axis([-size size -size size]);axis square;
title('trace');

%R=R-V*dt;
pause
xstart=R(1);ystart=R(2);
R=R+V*dt; 
XRADIOUS=[XRADIOUS R(1)];YRADIOUS=[YRADIOUS R(2)];%���������� �������
r=sqrt(R*R'); radious=[radious abs(r)];x=R(1);y=R(2);%���������� �� ������
ac=-alpha*R/(r.^3);%���������
V=V+ac*dt; 
XVELOCITY=[XVELOCITY V(1)]; YVELOCITY=[YVELOCITY V(2)];% 

%�������� �������� ����������� � �

while (abs(x-xstart)>0.01) || (abs(y-ystart)>0.01)% ��� ����, �������� ������ ���� ����
    if stop==0
        break;
    end;
    T=T+dt;
    clearpoints(pl);
    R=R+V*dt; 
    %RADIOUS=[RADIOUS R];
    XRADIOUS=[XRADIOUS R(1)];
    YRADIOUS=[YRADIOUS R(2)];
    %� ������ ��������� �������� ���� � ������
    %���������� �������
    r=sqrt(R*R'); radious=[radious abs(r)];%���������� �� ������ � ������ � ������ ���. ����� ����� ����� �������� � ��������� 
    ac=-alpha*R/(r.^3);%���������
    V=V+ac*dt; x=R(1);y=R(2);%�������� �������� ����������� � �
    XVELOCITY=[XVELOCITY V(1)]; YVELOCITY=[YVELOCITY V(2)];% 
    E=V*V'/2-alpha/r.^2;%������ �������
    U=-alpha/r.^2;T=V*V'/2; %������������� � ������������
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
        disp('number');disp(number);% ���������� ����� ����� ���� ��������� ������������ ����
    end;
end;
X=[];Y=[];%Vx=[];Vy=[];
radious=[];
for i=1:length(number)
    X=[X XRADIOUS(number(i))];Y=[Y YRADIOUS(number(i))];
    r=sqrt(XRADIOUS(number(i))*XRADIOUS(number(i))+YRADIOUS(number(i))*YRADIOUS(number(i))); 
    radious=[radious r];
   % Vx=[Vx XVELOCITY(i)]; Vy=[Vy XVELOCITY(i)]; % ������ � ���� ����
   % ������ ��������� � ��������� 
end;
disp('X');disp(X);
disp('Y');disp(Y);
disp('radious');disp(radious);
%disp('max(radious)');disp(max(radious));
disp('R');disp(R);% ���������� ��������� ����� � ������������ �����������
disp('T');disp(T);

N=find(radious==max(radious));
M=find(radious==min(radious));
xmin=X(M);ymin=Y(M);xmax=X(N);ymax=Y(N);
disp('xmin,ymin,xmax,ymax,');
disp(xmin);disp(ymin);disp(xmax);disp(ymax);
apo=max(radious);per=min(radious);% ����� �������� � ��������� ������ ����� 
%��������� ����� ��������, ������� �� ������� ��� �������� �� ����� �� � ������


xcold=xmin+xmax; % ���������� ����������� � ������ �������
ycold=ymin+ymax; % ����������  ������ ������ � ������ �������

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

%��������, �� ������ ���������� ������ (0,0), ���������� �������� � ���������. 
%� ��� �� �����, ��� ������ ������������. ������, ���������� �� ������� �� ���������� �������� �� ������� ������ ���� �����������.
 
%���������� ��� ���������� ������� ������ (��-�� ������� ��������� ������) = ��� ����� ��������� ��������� � ��������.

