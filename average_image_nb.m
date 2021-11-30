%
%

function IM1 = average_image_nb(FILE)
  FILENAME = sprintf('%sbackground/background01.tif',FILE);
  BGALL = imread(FILENAME);
for i = 2:10
  FILENAME = sprintf('%sbackground/background%.2d.tif',FILE,i);
  BG = imread(FILENAME);
  BGALL = BG + BGALL;
end
IM1 = BGALL ./ 10;

