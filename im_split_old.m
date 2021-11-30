%
% split and registrate original image

function IM_RATIO = im_split(IM)
[SIZE_IM_ROW SIZE_IM_COL] = size(IM(1).data);
Margin = 100;
[g size_IM] = size(IM);

WIDTH = round(SIZE_IM_COL/2);
IM_YFP = IM(1).data(:,1:WIDTH);
IM_CFP = IM(1).data(:,WIDTH+1:end);
figure;
subplot(1,2,1);imagesc(IM_YFP);title('yfp');
subplot(1,2,2);imagesc(IM_CFP);title('cfp');

% croping sub-region
%figure;grid on;  %%%%%%%% check
%[sub_YFP rect_YFP] = imcrop(im2bw(IM_YFP,0.07));  %%%%%%%% check
sub_YFP = ones(30,30);
rect_YFP = [100 200 50 50];

sub_YFP = IM_YFP(rect_YFP(2):rect_YFP(2)+rect_YFP(4),rect_YFP(1):rect_YFP(1)+rect_YFP(3));
%sub_CFP = IM_CFP(rect_YFP(2):rect_YFP(2)+rect_YFP(4), ...
%                 rect_YFP(1):rect_YFP(1)+rect_YFP(3));  
sub_CFP = IM_CFP(rect_YFP(2)-20:rect_YFP(2)+rect_YFP(4)+20,rect_YFP(1)-20:rect_YFP(1)+rect_YFP(3)+20);

%  figure;     
%  subplot(1,2,1);imagesc(sub_YFP);title('yfp sub');
%  subplot(1,2,2);imagesc(sub_CFP);title('cfp sub');
  
  %%%%%%% ------------- correlation distribution
  cross_corre = normxcorr2(medfilt1(sub_YFP), medfilt1(sub_CFP));  
%  cross_corre = normxcorr2(sub_YFP,sub_CFP);  
%  figure;surf(cross_corre);shading flat;  %%

  [max_c imax] = max(abs(cross_corre(:)));
  [ypeak xpeak] = ind2sub(size(cross_corre),imax(1));
  corr_offset = [(xpeak-size(sub_YFP,2)) (ypeak-size(sub_YFP,1))];

  xoffset =  3;
  yoffset =  3;
%  xoffset =  corr_offset(1)
%  yoffset =  corr_offset(2)  
%  figure;imagesc(double(IM_YFP)./double(IM_CFP));caxis([0.8 1.7]);title('No registration');
  
%for i = 3
for i = 1:size_IM
  % split the input image into YFP and CFP
  IM_YFP = IM(i).data(:,1:WIDTH);
  IM_CFP = IM(i).data(:,WIDTH+1:end);
%  figure;
%  subplot(1,2,1);imagesc(IM_YFP);title('yfp');
%  subplot(1,2,2);imagesc(IM_CFP);title('cfp');

  [YFP_max YFP_ind] = max(IM_YFP(:));
  [YFP_max_y YFP_max_x] = ind2sub(size(IM_YFP),YFP_ind(1));
  
  %%%%%%% ------------- calculate ratio
  RATIO = zeros(SIZE_IM_ROW+(2*Margin), WIDTH+(2*Margin));
  RATIO_C = zeros(SIZE_IM_ROW+(2*Margin), WIDTH+(2*Margin));
  
  RATIO(Margin+1:Margin+SIZE_IM_ROW,Margin+1:Margin+WIDTH) = IM_YFP;
  RATIO_C(Margin+1+yoffset:Margin+SIZE_IM_ROW+yoffset,Margin+1+ ...
          xoffset:Margin+WIDTH+xoffset) = IM_CFP;  
  RATIO = double(RATIO) ./double(RATIO_C);

%  RATIO = double(RATIO(1:SIZE_IM_ROW, 1:WIDTH)) ./double(IM_CFP);
%  figure;imagesc(RATIO);title('ratio');colorbar;caxis([0.8 1.7]);
  
Neuron_Ycoordinate = YFP_max_y+Margin;
Neuron_Xcoordinate = YFP_max_x+Margin;
hold on; plot(Neuron_Xcoordinate,Neuron_Ycoordinate,'ow');hold off;

  RATIO_VAL = mean(mean(RATIO(Neuron_Ycoordinate-2:Neuron_Ycoordinate+2, ...
                              Neuron_Xcoordinate-2:Neuron_Xcoordinate+2))); ...
%  RATIO_VAL = mean(mean(RATIO(Neuron_Ycoordinate-1:Neuron_Ycoordinate+1, ...
%                              Neuron_Xcoordinate-1:Neuron_Xcoordinate+1))); ...
      
  YFP_VAL = mean(mean(IM_YFP(YFP_max_y-1:YFP_max_y+1, YFP_max_x-1:YFP_max_x+1)));  
  CFP_VAL = mean(mean(IM_CFP(YFP_max_y-1:YFP_max_y+1, YFP_max_x-1: ...
                             YFP_max_x+1)));  
  BG_noise = mean(mean(RATIO(199:201,199:201)));
  SN_R = ((RATIO_VAL - BG_noise)^2 )/(BG_noise^2);
  
  IM_RATIO(i).data = RATIO;
  IM_RATIO(i).value = RATIO_VAL;
  IM_RATIO(i).YFP_value = YFP_VAL;
  IM_RATIO(i).CFP_value = CFP_VAL;  
  IM_RATIO(i).SNR = SN_R;
  IM_RATIO(i).BG_noise = BG_noise;
end
