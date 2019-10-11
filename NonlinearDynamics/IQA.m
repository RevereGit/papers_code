%% 图像质量评价——均方误差（Mean Square Error,MSE）、峰值信噪比（Peak-Signal to Noise Ratio,PSNR）
clear;clc;
I=imread('F:\Users\Revere\Desktop\NonliearDynamics\LaTeX_DL_468198_220518\fig2/decry-living.png','png');           %读取图像信息
[M,N]=size(I(:,:,1));                      %将图像的行列赋值给M,N
t=4;    %分块大小
M1=0;   %加密时补零的参数，M1=mod(M,t);作为密钥
N1=0;   %加密时补零的参数，N1=mod(N,t);作为密钥
SUM=M*N;
I1=imnoise(I,'salt & pepper',0.5);         %加入10%的椒盐噪声
% imshow(I);
%加入高斯噪声，用于图像质量评价
p=psnr(I,I1);

%% 图像质量评价
YY=imread('F:\Users\Revere\Desktop\NonliearDynamics\LaTeX_DL_468198_220518\fig2\living.png','png');        %读取图像信息
YY=double(YY);
Y1=YY(:,:,1);        %R
Y2=YY(:,:,2);        %G
Y3=YY(:,:,3);        %B
MSE_R=zeros(1,21);MSE_G=zeros(1,21);MSE_B=zeros(1,21);
j=0;        %数组下标
for i=0:5:100

    I1=I(:,:,1);     %R通道
    I2=I(:,:,2);     %G通道
    I3=I(:,:,3);     %B通道
    j=j+1;      %数组下标

  
    [MM,NN]=size(Q1);     %重新获得解密后的图片大小
    for m=1:MM
        for n=1:NN
            MSE_R(j)=MSE_R(j)+(Y1(m,n)-Q1(m,n))^2;       %R通道MSE
            MSE_G(j)=MSE_G(j)+(Y2(m,n)-Q2(m,n))^2;       %G通道MSE
            MSE_B(j)=MSE_B(j)+(Y3(m,n)-Q3(m,n))^2;       %B通道MSE
        end
    end
        RESULT(:,:,1)=uint8(Q_R);
        RESULT(:,:,2)=uint8(Q_G);
        RESULT(:,:,3)=uint8(Q_B);
      
%     figure;imshow(RESULT);title(['高斯噪声方差为',num2str(i),'时的解密图像']);
end
figure;imshow(RESULT);title(['高斯噪声方差为',num2str(i),'时的解密图像']);
%噪声功率-MSE
MSE_R=MSE_R./SUM;
MSE_G=MSE_G./SUM;
MSE_B=MSE_B./SUM;
%峰值信噪比-PSNR
PSNR_R=10*log10((255^2)./MSE_R);
PSNR_G=10*log10((255^2)./MSE_G);
PSNR_B=10*log10((255^2)./MSE_B);
%% 绘图，噪声功率-MSE、峰值信噪比-PSNR
X=0:5:100;
figure;plot(X,MSE_R);set(gca,'xtick', X);xlabel('高斯噪声方差');ylabel('均方误差MSE');title('R通道：高斯噪声方差-均方误差MSE曲线图');
figure;plot(X,MSE_G);set(gca,'xtick', X);xlabel('高斯噪声方差');ylabel('均方误差MSE');title('G通道：高斯噪声方差-均方误差MSE曲线图');
figure;plot(X,MSE_B);set(gca,'xtick', X);xlabel('高斯噪声方差');ylabel('均方误差MSE');title('B通道：高斯噪声方差-均方误差MSE曲线图');
figure;plot(X,PSNR_R);set(gca,'xtick', X);xlabel('高斯噪声方差');ylabel('峰值信噪比PSNR（dB）');title('R通道：高斯噪声方差-峰值信噪比PSNR曲线图');
figure;plot(X,PSNR_G);set(gca,'xtick', X);xlabel('高斯噪声方差');ylabel('峰值信噪比PSNR（dB）');title('G通道：高斯噪声方差-峰值信噪比PSNR曲线图');
figure;plot(X,PSNR_B);set(gca,'xtick', X);xlabel('高斯噪声方差');ylabel('峰值信噪比PSNR（dB）');title('B通道：高斯噪声方差-峰值信噪比PSNR曲线图');