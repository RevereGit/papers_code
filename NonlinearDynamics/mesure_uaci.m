function uaci_ratio=mesure_uaci(RG,Sim)
% UACI=0; %%% pour R G B
%C1,I1�ֱ��ʾ���ļ�����ͼ��C2��I2��ʾ��֮ǰ��һ�����ص�����

 [M,N]=size(RG);
pix1=double(RG);
pix2=double(Sim);
pixd=pix1-pix2;
NPCR=nnz(pixd)/(M*N);%NNZ(S) is the number of nonzero elements in S.
counter = 0;
  for i=1:1:M
     for j=1:1:N
       diff = abs(pix1(i,j) - pix2(i,j))/255;
       counter = counter + diff;
    end    
 end
uaci_ratio = counter / (M*N);
NPCR
uaci_ratio
 
 
 
 