%计算epi图的方差

clear
clc;
i=imread('E:\EPI\ALL_REF\ArtGallery2\001.png'); %载入真彩色图像
%i=rgb2gray(i); %转换为灰度图
i=double(i);  %将uint8型转换为double型，否则不能计算统计量

% sq1=var(i,0,1); %列向量方差，第二个参数为0，表示方差公式分子下面是n-1,如果为1则是n
% sq2=var(i,0,2); %行向量方差
avg=mean2(i);  %求图像均值
[m,n]=size(i);
s=0;
for x=1:m
    for y=1:n 
    s=s+(i(x,y)-avg)^2; %求得所有像素与均值的平方和
    end
end
%求图像的方差
%a1=var(i(:)); %第一种方法：利用函数var求得
a1=var(i);
a2=s/(m*n-1); %第二种方法：利用方差公式求得
a3=(std2(i))^2; %第三种方法：利用std2求得标准差，再平方即为方差

disp(a1);
% disp(a2);
% disp(a3);