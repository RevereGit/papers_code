%数据库中参考与失真文件的遍历对比
clc;
clear;
path_ref = 'E:\Database\ALL_REF\'; %参考图像文件路径
path_dist = 'E:\Database\Workshop\'; %各失真图像文件路径

ref_list = dir(path_ref);  %dir函数返回文件夹中文件列表
dist_list = dir(path_dist);

for i=3:length(dist_list) %REF文件夹中14种参考场景
    disp(i);
    dist_path = strcat(path_dist,dist_list(i).name);%连接参考文件中遍历的子文件名 ArtGallery/ArtGallery_depthinterpoaltion_Skip1
    dist_name = dist_list(i).name(1:8); 
    dist_img_list = dir(dist_path);%1得到失真等级文件下的图片列表信息
    
    spec_path_ref = strcat(path_ref,dist_name,'\'); 
    ref_img_list = dir(spec_path_ref);
    
    for j=3:length(dist_img_list)
        
        dist_full_path = strcat(dist_path,'\',dist_img_list(j).name);
        dist_img = rgb2gray(imread(dist_full_path));
         dist_img=double(dist_img);
         
        
        ref_img_path = strcat(spec_path_ref, dist_img_list(j).name);%'\',
        ref_img = rgb2gray(imread(ref_img_path));
        ref_img=double(ref_img);
                 
%         result(j-2,1) =GMSD(ref_img,dist_img);  % each img
        
        T = 170; 
        Down_step = 2;

        dx=[3 0 -3;10 0 -10;3 0 -3]/16;
        dy=[3 10 3;0 0 0;-3 -10 -3]/16;

        aveKernel = fspecial('average',2);
        aveY1 = conv2(ref_img, aveKernel,'same');
        aveY2 = conv2(dist_img, aveKernel,'same');
        ref_img = aveY1(1:Down_step:end,1:Down_step:end);
        dist_img = aveY2(1:Down_step:end,1:Down_step:end);

        IxY1 = conv2(ref_img, dx, 'same');     
        IyY1 = conv2(ref_img, dy, 'same');    
        gradientMap1 = sqrt(IxY1.^2 + IyY1.^2);

        IxY2 = conv2(dist_img, dx, 'same');     
        IyY2 = conv2(dist_img, dy, 'same');
        gradientMap2 = sqrt(IxY2.^2 + IyY2.^2);

%         quality_map = (2*gradientMap1.*gradientMap2 + T) ./(gradientMap1.^2+gradientMap2.^2 + T);
        % score = std2(quality_map);
          quality_map = (2*gradientMap1.*gradientMap2 + T) ./(gradientMap1.^2+gradientMap2.^2 + T);
          result(j-2,1)=(std2(quality_map)).^2;
        
        
       
    end

    result(find(result==Inf))=[];
%     result(isnan(result))=[];
    
    sun_file(i-2,1) = mean(result); % each sun file
    
    
end