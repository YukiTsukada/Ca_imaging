%　A = backgroundplot('\\133.6.127.73\yuki-ts\20100810\LightCalibrate\1',20)
% bn = for average background image; n = reference image number

function P_p = backgroundplot_meeting(FILE,bn,n)
%function A = backgroundplot(FILE,bn,n)

%FILENAME1 = sprintf('%s/background/01.tif',FILE); *****
FILENAME1 = sprintf('%s/background/background01.tif',FILE); 
BG1 = imread(FILENAME1);
%% making average background image
for j = 2:bn
%  FILENAME2 = sprintf('%s/background/%.2d.tif',FILE,j); *****
  FILENAME2 = sprintf('%s/background/background%.2d.tif',FILE,j);
  BG2 = imread(FILENAME2);
  [RAW COL] = size(BG1);
  WIDTH = COL/2;
  BG1 = (BG1 + BG2);
end
BG = BG1 ./ bn;

for i = 1:n
  FILEIM = sprintf('%s/background/%.6d.tif',FILE,i);
%  FILEIM = sprintf('%s/%.2d.tif',FILE,i);  *****
  IM = imread(FILEIM);
  IM_YFP = IM(:,1:WIDTH);
  IM_CFP = IM(:,WIDTH+1:end);
  
  [YFP_max YFP_ind] = max(IM_YFP(:));
  [CFP_max CFP_ind] = max(IM_CFP(:));
  [Y_c X_c] = ind2sub(size(IM_CFP),CFP_ind(1));
  [Y X] = ind2sub(size(IM_YFP),YFP_ind(1));

  Y_val(i) = mean(mean(IM(Y-2:Y+2,X-2:X+2)));
%  C_val(i) = mean(mean(IM(Y-2:Y+2,WIDTH+X-2:WIDTH+X+2)));
  C_val(i) = mean(mean(IM(Y_c-2:Y_c+2,WIDTH+X_c-2:WIDTH+X_c+2)));
%  figure;imagesc(IM);hold on;plot(X,Y,'ow');
%  plot(X_c+WIDTH,Y_c,'or');

%  plot(X+WIDTH,Y,'or');  
  Y_BG(i) = mean(mean(BG(Y-1:Y+1,X-1:X+1)));
  C_BG(i) = mean(mean(BG(Y-1:Y+1,WIDTH+X-1:WIDTH+X+1)));
end

% hold on;plot(Y_BG,Y_val,'ok');title('YFP');
%% figure;plot(Y_BG,Y_val,'o');title('YFP');
%% figure;plot(C_BG,C_val,'o');title('CFP');
%% figure;plot(Y_BG./C_BG,Y_val./C_val,'o');title('RATIO');
 
 A = [Y_val; C_val; Y_BG; C_BG];
 
 R_p = polyfit(A(3,:) ./ A(4,:), A(1,:) ./ A(2,:), 1);
 Y_p = polyfit(A(3,:), A(1,:), 1);
 C_p = polyfit(A(4,:), A(2,:), 1);

 P_p = [Y_p; C_p; R_p];
% polyval(R_p,background);

%%
%%A = backgroundplot('\\133.6.127.73\yuki-ts\20100810\LightCalibrate\1',3,20);
%%B = backgroundplot('\\133.6.127.73\yuki-ts\20100810\LightCalibrate\2',3,13);
%%C = backgroundplot('\\133.6.127.73\yuki-ts\20100810\LightCalibrate\3',3,14);
%%D = backgroundplot('\\133.6.127.73\yuki-ts\20100810\LightCalibrate\4',3,10);
%%figure;plot(A(3,:)./A(4,:),A(1,:)./(A(2,:)),'bo');hold on;plot(B(3,:)./B(4,:),B(1,:)./B(2,:),'ro');plot(C(3,:)./C(4,:),C(1,:)./C(2,:),'go');plot(D(3,:)./D(4,:),D(1,:)./D(2,:),'co');
%%F = backgroundplot('\\133.6.127.73\yuki-ts\20100811\5',3,19);
%%G = backgroundplot('\\133.6.127.73\yuki-ts\20100811\6',3,15);
%%H = backgroundplot('\\133.6.127.73\yuki-ts\20100811\7',3,16);
%%I = backgroundplot('\\133.6.127.73\yuki-ts\20100811\8',3,11);
%%J = backgroundplot('\\133.6.127.73\yuki-ts\20100811\9',3,17);
%%K = backgroundplot('\\133.6.127.73\yuki-ts\20100811\10',3,20);
%%L = backgroundplot('\\133.6.127.73\yuki-ts\20100811\11',3,17);
%%figure;plot(A(3,:)./A(4,:),A(1,:)./(A(2,:)),'bo');hold on;plot(B(3,:)./B(4,:),B(1,:)./B(2,:),'ro');plot(C(3,:)./C(4,:),C(1,:)./C(2,:),'go');plot(D(3,:)./D(4,:),D(1,:)./D(2,:),'co');
%%plot(F(3,:)./F(4,:),F(1,:)./F(2,:),'bd');
%%plot(G(3,:)./G(4,:),G(1,:)./G(2,:),'rd');
%%plot(H(3,:)./H(4,:),H(1,:)./H(2,:),'gd');
%%plot(I(3,:)./I(4,:),I(1,:)./I(2,:),'cd');
%%plot(J(3,:)./J(4,:),J(1,:)./J(2,:),'b*');
%%plot(K(3,:)./K(4,:),K(1,:)./K(2,:),'r*');
%%plot(L(3,:)./L(4,:),L(1,:)./L(2,:),'g*');
