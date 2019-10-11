% 求失真图像的epi图
clc;
clear;
path_dist= 'E:\Database\WorkShop\'; %失真图像文件路径

dist_list=dir(path_dist);

 for i=26:length(dist_list) %文件夹24个失真等级
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