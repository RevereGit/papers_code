%%像素置换和双随机相位编码加密
P=rgb2gray(imread('E:\Database\ALL_REF\Cobblestone\Frame_000.png'));

% I1=rgb2gray(imread('F:\Users\Revere\Desktop\ICGSP\ICGSP_code\result\original.png'));
% I2=imread('F:\Users\Revere\Desktop\ICGSP\ICGSP_code\result\cipher.jpg');
% uaci=mesure_uaci(I1,I2);
% npcr=mesure_npcr(I1,I2);
%原始图片信息熵 
% T1=imhist(P);   %统计图像灰度值从0~255的分布情况，存至T1
% S1=sum(T1);     %计算整幅图像的灰度值
% xxs=0;           %原始图片相关性
% 
% for i=1:256
%     pp1=T1(i)/S1;   %每个灰度值占比，即每个灰度值的概率
%     if pp1~=0
%         xxs=xxs-pp1*log2(pp1);
%     end
% end

figure;imhist(P); %原始图像直方图
 P = double(P);
[r,c] = size(P);

%
%%%substitution
if (max(P(:))) > 1
    F = 256;
else
    F = 2;
end

C = zeros(r,c);
T = zeros(r,c);

for m = 1:r
            for n = 1:c
                  if n == 1
%                       T(m,n) = mod(P(m,n) + S(m,n)+P(m,c) , F);
                      T(m,n) = mod(P(m,n) +P(m,c) , F);
                  else
%                       T(m,n) = mod(P(m,n) + S(m,n)+T(m,n-1) , F);
                      T(m,n) = mod(P(m,n) +T(m,n-1), F);
                  end
            end
end
         % column substitution
        for n = 1:c
            for m = 1:r
                  if m == 1
                       C(m,n) = mod(T(m,n) + T(r,n), F);
                  else
                      C(m,n) = mod(T(m,n)+C(m-1,n), F);
                  end
            end
        end
 %%% 
imshow(C,[]);
 

% X = C;
% R = C(:, :, 1);
% G = C(:, :, 2);
% B = C(:, :, 3);
% H = length(R(:, 1)); %length函数计算指定矩阵的长度，返回M*N的最大值M或N
% C = [R;G;B];
% figure;

C = im2double(C); %将像素值缩放到0-1之间
%figure;imshow(C,[]);

h = length(C(:, 1));
w = length(C(1, :));
%%
%双随机相位
R1 = exp(i*pi*2*rand(h, w)); % 第一随机相位
R2 = exp(i*pi*2*rand(h, w)); % 第二随机相位
C = fft2(fft2(C.*R1).*R2); % 双随机相位编码

%%%%%%%%%%%%%%逆双随机相位
%   L1 = (ifft2(ifft2(C)./R2))./R1; % 双随机相位编码
%   L2=uint8(L1);
%   figure;imshow(L2);
% imwrite(L2,'10.jpg');
%%%%%%%%%%%%%%%%%%%
figure(1),imshow(abs(C),[]); % 显示加密图

%加入随机噪声，e.g. 4 [0, 4]范围内的均匀分布
C = rubustnoise(C, 0);
figure;imshow(abs(C),[]);
% f=getframe(gcf);
% imwrite(f.cdata,['F:\Users\Revere\Desktop\optical\','1.png']); 

%遮挡 如 2 对应遮挡比例1/2
% C = shelter(C, 2);
% figure(3),imshow(abs(C),[]);


%%%实验分析
%1.直方图

%先归一化0-255
RR=real(C); %取傅里叶变换的实部
II=imag(C); %取傅里叶变换的虚部
A=sqrt(RR.^2+II.^2); %计算频谱幅值
A=(A-min(min(A)))/(max(max(A)))*255;
C1=round(A);
D=uint8(C1);
figure;imshow(D);
% imwrite(D,'5.jpg');
figure;imhist(D); %加密图像直方图

% max_T=max(max(C));
% min_T=min(min(C));
% shift_T=-min_T*255/(max_T-min_T);
% C1=C.*255/(max_T-min_T)+shift_T;

%2.信息熵

%% 加密后信息熵
T2=imhist(D); %密文图像
S2=sum(T2);
xxs2=0;

for i=1:256
    pp2=T2(i)/S2;
    if pp2~=0
        xxs2=xxs2-pp2*log2(pp2);
    end
end

disp('信息熵：');
% disp(['原始图片信息熵=',num2str(xxs),]);
% disp(['加密图片信息熵=',num2str(xxs2),]); %7.0064
