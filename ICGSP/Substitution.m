%%%����Է���
%% ԭʼͼ��������������Է���
%{
�������0~M-1�к�0~N-1��ѡ��1000�����ص㣬
����ˮƽ�����ʱ��ѡ��ÿ��������ڵ��ұߵĵ㣻
���㴹ֱ�����ʱ��ѡ��ÿ��������ڵ��·��ĵ㣻
����Խ��������ʱ��ѡ��ÿ��������ڵ����·��ĵ㡣
%}
P=rgb2gray(imread('E:\Database\ALL_REF\Cobblestone\Frame_000.png'));
[M,N]=size(P);  
I1=P;

NN=1000;    %���ȡ1000�����ص�
x1=ceil(rand(1,NN)*(M-1));      %����1000��1~M-1�����������Ϊ��
y1=ceil(rand(1,NN)*(N-1));      %����1000��1~N-1�����������Ϊ��
%Ԥ�����ڴ�
XX_R_SP=zeros(1,1000);YY_R_SP=zeros(1,1000);        %ˮƽ
XX_R_CZ=zeros(1,1000);YY_R_CZ=zeros(1,1000);        %��ֱ
XX_R_DJX=zeros(1,1000);YY_R_DJX=zeros(1,1000);      %�Խ���

for i=1:1000
    %ˮƽ
    XX_R_SP(i)=I1(x1(i),y1(i));
    YY_R_SP(i)=I1(x1(i)+1,y1(i));
  
    %��ֱ
    XX_R_CZ(i)=I1(x1(i),y1(i));
    YY_R_CZ(i)=I1(x1(i),y1(i)+1);
   
    %�Խ���
    XX_R_DJX(i)=I1(x1(i),y1(i));
    YY_R_DJX(i)=I1(x1(i)+1,y1(i)+1);
    
end
%ˮƽ ��������ػҶ�ֵ  , ��õ�����ˮƽ�������ػҶ�ֵ,  ԭʼͼ��ˮƽ���������
figure;scatter(XX_R_SP,YY_R_SP,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent horizontal direction');title('The horizontal correlation curve of the plain image');

%��ֱ  ��������ػҶ�ֵ, ��õ����ڴ�ֱ�������ػҶ�ֵ, ԭʼͼ��ֱ���������
figure;scatter(XX_R_CZ,YY_R_CZ,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent vertical direction');title('The vertical correlation curve of the plain image');

%�Խ���  ��������ػҶ�ֵ  , ��õ����ڶԽ��߷������ػҶ�ֵ, ԭʼͼ��Խ������������
figure;scatter(XX_R_DJX,YY_R_DJX,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent diagonal direction');title('The diagonal correlation curve of the plain image');

EX1_R=0;EY1_SP_R=0;DX1_R=0;DY1_SP_R=0;COVXY1_SP_R=0;    %����ˮƽ�����ʱ��Ҫ�ı���
EY1_CZ_R=0;DY1_CZ_R=0;COVXY1_CZ_R=0;                %��ֱ
EY1_DJX_R=0;DY1_DJX_R=0;COVXY1_DJX_R=0;             %�Խ���

I1=double(I1);

for i=1:NN
    %��һ�����ص��E��ˮƽ����ֱ���Խ���ʱ����ó��ĵ�һ�����ص��E��ͬ��ͳһ��EX1��ʾ
    EX1_R=EX1_R+I1(x1(i),y1(i)); 

    %�ڶ������ص��E��ˮƽ����ֱ���Խ��ߵ�E�ֱ��ӦEY1_SP��EY1_CZ��EY1_DJX
    EY1_SP_R=EY1_SP_R+I1(x1(i),y1(i)+1);
    EY1_CZ_R=EY1_CZ_R+I1(x1(i)+1,y1(i));
    EY1_DJX_R=EY1_DJX_R+I1(x1(i)+1,y1(i)+1);
   
end
%ͳһ��ѭ����������ص����1000���ɼ����������
EX1_R=EX1_R/NN;
EY1_SP_R=EY1_SP_R/NN;
EY1_CZ_R=EY1_CZ_R/NN;
EY1_DJX_R=EY1_DJX_R/NN;

for i=1:NN
    %��һ�����ص��D��ˮƽ����ֱ���Խ���ʱ����ó���һ�����ص��D��ͬ��ͳһ��DX��ʾ
    DX1_R=DX1_R+(I1(x1(i),y1(i))-EX1_R)^2;
    
    %�ڶ������ص��D��ˮƽ����ֱ���Խ��ߵ�D�ֱ��ӦDY1_SP��DY1_CZ��DY1_DJX
    DY1_SP_R=DY1_SP_R+(I1(x1(i),y1(i)+1)-EY1_SP_R)^2;
    DY1_CZ_R=DY1_CZ_R+(I1(x1(i)+1,y1(i))-EY1_CZ_R)^2;
    DY1_DJX_R=DY1_DJX_R+(I1(x1(i)+1,y1(i)+1)-EY1_DJX_R)^2;
   
    %�����������ص���غ����ļ��㣬ˮƽ����ֱ���Խ���
    COVXY1_SP_R=COVXY1_SP_R+(I1(x1(i),y1(i))-EX1_R)*(I1(x1(i),y1(i)+1)-EY1_SP_R);
    COVXY1_CZ_R=COVXY1_CZ_R+(I1(x1(i),y1(i))-EX1_R)*(I1(x1(i)+1,y1(i))-EY1_CZ_R);
    COVXY1_DJX_R=COVXY1_DJX_R+(I1(x1(i),y1(i))-EX1_R)*(I1(x1(i)+1,y1(i)+1)-EY1_DJX_R);
   
end
%ͳһ��ѭ����������ص����1000���ɼ����������
DX1_R=DX1_R/NN;
DY1_SP_R=DY1_SP_R/NN;
DY1_CZ_R=DY1_CZ_R/NN;
DY1_DJX_R=DY1_DJX_R/NN;
COVXY1_SP_R=COVXY1_SP_R/NN;
COVXY1_CZ_R=COVXY1_CZ_R/NN;
COVXY1_DJX_R=COVXY1_DJX_R/NN;

%ˮƽ����ֱ���Խ��ߵ������
RXY1_SP_R=COVXY1_SP_R/sqrt(DX1_R*DY1_SP_R);
RXY1_CZ_R=COVXY1_CZ_R/sqrt(DX1_R*DY1_CZ_R);
RXY1_DJX_R=COVXY1_DJX_R/sqrt(DX1_R*DY1_DJX_R);


%% ����ͼ������ͼ������Է���
P1=imread('F:\Users\Revere\Desktop\ICGSP\cipher.jpg');
[M,N]=size(P1);  
Q_R=P1;

%���������
%ˮƽ
XX_R_SP=zeros(1,1000);YY_R_SP=zeros(1,1000);  %Ԥ�����ڴ�

%��ֱ
XX_R_CZ=zeros(1,1000);YY_R_CZ=zeros(1,1000);  %Ԥ�����ڴ�

%�Խ���
XX_R_DJX=zeros(1,1000);YY_R_DJX=zeros(1,1000);  %Ԥ�����ڴ�

for i=1:1000
    %ˮƽ
    XX_R_SP(i)=Q_R(x1(i),y1(i));
    YY_R_SP(i)=Q_R(x1(i)+1,y1(i));
   
    %��ֱ
    XX_R_CZ(i)=Q_R(x1(i),y1(i));
    YY_R_CZ(i)=Q_R(x1(i),y1(i)+1);
    
    %�Խ���
    XX_R_DJX(i)=Q_R(x1(i),y1(i));
    YY_R_DJX(i)=Q_R(x1(i)+1,y1(i)+1);
    
end
%ˮƽ  ��������ػҶ�ֵ,��õ�����ˮƽ�������ػҶ�ֵ, ����ͼ��ˮƽ���������
figure;scatter(XX_R_SP,YY_R_SP,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent horizontal direction');title('The horizontal correlation curve of the encrypted image');

%��ֱ
figure;scatter(XX_R_CZ,YY_R_CZ,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent vertical direction');title('The vertical correlation curve of the encrypted image');

%�Խ���
figure;scatter(XX_R_DJX,YY_R_DJX,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent diagonal direction');title('The diagonal correlation curve of the encrypted image');

%Rͨ��
Q_R=double(Q_R);
EX2_R=0;EY2_SP_R=0;DX2_R=0;DY2_SP_R=0;COVXY2_SP_R=0;    %ˮƽ
EY2_CZ_R=0;DY2_CZ_R=0;COVXY2_CZ_R=0;    %��ֱ
EY2_DJX_R=0;DY2_DJX_R=0;COVXY2_DJX_R=0;   %�Խ���

for i=1:NN
    %��һ�����ص��E��ˮƽ����ֱ���Խ���ʱ����ó��ĵ�һ�����ص��E��ͬ��ͳһ��EX2��ʾ
    EX2_R=EX2_R+Q_R(x1(i),y1(i));
    %�ڶ������ص��E��ˮƽ����ֱ���Խ��ߵ�E�ֱ��ӦEY2_SP��EY2_CZ��EY2_DJX
    %Rͨ��
    EY2_SP_R=EY2_SP_R+Q_R(x1(i),y1(i)+1);
    EY2_CZ_R=EY2_CZ_R+Q_R(x1(i)+1,y1(i));
    EY2_DJX_R=EY2_DJX_R+Q_R(x1(i)+1,y1(i)+1);
end
%ͳһ��ѭ����������ص����1000���ɼ����������
%Rͨ��
EX2_R=EX2_R/NN;
EY2_SP_R=EY2_SP_R/NN;
EY2_CZ_R=EY2_CZ_R/NN;
EY2_DJX_R=EY2_DJX_R/NN;

for i=1:NN
    %��һ�����ص��D��ˮƽ����ֱ���Խ���ʱ����ó���һ�����ص��D��ͬ��ͳһ��DX2��ʾ
    DX2_R=DX2_R+(Q_R(x1(i),y1(i))-EX2_R)^2;
    %�ڶ������ص��D��ˮƽ����ֱ���Խ��ߵ�D�ֱ��ӦDY2_SP��DY2_CZ��DY2_DJX
    DY2_SP_R=DY2_SP_R+(Q_R(x1(i),y1(i)+1)-EY2_SP_R)^2;
    DY2_CZ_R=DY2_CZ_R+(Q_R(x1(i)+1,y1(i))-EY2_CZ_R)^2;
    DY2_DJX_R=DY2_DJX_R+(Q_R(x1(i)+1,y1(i)+1)-EY2_DJX_R)^2;
    
    %�����������ص���غ����ļ��㣬ˮƽ����ֱ���Խ���
    COVXY2_SP_R=COVXY2_SP_R+(Q_R(x1(i),y1(i))-EX2_R)*(Q_R(x1(i),y1(i)+1)-EY2_SP_R);
    COVXY2_CZ_R=COVXY2_CZ_R+(Q_R(x1(i),y1(i))-EX2_R)*(Q_R(x1(i)+1,y1(i))-EY2_CZ_R);
    COVXY2_DJX_R=COVXY2_DJX_R+(Q_R(x1(i),y1(i))-EX2_R)*(Q_R(x1(i)+1,y1(i)+1)-EY2_DJX_R);
end
%ͳһ��ѭ����������ص����1000���ɼ����������
DX2_R=DX2_R/NN;
DY2_SP_R=DY2_SP_R/NN;
DY2_CZ_R=DY2_CZ_R/NN;
DY2_DJX_R=DY2_DJX_R/NN;
COVXY2_SP_R=COVXY2_SP_R/NN;
COVXY2_CZ_R=COVXY2_CZ_R/NN;
COVXY2_DJX_R=COVXY2_DJX_R/NN;

%ˮƽ����ֱ���Խ��ߵ������
RXY2_SP_R=COVXY2_SP_R/sqrt(DX2_R*DY2_SP_R);
RXY2_CZ_R=COVXY2_CZ_R/sqrt(DX2_R*DY2_CZ_R);
RXY2_DJX_R=COVXY2_DJX_R/sqrt(DX2_R*DY2_DJX_R);


disp('����ԣ�');
disp(['ԭʼͼƬ����ԣ�','  ˮƽ�����=',num2str(RXY1_SP_R),'    ��ֱ�����=',num2str(RXY1_CZ_R),'  �Խ��������=',num2str(RXY1_DJX_R)]);
disp(['����ͼƬ����ԣ�','  ˮƽ�����=',num2str(RXY2_SP_R),'  ��ֱ�����=',num2str(RXY2_CZ_R),'  �Խ��������=',num2str(RXY2_DJX_R)]);

%noise=psnr(P,P1);

