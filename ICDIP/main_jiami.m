clear;
clc;
I=rgb2gray(imread('F:\Users\Revere\Desktop\ICDIP\original.jpg')); 

%��ʾԭͼ��ֱ��ͼ 
%figure;imshow(I);title('ԭʼͼƬ');
% figure;imhist(I);title('The histogram of the plain image');

[M,N]=size(I);                      %��ͼ������и�ֵ��M,N
t=4;    

%% ԭʼͼƬ��Ϣ��
T1=imhist(I);   %ͳ��ͼ��Rͨ���Ҷ�ֵ��0~255�ķֲ����������T1
S1=sum(T1);     %��������ͼ��Rͨ���ĻҶ�ֵ
xxs1=0;           %ԭʼͼƬRͨ�������

for i=1:256
    pp1=T1(i)/S1;   %ÿ���Ҷ�ֵռ�ȣ���ÿ���Ҷ�ֵ�ĸ���
    if pp1~=0
        xxs1=xxs1-pp1*log2(pp1);
    end
end

%% ԭʼͼ��������������Է���
%{
�������0~M-1�к�0~N-1��ѡ��1000�����ص㣬
����ˮƽ�����ʱ��ѡ��ÿ��������ڵ��ұߵĵ㣻
���㴹ֱ�����ʱ��ѡ��ÿ��������ڵ��·��ĵ㣻
����Խ��������ʱ��ѡ��ÿ��������ڵ����·��ĵ㡣
%}
NN=1000;    %���ȡ1000�����ص�
x1=ceil(rand(1,NN)*(M-1));      %����1000��1~M-1�����������Ϊ��
y1=ceil(rand(1,NN)*(N-1));      %����1000��1~N-1�����������Ϊ��
%Ԥ�����ڴ�
XX_SP=zeros(1,1000);YY_SP=zeros(1,1000);        %ˮƽ
XX_CZ=zeros(1,1000);YY_CZ=zeros(1,1000);        %��ֱ
XX_DJX=zeros(1,1000);YY_DJX=zeros(1,1000);      %�Խ���

for i=1:1000
    %ˮƽ
    XX_SP(i)=I(x1(i),y1(i));
    YY_SP(i)=I(x1(i)+1,y1(i));
    %��ֱ
    XX_CZ(i)=I(x1(i),y1(i));
    YY_CZ(i)=I(x1(i),y1(i)+1);
    %�Խ���
    XX_DJX(i)=I(x1(i),y1(i));
    YY_DJX(i)=I(x1(i)+1,y1(i)+1);
end
%ˮƽ 
% figure;scatter(XX_SP,YY_SP,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent horizontal direction');title('The horizontal correlation curve of the plain image');
%��ֱ  
% figure;scatter(XX_CZ,YY_CZ,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent vertical direction');title('The vertical correlation curve of the plain image');
%�Խ���  
% figure;scatter(XX_DJX,YY_DJX,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent diagonal direction');title('The diagonal correlation curve of the plain image');

EX1=0;EY1_SP=0;DX1=0;DY1_SP=0;COVXY1_SP=0;    %����ˮƽ�����ʱ��Ҫ�ı���
EY1_CZ=0;DY1_CZ=0;COVXY1_CZ=0;                %��ֱ
EY1_DJX=0;DY1_DJX=0;COVXY1_DJX=0;             %�Խ���

I1=double(I);
for i=1:NN
    %��һ�����ص��E��ˮƽ����ֱ���Խ���ʱ����ó��ĵ�һ�����ص��E��ͬ��ͳһ��EX1��ʾ
    EX1=EX1+I1(x1(i),y1(i)); 
    %�ڶ������ص��E��ˮƽ����ֱ���Խ��ߵ�E�ֱ��ӦEY1_SP��EY1_CZ��EY1_DJX
    EY1_SP=EY1_SP+I1(x1(i),y1(i)+1);
    EY1_CZ=EY1_CZ+I1(x1(i)+1,y1(i));
    EY1_DJX=EY1_DJX+I1(x1(i)+1,y1(i)+1);
end
%ͳһ��ѭ����������ص����1000���ɼ����������
EX1=EX1/NN;
EY1_SP=EY1_SP/NN;
EY1_CZ=EY1_CZ/NN;
EY1_DJX=EY1_DJX/NN;

for i=1:NN
    %��һ�����ص��D��ˮƽ����ֱ���Խ���ʱ����ó���һ�����ص��D��ͬ��ͳһ��DX��ʾ
    DX1=DX1+(I1(x1(i),y1(i))-EX1)^2;
    %�ڶ������ص��D��ˮƽ����ֱ���Խ��ߵ�D�ֱ��ӦDY1_SP��DY1_CZ��DY1_DJX
    DY1_SP=DY1_SP+(I1(x1(i),y1(i)+1)-EY1_SP)^2;
    DY1_CZ=DY1_CZ+(I1(x1(i)+1,y1(i))-EY1_CZ)^2;
    DY1_DJX=DY1_DJX+(I1(x1(i)+1,y1(i)+1)-EY1_DJX)^2;
   
    %�����������ص���غ����ļ��㣬ˮƽ����ֱ���Խ���
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
%ˮƽ����ֱ���Խ��ߵ������
RXY1_SP=COVXY1_SP/sqrt(DX1*DY1_SP);
RXY1_CZ=COVXY1_CZ/sqrt(DX1*DY1_CZ);
RXY1_DJX=COVXY1_DJX/sqrt(DX1*DY1_DJX);

%% 1.����
%��ͼ��������������ɿ��Ա�t����������tΪ�ֿ�Ĵ�С��
%�ֿ�����Ϊ0���������ӿ�
M1=mod(M,t);    
N1=mod(N,t);    
if M1~=0
    I1(M+1:M+t-M1,:)=0;
end
if N1~=0
    I1(:,N+1:N+t-N1)=0;
end
[M,N]=size(I1);  %����������������
SUM=M*N;

%% 2.����Logistic��������
%����Logisticӳ�䣬������������p. ��ֵX0����ͼ�����ó����������趨Ϊ3.99

u=3.991000000000000;     %Logistic�����̣��Զ�Ϊ3.99
x0=sum(I1(:))/(255*SUM);     %����ó�Logistic��ֵx0    
x0=floor(x0*10^4)/10^4;     %����4λС��   floor����ȡ��
p=zeros(1,SUM+1000);       
p(1)=x0;
for i=1:SUM+999                 %����SUM+999��ѭ�������õ�SUM+1000�㣨������ֵ��
    p(i+1)=u*p(i)*(1-p(i));
end
p=p(1001:length(p));            %ȥ��ǰ1000�㣬��ø��õ������

%% 3.��p���б任��0~255��Χ��������ת����M*N�Ķ�ά����R
p=mod(ceil(p*10^3),256);  %ceil()�����������������ȡ������С�ڱ������С����
R=reshape(p,N,M)';  %ת��M��N�е��������R    ��p���е�˳�򣬵�һ�ж�����ڶ��У�����N*M�ľ���

%% 4.���Chen�ϳ�����ϵͳ
%���ĸ���ֵX0,Y0,Z0,H0
r=(M/t)*(N/t);      %rΪ�ֿ����

%����ĸ���ֵ
X0=sum(sum(bitand(I1,3)))/(3*SUM);  %chen�������ֵx0,y0,z0,h0
Y0=sum(sum(bitand(I1,12)/4))/(3*SUM);
Z0=sum(sum(bitand(I1,48)/16))/(3*SUM);
H0=sum(sum(bitand(I1,192)/64))/(3*SUM);

%������λС�� 
X0=floor(X0*10^4)/10^4;
Y0=floor(Y0*10^4)/10^4;
Z0=floor(Z0*10^4)/10^4;
H0=floor(H0*10^4)/10^4;

%���ݳ�ֵ�����Chen�ϳ�����ϵͳ���õ��ĸ���������
A=chen_output(X0,Y0,Z0,H0,r);   
X=A(:,1);
X=X(1502:length(X));        %ȥ��ǰ1501���ø��õ�����ԣ�������ϵͳ���Ӻ����������1500�㣩
Y=A(:,2);
Y=Y(1502:length(Y));
Z=A(:,3);
Z=Z(1502:length(Z));
H=A(:,4);
H=H(1502:length(H));

%% 5.DNA����
%X,Y�ֱ����I��R��DNA���뷽ʽ����8�֣�1~8           IΪԭͼ��RΪ�������
%Z�������㷽ʽ����3�֣�0~2��0��ʾ�ӣ�1��ʾ����2��ʾ���
%H��ʾDNA���뷽ʽ����8�֣�1~8

X=mod(floor(X*10^4),8)+1;
Y=mod(floor(Y*10^4),8)+1;
Z=mod(floor(Z*10^4),3);    % 0,1,2����
H=mod(floor(H*10^4),8)+1;  %���뷽ʽ��8��
e=N/t;  %e��ʾÿһ�п��Է�Ϊ���ٿ�   e=N/t=240,

Q2=DNA_bian(fenkuai(t,R,1),Y(1));  %���뷽ʽ�����1�����뷽ʽ����2������ͽ���ķ�ʽ��ͬʵ�ּ���Ч����
Q1=DNA_bian(fenkuai(t,I1,1),X(1));
Q_last_R=DNA_yunsuan(Q1,Q2,Z(1));
Q(1:t,1:t)=DNA_jie(Q_last_R,H(1));

for i=2:r
    Q1=DNA_bian(fenkuai(t,I1,i),X(i));   %��ԭʼͼ��ÿһ���ֿ鰴X��Ӧ����Ž���DNA����
    Q2=DNA_bian(fenkuai(t,R,i),Y(i));   %��ÿһ���ֿ鰴Y��Ӧ����Ž���DNA����
    %Rͨ��
    Q3=DNA_yunsuan(Q1,Q2,Z(i));         %��������������õĿ鰴Z��Ӧ����Ž���DNA����
    Q4=DNA_yunsuan(Q3,Q_last_R,Z(i));     %�������ں�ǰһ�鰴Z��Ӧ�������һ�ν������㣬��Ϊ��ɢ
    Q_last_R=Q4;

    xx=floor(i/e)+1;
    yy=mod(i,e);
    if yy==0
        xx=xx-1;
        yy=e;
    end
    Q((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4,H(i));    %��ÿһ��ϲ���������ͼQ

end
Q=uint8(Q);
% figure;imhist(Q);title('The histogram of the encrypted image');
axis([0 255 0 2000]);
Q_jiami(:,:,1)=Q;
figure;imshow(Q_jiami);
imwrite(Q_jiami,'encrypted.jpg');
   %����npcr��uaciֵ
% Q_jiamiR=Q_jiami(:,:,1);
npcr=mesure_npcr(I(:,:,1),Q_jiami(:,:,1));   
uaci=mesure_uaci(I(:,:,1),Q_jiami(:,:,1));


%% ���ܺ���Ϣ��
T2=imhist(Q);
S2=sum(T2);
xxs2=0;

for i=1:256
    pp2=T2(i)/S2;
    if pp2~=0
        xxs2=xxs2-pp2*log2(pp2);
    end
end

%% ����ͼ������ͼ������Է���

%���������
%ˮƽ
XX_SP=zeros(1,1000);YY_SP=zeros(1,1000);  %Ԥ�����ڴ�
%��ֱ
XX_CZ=zeros(1,1000);YY_CZ=zeros(1,1000);  %Ԥ�����ڴ�
%�Խ���
XX_DJX=zeros(1,1000);YY_DJX=zeros(1,1000);  %Ԥ�����ڴ�
for i=1:1000
    %ˮƽ
    XX_SP(i)=Q(x1(i),y1(i));
    YY_SP(i)=Q(x1(i)+1,y1(i));
    %��ֱ
    XX_CZ(i)=Q(x1(i),y1(i));
    YY_CZ(i)=Q(x1(i),y1(i)+1);
    %�Խ���
    XX_DJX(i)=Q(x1(i),y1(i));
    YY_DJX(i)=Q(x1(i)+1,y1(i)+1);
end
%ˮƽ 
figure;scatter(XX_SP,YY_SP,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent horizontal direction');title('The horizontal correlation curve of the encrypted image');
%��ֱ
figure;scatter(XX_CZ,YY_CZ,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent vertical direction');title('The vertical correlation curve of the encrypted image');
%�Խ���
figure;scatter(XX_DJX,YY_DJX,18,'filled');xlabel('The random pixel gray value');ylabel('The pixel gray value in the adjacent diagonal direction');title('The diagonal correlation curve of the encrypted image');

Q=double(Q);
EX2=0;EY2_SP=0;DX2=0;DY2_SP=0;COVXY2_SP=0;    %ˮƽ
EY2_CZ=0;DY2_CZ=0;COVXY2_CZ=0;    %��ֱ
EY2_DJX=0;DY2_DJX=0;COVXY2_DJX=0;   %�Խ���

for i=1:NN
    %��һ�����ص��E��ˮƽ����ֱ���Խ���ʱ����ó��ĵ�һ�����ص��E��ͬ��ͳһ��EX2��ʾ
    EX2=EX2+Q(x1(i),y1(i));
    %�ڶ������ص��E��ˮƽ����ֱ���Խ��ߵ�E�ֱ��ӦEY2_SP��EY2_CZ��EY2_DJX
    %Rͨ��
    EY2_SP=EY2_SP+Q(x1(i),y1(i)+1);
    EY2_CZ=EY2_CZ+Q(x1(i)+1,y1(i));
    EY2_DJX=EY2_DJX+Q(x1(i)+1,y1(i)+1);
end
%ͳһ��ѭ����������ص����1000���ɼ����������
EX2=EX2/NN;
EY2_SP=EY2_SP/NN;
EY2_CZ=EY2_CZ/NN;
EY2_DJX=EY2_DJX/NN;

for i=1:NN
    %��һ�����ص��D��ˮƽ����ֱ���Խ���ʱ����ó���һ�����ص��D��ͬ��ͳһ��DX2��ʾ
    DX2=DX2+(Q(x1(i),y1(i))-EX2)^2;

    %�ڶ������ص��D��ˮƽ����ֱ���Խ��ߵ�D�ֱ��ӦDY2_SP��DY2_CZ��DY2_DJX
    %Rͨ��
    DY2_SP=DY2_SP+(Q(x1(i),y1(i)+1)-EY2_SP)^2;
    DY2_CZ=DY2_CZ+(Q(x1(i)+1,y1(i))-EY2_CZ)^2;
    DY2_DJX=DY2_DJX+(Q(x1(i)+1,y1(i)+1)-EY2_DJX)^2;
    
    %�����������ص���غ����ļ��㣬ˮƽ����ֱ���Խ���
    COVXY2_SP=COVXY2_SP+(Q(x1(i),y1(i))-EX2)*(Q(x1(i),y1(i)+1)-EY2_SP);
    COVXY2_CZ=COVXY2_CZ+(Q(x1(i),y1(i))-EX2)*(Q(x1(i)+1,y1(i))-EY2_CZ);
    COVXY2_DJX=COVXY2_DJX+(Q(x1(i),y1(i))-EX2)*(Q(x1(i)+1,y1(i)+1)-EY2_DJX);
end
%ͳһ��ѭ����������ص����1000���ɼ����������
DX2=DX2/NN;
DY2_SP=DY2_SP/NN;
DY2_CZ=DY2_CZ/NN;
DY2_DJX=DY2_DJX/NN;
COVXY2_SP=COVXY2_SP/NN;
COVXY2_CZ=COVXY2_CZ/NN;
COVXY2_DJX=COVXY2_DJX/NN;

%ˮƽ����ֱ���Խ��ߵ������
RXY2_SP=COVXY2_SP/sqrt(DX2*DY2_SP);
RXY2_CZ=COVXY2_CZ/sqrt(DX2*DY2_CZ);
RXY2_DJX=COVXY2_DJX/sqrt(DX2*DY2_DJX);

%% ���������Ϣ
disp('���ܳɹ�');
disp('��Կ��');
disp(['��Կ1����=',num2str(u),'     ��Կ2��x0=',num2str(x0),'    ��Կ3��x(0)=',num2str(X0),'    ��Կ4��y(0)=',num2str(Y0),'   ��Կ5��z(0)=',num2str(Z0),]);
disp(['��Կ6��h(0)=',num2str(H0),'   ��Կ7��xx0=',num2str(xx0),'   ��Կ8��xx1=',num2str(xx1)]);
disp('��Ϣ�أ�');
disp(['ԭʼͼƬ��Ϣ��=',num2str(xxs1)]);
disp(['����ͼƬ��Ϣ��=',num2str(xxs2)]);
disp('����ԣ�');
disp(['ԭʼͼƬ����ԣ�','  ˮƽ�����=',num2str(RXY1_SP),'    ��ֱ�����=',num2str(RXY1_CZ),'  �Խ��������=',num2str(RXY1_DJX)]);
disp(['����ͼƬ����ԣ�','  ˮƽ�����=',num2str(RXY2_SP),'  ��ֱ�����=',num2str(RXY2_CZ),'  �Խ��������=',num2str(RXY2_DJX)]);
