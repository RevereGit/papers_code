%����epiͼƬ�ݶ�, ref_dist
% function g_img1=gradient(g1)
clear;
clc;

path_ref = 'E:\EPI_edge\ALL_REF\'; %�ο�ͼ���ļ�·��
path_dist = 'E:\EPI_edge\ArtGallery2\'; %��ʧ��ͼ���ļ�·��

ref_list = dir(path_ref);  %dir�������زο��ļ������ļ��б�
dist_list = dir(path_dist);%����ʧ���ļ����б� 

for i=3:length(dist_list) % dist_list  24��ʧ��ȼ�
    disp(i);
    dist_path = strcat(path_dist,dist_list(i).name);%����ʧ���ļ��б��������ļ��� eg��EPI/ArtGallery/ArtGallery_depthinterpoaltion_Skip1
    dist_name = dist_list(i).name(1:11); 
    dist_img_list = dir(dist_path);% �õ�ʧ��ȼ��ļ��µ�ͼƬ�б���Ϣ
    
    spec_path_ref = strcat(path_ref,dist_name,'\');  %�ο��ļ���  EPI\ALL_REF\ArtGallery2\
    ref_img_list = dir(spec_path_ref);  %��ӦͼƬ�ļ�
    
    for j=3:length(dist_img_list)  %ʧ���ļ���  24��ʧ��ȼ�
        
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
                if img(a,b)==255; %�����Ƚ�
                    sum=sum+1;
                end
            end
        end
        p=double(sum)/(h*w/10);
        result(j-2,1) =p;
    end
    
       result(isnan(result))=[];   %�޳�ΪNaN������
       result(find(result==Inf))=[];  %��Infֵ��������
%        result2(find(result2==1))=[];
       
       m_result(i-2,1)=mean2(result);  %���ֵ
    
end

