%����epiͼ�ķ���

clear
clc;
i=imread('E:\EPI\ALL_REF\ArtGallery2\001.png'); %�������ɫͼ��
%i=rgb2gray(i); %ת��Ϊ�Ҷ�ͼ
i=double(i);  %��uint8��ת��Ϊdouble�ͣ������ܼ���ͳ����

% sq1=var(i,0,1); %����������ڶ�������Ϊ0����ʾ���ʽ����������n-1,���Ϊ1����n
% sq2=var(i,0,2); %����������
avg=mean2(i);  %��ͼ���ֵ
[m,n]=size(i);
s=0;
for x=1:m
    for y=1:n 
    s=s+(i(x,y)-avg)^2; %��������������ֵ��ƽ����
    end
end
%��ͼ��ķ���
%a1=var(i(:)); %��һ�ַ��������ú���var���
a1=var(i);
a2=s/(m*n-1); %�ڶ��ַ��������÷��ʽ���
a3=(std2(i))^2; %�����ַ���������std2��ñ�׼���ƽ����Ϊ����

disp(a1);
% disp(a2);
% disp(a3);