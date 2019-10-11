clear;
clc;
a=[0 1,1 0].^5;
I=imread('../原始、加密、解密图片/living.png','png');         %读取图像信息
I1=I(:,:,1);        %R
I2=I(:,:,2);        %G
I3=I(:,:,3);        %B
figure;imshow(I);title('原始图片');
figure;imhist(I1);title('原始图片R通道直方图');
figure;imhist(I2);title('原始图片G通道直方图');
figure;imhist(I3);title('原始图片B通道直方图');
% axis([0 255 0 4000]);
[M,N]=size(I1);                      %将图像的行列赋值给M,N
SUM=M*N;
%% 2.产生Logistic混沌序列
u=3.99;     %Logistic参数μ，自定为3.99
x0=sum(I1(:))/(255*SUM);     %计算得出Logistic初值x0
x0=floor(x0*10^4)/10^4;     %保留4位小数
p=zeros(1,SUM+1000);        %预分配内存
p(1)=x0;
for i=1:SUM+999                 %进行SUM+999次循环，共得到SUM+1000点（包括初值）
    p(i+1)=u*p(i)*(1-p(i));
end
p=p(1001:length(p));            %去除前1000点，获得更好的随机性

%% 3.将p序列变换到0~255范围内整数，转换成M*N的二维矩阵R
p=mod(ceil(p*10^3),256);
R=reshape(p,N,M)';  %转成M行N列的随机矩阵R
imshow(R);













