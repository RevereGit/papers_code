%计算epi图片梯度, ref_dist
% function g_img1=gradient(g1)
clear;
clc;

path_ref = 'E:\EPI_edge\ALL_REF\'; %参考图像文件路径
path_dist = 'E:\EPI_edge\ArtGallery2\'; %各失真图像文件路径

ref_list = dir(path_ref);  %dir函数返回参考文件夹中文件列表
dist_list = dir(path_dist);%返回失真文件夹列表 

for i=3:length(dist_list) % dist_list  24种失真等级
    disp(i);
    dist_path = strcat(path_dist,dist_list(i).name);%连接失真文件中遍历的子文件名 eg：EPI/ArtGallery/ArtGallery_depthinterpoaltion_Skip1
    dist_name = dist_list(i).name(1:11); 
    dist_img_list = dir(dist_path);% 得到失真等级文件下的图片列表信息
    
    spec_path_ref = strcat(path_ref,dist_name,'\');  %参考文件夹  EPI\ALL_REF\ArtGallery2\
    ref_img_list = dir(spec_path_ref);  %相应图片文件
    
    for j=3:length(dist_img_list)  %失真文件下  24个失真等级
        
        dist_full_path = strcat(dist_path,'\',dist_img_list(j).name);
        dist_img = imread(dist_full_path);
        dist_img=double(dist_img);
        
%         dist_img2=edge(dist_img,'canny');
        
        ref_img_path = strcat(spec_path_ref, dist_img_list(j).name);
        ref_img =imread(ref_img_path);
        ref_img=double(ref_img);
        
%         ref_img2=edge(ref_img,'canny');
%         [RX,RY]=gradient(ref_img);  
%         g_r=sqrt(RX.*RX+RY.*RY);
%         
%         [DX,DY]=gradient(dist_img);   
%         g_d=sqrt(DX.*DX+DY.*DY);

%         result(j-2,1) = msssim(ref_img,dist_img);  % each img         
%         result=(sqrt((RX-DX).^2+(RY-DY).^2))./(abs(g_r)+abs(g_d));
%         result=(2*ref_img.*dist_img)./(ref_img.^2+dist_img.^2);
        img=bitand(ref_img,dist_img);
        [h,w]=size(img);
        sum=0;
        for a=1:h
            for b=1:w
                if img(a,b)==255; %逐个点比较
                    sum=sum+1;
                end
            end
        end
        p=double(sum)/(h*w/10);
        result(j-2,1) =p;
    end
    
       result(isnan(result))=[];   %剔除为NaN的数据
       result(find(result==Inf))=[];  %将Inf值的数消除
%        result2(find(result2==1))=[];
       
       m_result(i-2,1)=mean2(result);  %求均值
    
end

