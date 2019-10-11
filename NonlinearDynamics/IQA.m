%% ͼ���������ۡ���������Mean Square Error,MSE������ֵ����ȣ�Peak-Signal to Noise Ratio,PSNR��
clear;clc;
I=imread('F:\Users\Revere\Desktop\NonliearDynamics\LaTeX_DL_468198_220518\fig2/decry-living.png','png');           %��ȡͼ����Ϣ
[M,N]=size(I(:,:,1));                      %��ͼ������и�ֵ��M,N
t=4;    %�ֿ��С
M1=0;   %����ʱ����Ĳ�����M1=mod(M,t);��Ϊ��Կ
N1=0;   %����ʱ����Ĳ�����N1=mod(N,t);��Ϊ��Կ
SUM=M*N;
I1=imnoise(I,'salt & pepper',0.5);         %����10%�Ľ�������
% imshow(I);
%�����˹����������ͼ����������
p=psnr(I,I1);

%% ͼ����������
YY=imread('F:\Users\Revere\Desktop\NonliearDynamics\LaTeX_DL_468198_220518\fig2\living.png','png');        %��ȡͼ����Ϣ
YY=double(YY);
Y1=YY(:,:,1);        %R
Y2=YY(:,:,2);        %G
Y3=YY(:,:,3);        %B
MSE_R=zeros(1,21);MSE_G=zeros(1,21);MSE_B=zeros(1,21);
j=0;        %�����±�
for i=0:5:100

    I1=I(:,:,1);     %Rͨ��
    I2=I(:,:,2);     %Gͨ��
    I3=I(:,:,3);     %Bͨ��
    j=j+1;      %�����±�

  
    [MM,NN]=size(Q1);     %���»�ý��ܺ��ͼƬ��С
    for m=1:MM
        for n=1:NN
            MSE_R(j)=MSE_R(j)+(Y1(m,n)-Q1(m,n))^2;       %Rͨ��MSE
            MSE_G(j)=MSE_G(j)+(Y2(m,n)-Q2(m,n))^2;       %Gͨ��MSE
            MSE_B(j)=MSE_B(j)+(Y3(m,n)-Q3(m,n))^2;       %Bͨ��MSE
        end
    end
        RESULT(:,:,1)=uint8(Q_R);
        RESULT(:,:,2)=uint8(Q_G);
        RESULT(:,:,3)=uint8(Q_B);
      
%     figure;imshow(RESULT);title(['��˹��������Ϊ',num2str(i),'ʱ�Ľ���ͼ��']);
end
figure;imshow(RESULT);title(['��˹��������Ϊ',num2str(i),'ʱ�Ľ���ͼ��']);
%��������-MSE
MSE_R=MSE_R./SUM;
MSE_G=MSE_G./SUM;
MSE_B=MSE_B./SUM;
%��ֵ�����-PSNR
PSNR_R=10*log10((255^2)./MSE_R);
PSNR_G=10*log10((255^2)./MSE_G);
PSNR_B=10*log10((255^2)./MSE_B);
%% ��ͼ����������-MSE����ֵ�����-PSNR
X=0:5:100;
figure;plot(X,MSE_R);set(gca,'xtick', X);xlabel('��˹��������');ylabel('�������MSE');title('Rͨ������˹��������-�������MSE����ͼ');
figure;plot(X,MSE_G);set(gca,'xtick', X);xlabel('��˹��������');ylabel('�������MSE');title('Gͨ������˹��������-�������MSE����ͼ');
figure;plot(X,MSE_B);set(gca,'xtick', X);xlabel('��˹��������');ylabel('�������MSE');title('Bͨ������˹��������-�������MSE����ͼ');
figure;plot(X,PSNR_R);set(gca,'xtick', X);xlabel('��˹��������');ylabel('��ֵ�����PSNR��dB��');title('Rͨ������˹��������-��ֵ�����PSNR����ͼ');
figure;plot(X,PSNR_G);set(gca,'xtick', X);xlabel('��˹��������');ylabel('��ֵ�����PSNR��dB��');title('Gͨ������˹��������-��ֵ�����PSNR����ͼ');
figure;plot(X,PSNR_B);set(gca,'xtick', X);xlabel('��˹��������');ylabel('��ֵ�����PSNR��dB��');title('Bͨ������˹��������-��ֵ�����PSNR����ͼ');