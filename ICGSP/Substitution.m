%%%相关性分析
%% 原始图像相邻像素相关性分析
%{
先随机在0~M-1行和0~N-1列选中1000个像素点，
计算水平相关性时，选择每个点的相邻的右边的点；
计算垂直相关性时，选择每个点的相邻的下方的点；
计算对角线相关性时，选择每个点的相邻的右下方的点。
%}
P=rgb2gray(imread('E:\Database\ALL_REF\Cobblestone\Frame_000.png'));
[M,N]=size(P);  
I1=P;

NN=1000;    %随机取1000对像素点
x1=ceil(rand(1,NN)*(M-1));      %生成1000个1~M-1的随机整数作为行
y1=ceil(rand(1,NN)*(N-1));      %生成1000个1~N-1的随机整数作为列
%预分配内存
XX_R_SP=zeros(1,1000);YY_R_SP=zeros(1,1000);        %水平
XX_R_CZ=zeros(1,1000);YY_R_CZ=zeros(1,1000);        %垂直
XX_R_DJX=zeros(1,1000);YY_R_DJX=zeros(1,1000);      %对角线

for i=1:1000
    %水平
    XX_R_SP(i)=I1(x1(i),y1(i));
    YY_R_SP(i)=I1(x1(i)+1,y1(i));
  
    %垂直
    XX_R_CZ(i)=I1(x1(i),y1(i));
    YY_R_CZ(i)=I1(x1(i),y1(i)+1);
   
    %对角线
    XX_R_DJX(i)=I1(x1(i),y1(i));
    YY_R_DJX(i)=I1(x1(i)+1,y1(i)+1);
    
end
%水平 随机点像素灰度值  , 与该点相邻水平方向像素灰度值,  原始图像水平相关性曲线
figure;scatter(XX_R_SP,YY_R_SP,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent horizontal direction');title('The horizontal correlation curve of the plain image');

%垂直  随机点像素灰度值, 与该点相邻垂直方向像素灰度值, 原始图像垂直相关性曲线
figure;scatter(XX_R_CZ,YY_R_CZ,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent vertical direction');title('The vertical correlation curve of the plain image');

%对角线  随机点像素灰度值  , 与该点相邻对角线方向像素灰度值, 原始图像对角线相关性曲线
figure;scatter(XX_R_DJX,YY_R_DJX,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent diagonal direction');title('The diagonal correlation curve of the plain image');

EX1_R=0;EY1_SP_R=0;DX1_R=0;DY1_SP_R=0;COVXY1_SP_R=0;    %计算水平相关性时需要的变量
EY1_CZ_R=0;DY1_CZ_R=0;COVXY1_CZ_R=0;                %垂直
EY1_DJX_R=0;DY1_DJX_R=0;COVXY1_DJX_R=0;             %对角线

I1=double(I1);

for i=1:NN
    %第一个像素点的E，水平、垂直、对角线时计算得出的第一个像素点的E相同，统一用EX1表示
    EX1_R=EX1_R+I1(x1(i),y1(i)); 

    %第二个像素点的E，水平、垂直、对角线的E分别对应EY1_SP、EY1_CZ、EY1_DJX
    EY1_SP_R=EY1_SP_R+I1(x1(i),y1(i)+1);
    EY1_CZ_R=EY1_CZ_R+I1(x1(i)+1,y1(i));
    EY1_DJX_R=EY1_DJX_R+I1(x1(i)+1,y1(i)+1);
   
end
%统一在循环外除以像素点对数1000，可减少运算次数
EX1_R=EX1_R/NN;
EY1_SP_R=EY1_SP_R/NN;
EY1_CZ_R=EY1_CZ_R/NN;
EY1_DJX_R=EY1_DJX_R/NN;

for i=1:NN
    %第一个像素点的D，水平、垂直、对角线时计算得出第一个像素点的D相同，统一用DX表示
    DX1_R=DX1_R+(I1(x1(i),y1(i))-EX1_R)^2;
    
    %第二个像素点的D，水平、垂直、对角线的D分别对应DY1_SP、DY1_CZ、DY1_DJX
    DY1_SP_R=DY1_SP_R+(I1(x1(i),y1(i)+1)-EY1_SP_R)^2;
    DY1_CZ_R=DY1_CZ_R+(I1(x1(i)+1,y1(i))-EY1_CZ_R)^2;
    DY1_DJX_R=DY1_DJX_R+(I1(x1(i)+1,y1(i)+1)-EY1_DJX_R)^2;
   
    %两个相邻像素点相关函数的计算，水平、垂直、对角线
    COVXY1_SP_R=COVXY1_SP_R+(I1(x1(i),y1(i))-EX1_R)*(I1(x1(i),y1(i)+1)-EY1_SP_R);
    COVXY1_CZ_R=COVXY1_CZ_R+(I1(x1(i),y1(i))-EX1_R)*(I1(x1(i)+1,y1(i))-EY1_CZ_R);
    COVXY1_DJX_R=COVXY1_DJX_R+(I1(x1(i),y1(i))-EX1_R)*(I1(x1(i)+1,y1(i)+1)-EY1_DJX_R);
   
end
%统一在循环外除以像素点对数1000，可减少运算次数
DX1_R=DX1_R/NN;
DY1_SP_R=DY1_SP_R/NN;
DY1_CZ_R=DY1_CZ_R/NN;
DY1_DJX_R=DY1_DJX_R/NN;
COVXY1_SP_R=COVXY1_SP_R/NN;
COVXY1_CZ_R=COVXY1_CZ_R/NN;
COVXY1_DJX_R=COVXY1_DJX_R/NN;

%水平、垂直、对角线的相关性
RXY1_SP_R=COVXY1_SP_R/sqrt(DX1_R*DY1_SP_R);
RXY1_CZ_R=COVXY1_CZ_R/sqrt(DX1_R*DY1_CZ_R);
RXY1_DJX_R=COVXY1_DJX_R/sqrt(DX1_R*DY1_DJX_R);


%% 加密图像相邻图像相关性分析
P1=imread('F:\Users\Revere\Desktop\ICGSP\cipher.jpg');
[M,N]=size(P1);  
Q_R=P1;

%相关性曲线
%水平
XX_R_SP=zeros(1,1000);YY_R_SP=zeros(1,1000);  %预分配内存

%垂直
XX_R_CZ=zeros(1,1000);YY_R_CZ=zeros(1,1000);  %预分配内存

%对角线
XX_R_DJX=zeros(1,1000);YY_R_DJX=zeros(1,1000);  %预分配内存

for i=1:1000
    %水平
    XX_R_SP(i)=Q_R(x1(i),y1(i));
    YY_R_SP(i)=Q_R(x1(i)+1,y1(i));
   
    %垂直
    XX_R_CZ(i)=Q_R(x1(i),y1(i));
    YY_R_CZ(i)=Q_R(x1(i),y1(i)+1);
    
    %对角线
    XX_R_DJX(i)=Q_R(x1(i),y1(i));
    YY_R_DJX(i)=Q_R(x1(i)+1,y1(i)+1);
    
end
%水平  随机点像素灰度值,与该点相邻水平方向像素灰度值, 加密图像水平相关性曲线
figure;scatter(XX_R_SP,YY_R_SP,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent horizontal direction');title('The horizontal correlation curve of the encrypted image');

%垂直
figure;scatter(XX_R_CZ,YY_R_CZ,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent vertical direction');title('The vertical correlation curve of the encrypted image');

%对角线
figure;scatter(XX_R_DJX,YY_R_DJX,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent diagonal direction');title('The diagonal correlation curve of the encrypted image');

%R通道
Q_R=double(Q_R);
EX2_R=0;EY2_SP_R=0;DX2_R=0;DY2_SP_R=0;COVXY2_SP_R=0;    %水平
EY2_CZ_R=0;DY2_CZ_R=0;COVXY2_CZ_R=0;    %垂直
EY2_DJX_R=0;DY2_DJX_R=0;COVXY2_DJX_R=0;   %对角线

for i=1:NN
    %第一个像素点的E，水平、垂直、对角线时计算得出的第一个像素点的E相同，统一用EX2表示
    EX2_R=EX2_R+Q_R(x1(i),y1(i));
    %第二个像素点的E，水平、垂直、对角线的E分别对应EY2_SP、EY2_CZ、EY2_DJX
    %R通道
    EY2_SP_R=EY2_SP_R+Q_R(x1(i),y1(i)+1);
    EY2_CZ_R=EY2_CZ_R+Q_R(x1(i)+1,y1(i));
    EY2_DJX_R=EY2_DJX_R+Q_R(x1(i)+1,y1(i)+1);
end
%统一在循环外除以像素点对数1000，可减少运算次数
%R通道
EX2_R=EX2_R/NN;
EY2_SP_R=EY2_SP_R/NN;
EY2_CZ_R=EY2_CZ_R/NN;
EY2_DJX_R=EY2_DJX_R/NN;

for i=1:NN
    %第一个像素点的D，水平、垂直、对角线时计算得出第一个像素点的D相同，统一用DX2表示
    DX2_R=DX2_R+(Q_R(x1(i),y1(i))-EX2_R)^2;
    %第二个像素点的D，水平、垂直、对角线的D分别对应DY2_SP、DY2_CZ、DY2_DJX
    DY2_SP_R=DY2_SP_R+(Q_R(x1(i),y1(i)+1)-EY2_SP_R)^2;
    DY2_CZ_R=DY2_CZ_R+(Q_R(x1(i)+1,y1(i))-EY2_CZ_R)^2;
    DY2_DJX_R=DY2_DJX_R+(Q_R(x1(i)+1,y1(i)+1)-EY2_DJX_R)^2;
    
    %两个相邻像素点相关函数的计算，水平、垂直、对角线
    COVXY2_SP_R=COVXY2_SP_R+(Q_R(x1(i),y1(i))-EX2_R)*(Q_R(x1(i),y1(i)+1)-EY2_SP_R);
    COVXY2_CZ_R=COVXY2_CZ_R+(Q_R(x1(i),y1(i))-EX2_R)*(Q_R(x1(i)+1,y1(i))-EY2_CZ_R);
    COVXY2_DJX_R=COVXY2_DJX_R+(Q_R(x1(i),y1(i))-EX2_R)*(Q_R(x1(i)+1,y1(i)+1)-EY2_DJX_R);
end
%统一在循环外除以像素点对数1000，可减少运算次数
DX2_R=DX2_R/NN;
DY2_SP_R=DY2_SP_R/NN;
DY2_CZ_R=DY2_CZ_R/NN;
DY2_DJX_R=DY2_DJX_R/NN;
COVXY2_SP_R=COVXY2_SP_R/NN;
COVXY2_CZ_R=COVXY2_CZ_R/NN;
COVXY2_DJX_R=COVXY2_DJX_R/NN;

%水平、垂直、对角线的相关性
RXY2_SP_R=COVXY2_SP_R/sqrt(DX2_R*DY2_SP_R);
RXY2_CZ_R=COVXY2_CZ_R/sqrt(DX2_R*DY2_CZ_R);
RXY2_DJX_R=COVXY2_DJX_R/sqrt(DX2_R*DY2_DJX_R);


disp('相关性：');
disp(['原始图片相关性：','  水平相关性=',num2str(RXY1_SP_R),'    垂直相关性=',num2str(RXY1_CZ_R),'  对角线相关性=',num2str(RXY1_DJX_R)]);
disp(['加密图片相关性：','  水平相关性=',num2str(RXY2_SP_R),'  垂直相关性=',num2str(RXY2_CZ_R),'  对角线相关性=',num2str(RXY2_DJX_R)]);

%noise=psnr(P,P1);

