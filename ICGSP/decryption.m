%%%%%%%%%%%%%%%%%%%解密
% C=imread('F:\Users\Revere\Desktop\ICGSP\ICGSP_code\1.jpg'); 
% figure;imhist(C); %原始图像直方图

X=rgb2gray(imread('F:\Users\Revere\Desktop\ICDIP\original.jpg'));
Y=imread('F:\Users\Revere\Desktop\ICDIP\decrypted.jpg');
k = 8;
%k为图像是表示地个像素点所用的二进制位数，即位深。
fmax = 2.^k - 1;
a = fmax.^2;
MSE =(double(im2uint8(X)) -double( im2uint8(Y))).^2;
b = mean(mean(MSE));
PSNR = 10*log10(a/b);
result=psnr(X,Y);
%%%%逆置乱
 I = double(C);
[r,c] = size(I);

%%substitution
if (max(I(:))) > 1
    F = 256;
else
    F = 2;
end

C1 = zeros(r,c);
T = zeros(r,c);

         for n = 1:c
            for m = r:-1:1
                  if m == 1
                      T(m,n) = mod(I(m,n)-T(r,n), F);
                  else
                      T(m,n) = mod(I(m,n)-I(m-1,n), F);
                  end
            end
         end
         for m = 1:r
            for n = c:-1:1
                if n == 1
                   C1(m,n) = mod(T(m,n) - C1(m,c), F);
                else
                   C1(m,n) = mod(T(m,n)- T(m,n-1), F);
                end
            end
         end
 figure;imshow(C1);
imwrite(C1,'de.jpg');


%1.逆双随机相位
% h = length(C1(:, 1));
% w = length(C1(1, :));
% R1 = exp(i*pi*2*rand(h, w)); % 第一随机相位
% R2 = exp(i*pi*2*rand(h, w)); % 第二随机相位
% I1 = (ifft2(ifft2(C1)./R2))./R1; % 双随机相位编码
% I2=uint8(I1);
% figure;imshow(I2);

