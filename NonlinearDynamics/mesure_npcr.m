function NPCR=mesure_npcr(RG,Sim)
NPCR=0; %%% pour R G B
%C1,I1分别表示密文及明文图像，C2，I2表示与之前的一个像素的区别

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
 
 % P1=P; 明文图                              %NPCR??UACI 
% P1(10,101)=P(10,101)+1;  
% C1=jiami(P1,u,Rowx0,Columnx0); 
% [M,N]=size(P); 
% sum1=sum(sum(logical( (C1-C)+(C-C1) ))); 
% sum2=sum(sum( (C1-C)+(C-C1) )); 
% NPCR=sum1/(M*N) 
% UACI=sum2/(M*N*255)
