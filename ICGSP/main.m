%%�����û���˫�����λ�������
P=rgb2gray(imread('E:\Database\ALL_REF\Cobblestone\Frame_000.png'));

% I1=rgb2gray(imread('F:\Users\Revere\Desktop\ICGSP\ICGSP_code\result\original.png'));
% I2=imread('F:\Users\Revere\Desktop\ICGSP\ICGSP_code\result\cipher.jpg');
% uaci=mesure_uaci(I1,I2);
% npcr=mesure_npcr(I1,I2);
%ԭʼͼƬ��Ϣ�� 
% T1=imhist(P);   %ͳ��ͼ��Ҷ�ֵ��0~255�ķֲ����������T1
% S1=sum(T1);     %��������ͼ��ĻҶ�ֵ
% xxs=0;           %ԭʼͼƬ�����
% 
% for i=1:256
%     pp1=T1(i)/S1;   %ÿ���Ҷ�ֵռ�ȣ���ÿ���Ҷ�ֵ�ĸ���
%     if pp1~=0
%         xxs=xxs-pp1*log2(pp1);
%     end
% end

figure;imhist(P); %ԭʼͼ��ֱ��ͼ
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
% H = length(R(:, 1)); %length��������ָ������ĳ��ȣ�����M*N�����ֵM��N
% C = [R;G;B];
% figure;

C = im2double(C); %������ֵ���ŵ�0-1֮��
%figure;imshow(C,[]);

h = length(C(:, 1));
w = length(C(1, :));
%%
%˫�����λ
R1 = exp(i*pi*2*rand(h, w)); % ��һ�����λ
R2 = exp(i*pi*2*rand(h, w)); % �ڶ������λ
C = fft2(fft2(C.*R1).*R2); % ˫�����λ����

%%%%%%%%%%%%%%��˫�����λ
%   L1 = (ifft2(ifft2(C)./R2))./R1; % ˫�����λ����
%   L2=uint8(L1);
%   figure;imshow(L2);
% imwrite(L2,'10.jpg');
%%%%%%%%%%%%%%%%%%%
figure(1),imshow(abs(C),[]); % ��ʾ����ͼ

%�������������e.g. 4 [0, 4]��Χ�ڵľ��ȷֲ�
C = rubustnoise(C, 0);
figure;imshow(abs(C),[]);
% f=getframe(gcf);
% imwrite(f.cdata,['F:\Users\Revere\Desktop\optical\','1.png']); 

%�ڵ� �� 2 ��Ӧ�ڵ�����1/2
% C = shelter(C, 2);
% figure(3),imshow(abs(C),[]);


%%%ʵ�����
%1.ֱ��ͼ

%�ȹ�һ��0-255
RR=real(C); %ȡ����Ҷ�任��ʵ��
II=imag(C); %ȡ����Ҷ�任���鲿
A=sqrt(RR.^2+II.^2); %����Ƶ�׷�ֵ
A=(A-min(min(A)))/(max(max(A)))*255;
C1=round(A);
D=uint8(C1);
figure;imshow(D);
% imwrite(D,'5.jpg');
figure;imhist(D); %����ͼ��ֱ��ͼ

% max_T=max(max(C));
% min_T=min(min(C));
% shift_T=-min_T*255/(max_T-min_T);
% C1=C.*255/(max_T-min_T)+shift_T;

%2.��Ϣ��

%% ���ܺ���Ϣ��
T2=imhist(D); %����ͼ��
S2=sum(T2);
xxs2=0;

for i=1:256
    pp2=T2(i)/S2;
    if pp2~=0
        xxs2=xxs2-pp2*log2(pp2);
    end
end

disp('��Ϣ�أ�');
% disp(['ԭʼͼƬ��Ϣ��=',num2str(xxs),]);
% disp(['����ͼƬ��Ϣ��=',num2str(xxs2),]); %7.0064
