function NPCR=mesure_npcr(RG,Sim)
NPCR=0; %%% pour R G B
%C1,I1�ֱ��ʾ���ļ�����ͼ��C2��I2��ʾ��֮ǰ��һ�����ص�����

[lignes,colones]=size(RG);
 WH=colones*lignes;
 
 D=0;
for i=1:lignes
    for j=1:colones
         
       if (RG(i,j)==Sim(i,j))
           D=D;
       else
           D=D+1;
       end
    end
end
D=D/WH;
NPCR=D*100;
 
 % P1=P; ����ͼ                              %NPCR??UACI 
% P1(10,101)=P(10,101)+1;  
% C1=jiami(P1,u,Rowx0,Columnx0); 
% [M,N]=size(P); 
% sum1=sum(sum(logical( (C1-C)+(C-C1) ))); 
% sum2=sum(sum( (C1-C)+(C-C1) )); 
% NPCR=sum1/(M*N) 
% UACI=sum2/(M*N*255)
