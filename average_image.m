% IM1 = average_image(FILE)
% make an averaged background image

function IM1 = average_image(FILE)
  FILENAME = sprintf('%sbackground/background01.tif',FILE);
  BGALL = imread(FILENAME);
for i = 2:6
  FILENAME = sprintf('%sbackground/background%.2d.tif',FILE,i);
  BG = imread(FILENAME);
  BGALL = BG + BGALL;
end
IM1 = BGALL ./ 6;

%FILE = sprintf('background3/000001.TIF');
%IM = imread(FILE);
%IM = IM ./100;
%for i = 2:100
%  FILENAME = sprintf('background3/%1.6d.TIF',i);
%  IMM = imread(FILENAME);
%  IMM = IMM./100;
%  IM = IM + IMM;
%end
%


%IM1 = imread(['\\133.6.127.73/yuki-ts/20100730/SAS16/11/' ...
%              '000227.TIF']);
%IM2 = imread(['\\133.6.127.73/yuki-ts/20100730/SAS16/11/' ...
%              '000375.TIF']);
%IM1(:,1:150) = IM2(:,1:150);
%IM1(:,250:400) = IM2(:,250:400);

%MaxM = max(max(IM1));
%MinM = min(min(IM1));
%S = MaxM - MinM;

%IM1 = (IM1 - MinM)/S;
%figure;imagesc(IM1);colorbar;