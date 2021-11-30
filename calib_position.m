% 
% gapX: positive = left
% gapY: positive = down?

function [gapY gapX] = calib_position(FILE_N)
%  FILE_N = sprintf('1/10%1.3d.tif',1);
  IM = imread(FILE_N);
  [sizeIM_Y sizeIM_X] = size(IM);
  figure;  imagesc(IM);
  h_1 = imrect;
  position_1 = wait(h_1);
  r_position_1 = round(position_1);
  h_2 = imrect(gca,position_1);
  position_2 = wait(h_2);
  r_position_2 = round(position_2);
  IM1 = IM(r_position_1(2):r_position_1(2)+r_position_1(4), ...
           r_position_1(1):r_position_1(1)+r_position_1(3));
 
  IM2 = IM(r_position_2(2):r_position_2(2)+r_position_2(4), ...
           r_position_2(1):r_position_2(1)+r_position_2(3));  

  [size_IM1_Y size_IM1_X] = size(IM1);
  [size_IM2_Y size_IM2_X] = size(IM2);  
  
  r_IM1 = reshape(IM1,1,size_IM1_Y*size_IM1_X);
  r_IM2 = reshape(IM2,1,size_IM2_Y*size_IM2_X);

  [IM1maxC IM1maxI] = max(r_IM1);
  [IM2maxC IM2maxI] = max(r_IM2);  
  
  IM1MaxY = mod(IM1maxI,size_IM1_Y);
  IM1MaxX = round(IM1maxI/size_IM1_Y);
  IM2MaxY = mod(IM2maxI,size_IM2_Y);
  IM2MaxX = round(IM2maxI/size_IM2_Y);  
  
  IM1_max_positionX = r_position_1(1)+IM1MaxX;
  IM1_max_positionY = r_position_1(2)+IM1MaxY;
  
  IM2_max_positionX = r_position_2(1)+IM2MaxX;
  IM2_max_positionY = r_position_2(2)+IM2MaxY;
  
  gapX = - (IM2_max_positionX - IM1_max_positionX - (sizeIM_X/2));
  gapY = - (IM2_max_positionY - IM1_max_positionY);
 close;