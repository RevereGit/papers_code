clear;
clc;
a=[0 1,1 0].^5;
I=imread('../ԭʼ�����ܡ�����ͼƬ/living.png','png');         %��ȡͼ����Ϣ
I1=I(:,:,1);        %R
I2=I(:,:,2);        %G
I3=I(:,:,3);        %B
figure;imshow(I);title('ԭʼͼƬ');
figure;imhist(I1);title('ԭʼͼƬRͨ��ֱ��ͼ');
figure;imhist(I2);title('ԭʼͼƬGͨ��ֱ��ͼ');
figure;imhist(I3);title('ԭʼͼƬBͨ��ֱ��ͼ');
% axis([0 255 0 4000]);
[M,N]=size(I1);                      %��ͼ������и�ֵ��M,N
SUM=M*N;
%% 2.����Logistic��������
u=3.99;     %Logistic�����̣��Զ�Ϊ3.99
x0=sum(I1(:))/(255*SUM);     %����ó�Logistic��ֵx0
x0=floor(x0*10^4)/10^4;     %����4λС��
p=zeros(1,SUM+1000);        %Ԥ�����ڴ�
p(1)=x0;
for i=1:SUM+999                 %����SUM+999��ѭ�������õ�SUM+1000�㣨������ֵ��
    p(i+1)=u*p(i)*(1-p(i));
end
p=p(1001:length(p));            %ȥ��ǰ1000�㣬��ø��õ������

%% 3.��p���б任��0~255��Χ��������ת����M*N�Ķ�ά����R
p=mod(ceil(p*10^3),256);
R=reshape(p,N,M)';  %ת��M��N�е��������R
imshow(R);













