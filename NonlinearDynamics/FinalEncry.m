clc;
clear;

% path_img='F:\Users\Revere\Desktop\Encryption\paper-LFI-encryption-DNA\ԭʼ�����ܡ�����ͼƬ\encrypt\';
% img_list=dir(path_img);

% for i=1:10
% end
% m=10;
% n=10;
% BigPic = cell(m, n);
% for i = 1 : m * n
%     BigPic{i} = imread(strcat(path_img,'\',files(StartID + i).name));
% end
% 
% BigPic = cell2mat(BigPic);

A=imread('F:\Users\Revere\Desktop\Encryption\paper-LFI-encryption-DNA\ԭʼ�����ܡ�����ͼƬ\Final_encry\8.png');
B=imread('F:\Users\Revere\Desktop\Encryption\paper-LFI-encryption-DNA\ԭʼ�����ܡ�����ͼƬ\Final_encry\r10.png');

C=cat(1,A,B);
% imshow(C);
imwrite(C,['F:\Users\Revere\Desktop\Encryption\paper-LFI-encryption-DNA\ԭʼ�����ܡ�����ͼƬ\Final_encry\FinEncr.png']);