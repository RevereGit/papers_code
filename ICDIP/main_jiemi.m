%% 基于混沌系统与DNA编码的彩色数字图像加密解密
clear;clc;
I=imread('F:\Users\Revere\Desktop\ICDIP\encrypted.jpg');           %读取图像信息
I1=I;    

[M,N]=size(I1);                     
t=4;   
M1=0;   
N1=0;   
SUM=M*N;
u=3.991;    
xx0=0.4745;
xx1=0.4745;
ppx=zeros(1,M+1000);        %预分配内存
ppy=zeros(1,N+1000); 
ppx(1)=xx0;
ppy(1)=xx1;
for i=1:M+999                 %进行SUM+999次循环，共得到SUM+1000点（包括初值）
    ppx(i+1)=u*ppx(i)*(1-ppx(i));
end
for i=1:N+999                 %进行SUM+999次循环，共得到SUM+1000点（包括初值）
    ppy(i+1)=u*ppy(i)*(1-ppy(i));
end
ppx=ppx(1001:length(ppx));            %去除前1000点，获得更好的随机性
ppy=ppy(1001:length(ppy));

[~,Ux]=sort(ppx,'descend');
[~,Uy]=sort(ppy,'descend');

for i=N:-1:1
    temp = I1(:,i);
    I1(:,i) = I1(:,Uy(i));
    I1(:,Uy(i)) = temp;

end
for i=M:-1:1
    temp = I1(i,:);
    I1(i,:) = I1(Ux(i),:);
    I1(Ux(i),:) = temp;
end
%% 2.产生Logistic混沌序列
x0=0.4745;
p=zeros(1,SUM+1000);
p(1)=x0;
for i=1:SUM+999                        %进行N-1次循环
    p(i+1)=u*p(i)*(1-p(i));          %循环产生密码
end
p=p(1001:length(p));

%% 3.将p序列变换到0~255范围内整数，转换成M*N的二维矩阵R
p=mod(ceil(p*10^3),256);
R=reshape(p,N,M)';  %转成M行N列

%% 4.求解方程
%求四个初值X0,Y0,Z0,H0
r=(M/t)*(N/t);
X0=0.4995;        %home图片
Y0=0.4998;
Z0=0.4882;
H0=0.4690;
A=chen_output(X0,Y0,Z0,H0,r);
X=A(:,1);
X=X(1502:length(X));
Y=A(:,2);
Y=Y(1502:length(Y));
Z=A(:,3);
Z=Z(1502:length(Z));
H=A(:,4);
H=H(1502:length(H));

%% 5.DNA编码
%X,Y分别决定I和R的DNA编码方式，有8种，1~8
X=mod(floor(X*10^4),8)+1;
Y=mod(floor(Y*10^4),8)+1;
Z=mod(floor(Z*10^4),3);
Z(Z==0)=3;
Z(Z==1)=0;
Z(Z==3)=1;
H=mod(floor(H*10^4),8)+1;
e=N/t;
for i=r:-1:2
    Q1=DNA_bian(fenkuai(t,I1,i),H(i));
    
    Q1_last_R=DNA_bian(fenkuai(t,I1,i-1),H(i-1));
    
    Q2=DNA_yunsuan(Q1,Q1_last_R,Z(i));        %扩散前

    Q3=DNA_bian(fenkuai(t,R,i),Y(i));
    
    Q4=DNA_yunsuan(Q2,Q3,Z(i));
    
    xx=floor(i/e)+1;
    yy=mod(i,e);
    if yy==0
        xx=xx-1;
        yy=e;
    end
    I1((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4,X(i));
end
Q5=DNA_bian(fenkuai(t,I1,1),H(1));
Q6=DNA_bian(fenkuai(t,R,1),Y(1));
Q7=DNA_yunsuan(Q5,Q6,Z(1));

I1(1:t,1:t)=DNA_jie(Q7,X(1));
Q_jiemi=uint8(I1);

%% 6、去除加密时补的零
if M1~=0
    Q_jiemi=Q_jiemi(1:M-t+M1,:,:);
end
if N1~=0
    Q_jiemi=Q_jiemi(:,1:N-t+N1,:);
end
[row,col]=size(Q_jiemi);
a=zeros(row,col);
b=zeros(row,col);
c=zeros(row,col);
a=double(Q_jiemi);
b=double(Q_jiemi);
c=double(Q_jiemi);
rgb=cat(3,a,b,c);
imshow(Q_jiemi);
%% 保存图片
imwrite(Q_jiemi,'F:\Users\Revere\Desktop\ICDIP\decrypted.jpg');       
disp('您输入的解密密钥为：');
disp(['密钥1：μ=',num2str(u),'     密钥2：x0=',num2str(x0),'    密钥3：x(0)=',num2str(X0),'    密钥4：y(0)=',num2str(Y0),'   密钥5：z(0)=',num2str(Z0),]);
disp(['密钥6：h(0)=',num2str(H0),'   密钥7：xx0=',num2str(xx0),'   密钥8：xx1=',num2str(xx1)]);
disp('解密完成'); 
imshow(Q_jiemi);