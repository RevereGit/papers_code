clear;
clc;
I=rgb2gray(imread('F:\Users\Revere\Desktop\ICDIP\original.jpg')); 

%显示原图与直方图 
%figure;imshow(I);title('原始图片');
% figure;imhist(I);title('The histogram of the plain image');

[M,N]=size(I);                      %将图像的行列赋值给M,N
t=4;    

%% 原始图片信息熵
T1=imhist(I);   %统计图像R通道灰度值从0~255的分布情况，存至T1
S1=sum(T1);     %计算整幅图像R通道的灰度值
xxs1=0;           %原始图片R通道相关性

for i=1:256
    pp1=T1(i)/S1;   %每个灰度值占比，即每个灰度值的概率
    if pp1~=0
        xxs1=xxs1-pp1*log2(pp1);
    end
end

%% 原始图像相邻像素相关性分析
%{
先随机在0~M-1行和0~N-1列选中1000个像素点，
计算水平相关性时，选择每个点的相邻的右边的点；
计算垂直相关性时，选择每个点的相邻的下方的点；
计算对角线相关性时，选择每个点的相邻的右下方的点。
%}
NN=1000;    %随机取1000对像素点
x1=ceil(rand(1,NN)*(M-1));      %生成1000个1~M-1的随机整数作为行
y1=ceil(rand(1,NN)*(N-1));      %生成1000个1~N-1的随机整数作为列
%预分配内存
XX_SP=zeros(1,1000);YY_SP=zeros(1,1000);        %水平
XX_CZ=zeros(1,1000);YY_CZ=zeros(1,1000);        %垂直
XX_DJX=zeros(1,1000);YY_DJX=zeros(1,1000);      %对角线

for i=1:1000
    %水平
    XX_SP(i)=I(x1(i),y1(i));
    YY_SP(i)=I(x1(i)+1,y1(i));
    %垂直
    XX_CZ(i)=I(x1(i),y1(i));
    YY_CZ(i)=I(x1(i),y1(i)+1);
    %对角线
    XX_DJX(i)=I(x1(i),y1(i));
    YY_DJX(i)=I(x1(i)+1,y1(i)+1);
end
%水平 
% figure;scatter(XX_SP,YY_SP,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent horizontal direction');title('The horizontal correlation curve of the plain image');
%垂直  
% figure;scatter(XX_CZ,YY_CZ,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent vertical direction');title('The vertical correlation curve of the plain image');
%对角线  
% figure;scatter(XX_DJX,YY_DJX,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent diagonal direction');title('The diagonal correlation curve of the plain image');

EX1=0;EY1_SP=0;DX1=0;DY1_SP=0;COVXY1_SP=0;    %计算水平相关性时需要的变量
EY1_CZ=0;DY1_CZ=0;COVXY1_CZ=0;                %垂直
EY1_DJX=0;DY1_DJX=0;COVXY1_DJX=0;             %对角线

I1=double(I);
for i=1:NN
    %第一个像素点的E，水平、垂直、对角线时计算得出的第一个像素点的E相同，统一用EX1表示
    EX1=EX1+I1(x1(i),y1(i)); 
    %第二个像素点的E，水平、垂直、对角线的E分别对应EY1_SP、EY1_CZ、EY1_DJX
    EY1_SP=EY1_SP+I1(x1(i),y1(i)+1);
    EY1_CZ=EY1_CZ+I1(x1(i)+1,y1(i));
    EY1_DJX=EY1_DJX+I1(x1(i)+1,y1(i)+1);
end
%统一在循环外除以像素点对数1000，可减少运算次数
EX1=EX1/NN;
EY1_SP=EY1_SP/NN;
EY1_CZ=EY1_CZ/NN;
EY1_DJX=EY1_DJX/NN;

for i=1:NN
    %第一个像素点的D，水平、垂直、对角线时计算得出第一个像素点的D相同，统一用DX表示
    DX1=DX1+(I1(x1(i),y1(i))-EX1)^2;
    %第二个像素点的D，水平、垂直、对角线的D分别对应DY1_SP、DY1_CZ、DY1_DJX
    DY1_SP=DY1_SP+(I1(x1(i),y1(i)+1)-EY1_SP)^2;
    DY1_CZ=DY1_CZ+(I1(x1(i)+1,y1(i))-EY1_CZ)^2;
    DY1_DJX=DY1_DJX+(I1(x1(i)+1,y1(i)+1)-EY1_DJX)^2;
   
    %两个相邻像素点相关函数的计算，水平、垂直、对角线
    COVXY1_SP=COVXY1_SP+(I1(x1(i),y1(i))-EX1)*(I1(x1(i),y1(i)+1)-EY1_SP);
    COVXY1_CZ=COVXY1_CZ+(I1(x1(i),y1(i))-EX1)*(I1(x1(i)+1,y1(i))-EY1_CZ);
    COVXY1_DJX=COVXY1_DJX+(I1(x1(i),y1(i))-EX1)*(I1(x1(i)+1,y1(i)+1)-EY1_DJX);
end

DX1=DX1/NN;
DY1_SP=DY1_SP/NN;
DY1_CZ=DY1_CZ/NN;
DY1_DJX=DY1_DJX/NN;
COVXY1_SP=COVXY1_SP/NN;
COVXY1_CZ=COVXY1_CZ/NN;
COVXY1_DJX=COVXY1_DJX/NN;
%水平、垂直、对角线的相关性
RXY1_SP=COVXY1_SP/sqrt(DX1*DY1_SP);
RXY1_CZ=COVXY1_CZ/sqrt(DX1*DY1_CZ);
RXY1_DJX=COVXY1_DJX/sqrt(DX1*DY1_DJX);

%% 1.补零
%将图像的行列数都补成可以被t整除的数，t为分块的大小。
%分块设置为0，不产生子块
M1=mod(M,t);    
N1=mod(N,t);    
if M1~=0
    I1(M+1:M+t-M1,:)=0;
end
if N1~=0
    I1(:,N+1:N+t-N1)=0;
end
[M,N]=size(I1);  %补零后的行数和列数
SUM=M*N;

%% 2.产生Logistic混沌序列
%利用Logistic映射，产生混沌序列p. 初值X0根据图像计算得出，参数μ设定为3.99

u=3.991000000000000;     %Logistic参数μ，自定为3.99
x0=sum(I1(:))/(255*SUM);     %计算得出Logistic初值x0    
x0=floor(x0*10^4)/10^4;     %保留4位小数   floor函数取整
p=zeros(1,SUM+1000);       
p(1)=x0;
for i=1:SUM+999                 %进行SUM+999次循环，共得到SUM+1000点（包括初值）
    p(i+1)=u*p(i)*(1-p(i));
end
p=p(1001:length(p));            %去除前1000点，获得更好的随机性

%% 3.将p序列变换到0~255范围内整数，转换成M*N的二维矩阵R
p=mod(ceil(p*10^3),256);  %ceil()函数，朝正无穷大方向取整，不小于本身的最小整数
R=reshape(p,N,M)';  %转成M行N列的随机矩阵R    将p按列的顺序，第一列读完读第二列，构成N*M的矩阵

%% 4.求解Chen氏超混沌系统
%求四个初值X0,Y0,Z0,H0
r=(M/t)*(N/t);      %r为分块个数

%求出四个初值
X0=sum(sum(bitand(I1,3)))/(3*SUM);  %chen超混沌初值x0,y0,z0,h0
Y0=sum(sum(bitand(I1,12)/4))/(3*SUM);
Z0=sum(sum(bitand(I1,48)/16))/(3*SUM);
H0=sum(sum(bitand(I1,192)/64))/(3*SUM);

%保留四位小数 
X0=floor(X0*10^4)/10^4;
Y0=floor(Y0*10^4)/10^4;
Z0=floor(Z0*10^4)/10^4;
H0=floor(H0*10^4)/10^4;

%根据初值，求解Chen氏超混沌系统，得到四个混沌序列
A=chen_output(X0,Y0,Z0,H0,r);   
X=A(:,1);
X=X(1502:length(X));        %去除前1501项，获得更好的随机性（求解陈氏系统的子函数多计算了1500点）
Y=A(:,2);
Y=Y(1502:length(Y));
Z=A(:,3);
Z=Z(1502:length(Z));
H=A(:,4);
H=H(1502:length(H));

%% 5.DNA编码
%X,Y分别决定I和R的DNA编码方式，有8种，1~8           I为原图，R为随机矩阵
%Z决定运算方式，有3种，0~2，0表示加，1表示减，2表示异或
%H表示DNA解码方式，有8种，1~8

X=mod(floor(X*10^4),8)+1;
Y=mod(floor(Y*10^4),8)+1;
Z=mod(floor(Z*10^4),3);    % 0,1,2三种
H=mod(floor(H*10^4),8)+1;  %解码方式，8种
e=N/t;  %e表示每一行可以分为多少块   e=N/t=240,

Q2=DNA_bian(fenkuai(t,R,1),Y(1));  %编码方式如采用1，解码方式采用2，编码和解码的方式不同实现加密效果。
Q1=DNA_bian(fenkuai(t,I1,1),X(1));
Q_last_R=DNA_yunsuan(Q1,Q2,Z(1));
Q(1:t,1:t)=DNA_jie(Q_last_R,H(1));

for i=2:r
    Q1=DNA_bian(fenkuai(t,I1,i),X(i));   %对原始图像每一个分块按X对应的序号进行DNA编码
    Q2=DNA_bian(fenkuai(t,R,i),Y(i));   %对每一个分块按Y对应的序号进行DNA编码
    %R通道
    Q3=DNA_yunsuan(Q1,Q2,Z(i));         %对上面两个编码好的块按Z对应的序号进行DNA运算
    Q4=DNA_yunsuan(Q3,Q_last_R,Z(i));     %运算结果在和前一块按Z对应的序号再一次进行运算，称为扩散
    Q_last_R=Q4;

    xx=floor(i/e)+1;
    yy=mod(i,e);
    if yy==0
        xx=xx-1;
        yy=e;
    end
    Q((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4,H(i));    %将每一块合并成完整的图Q

end
Q=uint8(Q);
% figure;imhist(Q);title('The histogram of the encrypted image');
axis([0 255 0 2000]);
Q_jiami(:,:,1)=Q;
figure;imshow(Q_jiami);
imwrite(Q_jiami,'encrypted.jpg');
   %计算npcr和uaci值
% Q_jiamiR=Q_jiami(:,:,1);
npcr=mesure_npcr(I(:,:,1),Q_jiami(:,:,1));   
uaci=mesure_uaci(I(:,:,1),Q_jiami(:,:,1));


%% 加密后信息熵
T2=imhist(Q);
S2=sum(T2);
xxs2=0;

for i=1:256
    pp2=T2(i)/S2;
    if pp2~=0
        xxs2=xxs2-pp2*log2(pp2);
    end
end

%% 加密图像相邻图像相关性分析

%相关性曲线
%水平
XX_SP=zeros(1,1000);YY_SP=zeros(1,1000);  %预分配内存
%垂直
XX_CZ=zeros(1,1000);YY_CZ=zeros(1,1000);  %预分配内存
%对角线
XX_DJX=zeros(1,1000);YY_DJX=zeros(1,1000);  %预分配内存
for i=1:1000
    %水平
    XX_SP(i)=Q(x1(i),y1(i));
    YY_SP(i)=Q(x1(i)+1,y1(i));
    %垂直
    XX_CZ(i)=Q(x1(i),y1(i));
    YY_CZ(i)=Q(x1(i),y1(i)+1);
    %对角线
    XX_DJX(i)=Q(x1(i),y1(i));
    YY_DJX(i)=Q(x1(i)+1,y1(i)+1);
end
%水平 
figure;scatter(XX_SP,YY_SP,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent horizontal direction');title('The horizontal correlation curve of the encrypted image');
%垂直
figure;scatter(XX_CZ,YY_CZ,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent vertical direction');title('The vertical correlation curve of the encrypted image');
%对角线
figure;scatter(XX_DJX,YY_DJX,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent diagonal direction');title('The diagonal correlation curve of the encrypted image');

Q=double(Q);
EX2=0;EY2_SP=0;DX2=0;DY2_SP=0;COVXY2_SP=0;    %水平
EY2_CZ=0;DY2_CZ=0;COVXY2_CZ=0;    %垂直
EY2_DJX=0;DY2_DJX=0;COVXY2_DJX=0;   %对角线

for i=1:NN
    %第一个像素点的E，水平、垂直、对角线时计算得出的第一个像素点的E相同，统一用EX2表示
    EX2=EX2+Q(x1(i),y1(i));
    %第二个像素点的E，水平、垂直、对角线的E分别对应EY2_SP、EY2_CZ、EY2_DJX
    %R通道
    EY2_SP=EY2_SP+Q(x1(i),y1(i)+1);
    EY2_CZ=EY2_CZ+Q(x1(i)+1,y1(i));
    EY2_DJX=EY2_DJX+Q(x1(i)+1,y1(i)+1);
end
%统一在循环外除以像素点对数1000，可减少运算次数
EX2=EX2/NN;
EY2_SP=EY2_SP/NN;
EY2_CZ=EY2_CZ/NN;
EY2_DJX=EY2_DJX/NN;

for i=1:NN
    %第一个像素点的D，水平、垂直、对角线时计算得出第一个像素点的D相同，统一用DX2表示
    DX2=DX2+(Q(x1(i),y1(i))-EX2)^2;

    %第二个像素点的D，水平、垂直、对角线的D分别对应DY2_SP、DY2_CZ、DY2_DJX
    %R通道
    DY2_SP=DY2_SP+(Q(x1(i),y1(i)+1)-EY2_SP)^2;
    DY2_CZ=DY2_CZ+(Q(x1(i)+1,y1(i))-EY2_CZ)^2;
    DY2_DJX=DY2_DJX+(Q(x1(i)+1,y1(i)+1)-EY2_DJX)^2;
    
    %两个相邻像素点相关函数的计算，水平、垂直、对角线
    COVXY2_SP=COVXY2_SP+(Q(x1(i),y1(i))-EX2)*(Q(x1(i),y1(i)+1)-EY2_SP);
    COVXY2_CZ=COVXY2_CZ+(Q(x1(i),y1(i))-EX2)*(Q(x1(i)+1,y1(i))-EY2_CZ);
    COVXY2_DJX=COVXY2_DJX+(Q(x1(i),y1(i))-EX2)*(Q(x1(i)+1,y1(i)+1)-EY2_DJX);
end
%统一在循环外除以像素点对数1000，可减少运算次数
DX2=DX2/NN;
DY2_SP=DY2_SP/NN;
DY2_CZ=DY2_CZ/NN;
DY2_DJX=DY2_DJX/NN;
COVXY2_SP=COVXY2_SP/NN;
COVXY2_CZ=COVXY2_CZ/NN;
COVXY2_DJX=COVXY2_DJX/NN;

%水平、垂直、对角线的相关性
RXY2_SP=COVXY2_SP/sqrt(DX2*DY2_SP);
RXY2_CZ=COVXY2_CZ/sqrt(DX2*DY2_CZ);
RXY2_DJX=COVXY2_DJX/sqrt(DX2*DY2_DJX);

%% 输出数据信息
disp('加密成功');
disp('密钥：');
disp(['密钥1：μ=',num2str(u),'     密钥2：x0=',num2str(x0),'    密钥3：x(0)=',num2str(X0),'    密钥4：y(0)=',num2str(Y0),'   密钥5：z(0)=',num2str(Z0),]);
disp(['密钥6：h(0)=',num2str(H0),'   密钥7：xx0=',num2str(xx0),'   密钥8：xx1=',num2str(xx1)]);
disp('信息熵：');
disp(['原始图片信息熵=',num2str(xxs1)]);
disp(['加密图片信息熵=',num2str(xxs2)]);
disp('相关性：');
disp(['原始图片相关性：','  水平相关性=',num2str(RXY1_SP),'    垂直相关性=',num2str(RXY1_CZ),'  对角线相关性=',num2str(RXY1_DJX)]);
disp(['加密图片相关性：','  水平相关性=',num2str(RXY2_SP),'  垂直相关性=',num2str(RXY2_CZ),'  对角线相关性=',num2str(RXY2_DJX)]);
