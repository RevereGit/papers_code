% ��ʧ��ͼ���epiͼ
clc;
clear;
path_dist= 'E:\Database\WorkShop\'; %ʧ��ͼ���ļ�·��

dist_list=dir(path_dist);

 for i=26:length(dist_list) %�ļ���24��ʧ��ȼ�
    %disp(i);
    imgDir=dir([path_dist dist_list(i).name '/*.png']);
 
    for j=1:720
        disp(j);
        for k1=1:length(imgDir)
            img=rgb2gray(imread([path_dist dist_list(i).name '/' imgDir(k1).name]));
            %imshow(img);
             epi_img(k1,:)=img(j,:);
             
        end
         
        imshow(epi_img);
        I=getimage(gcf);
        imwrite(I,['E:\EPI\WorkShop\WorkShop_Nearest_Skip6\',int2str(j),'.png']);
    end
    
 end