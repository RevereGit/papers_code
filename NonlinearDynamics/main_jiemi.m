%% ���ڻ���ϵͳ��DNA����Ĳ�ɫ����ͼ����ܽ���
clear;clc;
I=imread('F:\Users\Revere\Desktop\NonliearDynamics\LaTeX_DL_468198_220518\fig2\encry-living','png');           %��ȡͼ����Ϣ
imshow(I);
% I=imnoise(I,'salt & pepper',0.005);         %����10%�Ľ�������
I1=I(:,:,1);     %Rͨ��
I2=I(:,:,2);     %Gͨ��
I3=I(:,:,3);     %Bͨ��
[M,N]=size(I1);                      %��ͼ������и�ֵ��M,N
t=4;    %�ֿ��С
M1=0;   %����ʱ����Ĳ�����M1=mod(M,t);��Ϊ��Կ
N1=0;   %����ʱ����Ĳ�����N1=mod(N,t);��Ϊ��Կ
SUM=M*N;
u=3.991;     
xx0=0.5395;
xx1=0.3855;

ppx=zeros(1,M+1000);        %Ԥ�����ڴ�
ppy=zeros(1,N+1000); 
ppx(1)=xx0;
ppy(1)=xx1;
for i=1:M+999                 %����SUM+999��ѭ�������õ�SUM+1000�㣨������ֵ��
    ppx(i+1)=u*ppx(i)*(1-ppx(i));
end
for i=1:N+999                 %����SUM+999��ѭ�������õ�SUM+1000�㣨������ֵ��
    ppy(i+1)=u*ppy(i)*(1-ppy(i));
end
ppx=ppx(1001:length(ppx));            %ȥ��ǰ1000�㣬��ø��õ������
ppy=ppy(1001:length(ppy));

[~,Ux]=sort(ppx,'descend');
[~,Uy]=sort(ppy,'descend');

for i=N:-1:1
    temp = I1(:,i);
    I1(:,i) = I1(:,Uy(i));
    I1(:,Uy(i)) = temp;
    temp = I2(:,i);
    I2(:,i) = I2(:,Uy(i));
    I2(:,Uy(i)) = temp;
    temp = I3(:,i);
    I3(:,i) = I3(:,Uy(i));
    I3(:,Uy(i)) = temp;
end
for i=M:-1:1
    temp = I1(i,:);
    I1(i,:) = I1(Ux(i),:);
    I1(Ux(i),:) = temp;
    temp = I2(i,:);
    I2(i,:) = I2(Ux(i),:);
    I2(Ux(i),:) = temp;
    temp = I3(i,:);
    I3(i,:) = I3(Ux(i),:);
    I3(Ux(i),:) = temp;
end
%% 2.����Logistic��������
% u=3.990000000000001; %��Կ�����Բ���  10^-15
%u=3.99;%��Կ��Logistic������
% x0=0.7067000000000001; %��Կ�����Բ���  10^-16

% x0=0.7067; %��Կ��Logistic��ֵx0
%��Կ�����Բ���  11.03
x0=0.5841;
% x0=0.3462;            %homeͼƬ
p=zeros(1,SUM+1000);
p(1)=x0;
for i=1:SUM+999                        %����N-1��ѭ��
    p(i+1)=u*p(i)*(1-p(i));          %ѭ����������
end
p=p(1001:length(p));

%% 3.��p���б任��0~255��Χ��������ת����M*N�Ķ�ά����R
p=mod(ceil(p*10^3),256);
R=reshape(p,N,M)';  %ת��M��N��

%% 4.�����緽��
%���ĸ���ֵX0,Y0,Z0,H0
r=(M/t)*(N/t);
% X0=0.5008000000000001;        %��Կ�����Բ���
% X0=0.5008;
% Y0=0.5109;
% Z0=0.4893;
% H0=0.7765;
X0=0.5069;        %homeͼƬ
Y0=0.4986;
Z0=0.4939;
H0=0.6132;
A=chen_output(X0,Y0,Z0,H0,r);
X=A(:,1);
X=X(1502:length(X));
Y=A(:,2);
Y=Y(1502:length(Y));
Z=A(:,3);
Z=Z(1502:length(Z));
H=A(:,4);
H=H(1502:length(H));

%% 5.DNA����
%X,Y�ֱ����I��R��DNA���뷽ʽ����8�֣�1~8
X=mod(floor(X*10^4),8)+1;
Y=mod(floor(Y*10^4),8)+1;
Z=mod(floor(Z*10^4),3);
Z(Z==0)=3;
Z(Z==1)=0;
Z(Z==3)=1;
H=mod(floor(H*10^4),8)+1;
e=N/t;
for i=r:-1:2
    Q1_R=DNA_bian(fenkuai(t,I1,i),H(i));
    Q1_G=DNA_bian(fenkuai(t,I2,i),H(i));
    Q1_B=DNA_bian(fenkuai(t,I3,i),H(i));
    
    Q1_last_R=DNA_bian(fenkuai(t,I1,i-1),H(i-1));
    Q1_last_G=DNA_bian(fenkuai(t,I2,i-1),H(i-1));
    Q1_last_B=DNA_bian(fenkuai(t,I3,i-1),H(i-1));
    
    Q2_R=DNA_yunsuan(Q1_R,Q1_last_R,Z(i));        %��ɢǰ
    Q2_G=DNA_yunsuan(Q1_G,Q1_last_G,Z(i));
    Q2_B=DNA_yunsuan(Q1_B,Q1_last_B,Z(i));

    Q3=DNA_bian(fenkuai(t,R,i),Y(i));
    
    Q4_R=DNA_yunsuan(Q2_R,Q3,Z(i));
    Q4_G=DNA_yunsuan(Q2_G,Q3,Z(i));
    Q4_B=DNA_yunsuan(Q2_B,Q3,Z(i));
    
    xx=floor(i/e)+1;
    yy=mod(i,e);
    if yy==0
        xx=xx-1;
        yy=e;
    end
    I1((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4_R,X(i));
    I2((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4_G,X(i));
    I3((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4_B,X(i));
end
Q5_R=DNA_bian(fenkuai(t,I1,1),H(1));
Q5_G=DNA_bian(fenkuai(t,I2,1),H(1));
Q5_B=DNA_bian(fenkuai(t,I3,1),H(1));

Q6=DNA_bian(fenkuai(t,R,1),Y(1));

Q7_R=DNA_yunsuan(Q5_R,Q6,Z(1));
Q7_G=DNA_yunsuan(Q5_G,Q6,Z(1));
Q7_B=DNA_yunsuan(Q5_B,Q6,Z(1));

I1(1:t,1:t)=DNA_jie(Q7_R,X(1));
I2(1:t,1:t)=DNA_jie(Q7_G,X(1));
I3(1:t,1:t)=DNA_jie(Q7_B,X(1));

Q_jiemi(:,:,1)=uint8(I1);
Q_jiemi(:,:,2)=uint8(I2);
Q_jiemi(:,:,3)=uint8(I3);

%% 6��ȥ������ʱ������
if M1~=0
    Q_jiemi=Q_jiemi(1:M-t+M1,:,:);
end
if N1~=0
    Q_jiemi=Q_jiemi(:,1:N-t+N1,:);
end
%�ȽϽ��ܺ��ͼ��ԭͼ�Ƿ���ȫ��ͬ
% II=imread('F:\Users\Revere\Desktop\NonliearDynamics\LaTeX_DL_468198_220518\fig2\living.png','png');
% cha=sum(sum(sum(Q_jiemi-II)));      %����ͼ��������ܺ�
%% ����ͼƬ
imwrite(Q_jiemi,'F:\Users\Revere\Desktop\paper\2�ⳡ����\���ܺ��living.png','png');       
disp('������Ľ�����ԿΪ��');
disp(['��Կ1����=',num2str(u),'     ��Կ2��x0=',num2str(x0),'    ��Կ3��x(0)=',num2str(X0),'    ��Կ4��y(0)=',num2str(Y0),'   ��Կ5��z(0)=',num2str(Z0),]);
disp(['��Կ6��h(0)=',num2str(H0),'   ��Կ7��M1=',num2str(M1),'   ��Կ8��N1=',num2str(N1),'   ��Կ9��xx0=',num2str(xx0),'   ��Կ10��xx1=',num2str(xx1)]);
disp('�������'); 
imshow(Q_jiemi);title('���ܺ�ͼƬ');