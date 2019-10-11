%数据库中失真图片文件的遍历对比
clear;
clc;

path = 'E:\Database\ArtGallery2\';
file_list = dir(path);

n = 1;
for i=3:length(file_list)
    current_file_path = strcat(path, file_list(i).name);
    current_img_list = dir(current_file_path);
    
    disp(n);
    for j=i+1:length(file_list)
        other_file_path = strcat(path, file_list(j).name);
        other_img_list = dir(other_file_path);
        
        for m=3:length(other_img_list)
            current_img_path = strcat(current_file_path, '\',other_img_list(m).name);
            other_img_path = strcat(other_file_path, '\',other_img_list(m).name);
            
            current_img = rgb2gray(imread(current_img_path));
            other_img = rgb2gray(imread(other_img_path));
     
            result(m-2,1) = ssim(current_img,other_img); % each img

        end

        result(find(result==Inf))=[];  
%         result(isnan(result))=[];

        each_other_file(n,1) = mean(result);
        n = n+1;
        
    end
    
    %each_current_file(i,1) = mean(each_other_file);
    
end