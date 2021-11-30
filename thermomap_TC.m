% temperature = thermomap_TC(IM,lefttopXY,rightbottomXY,Coordinates,Coorditime)
% 

function [Timestamp temperature_med] = thermomap_TC(IM,lefttopXY,rightbottomXY, ...
                                    Coordinates,CoordiTime,FILE,Calib)
%function temperature = thermomap_TC(IM,lefttopXY,rightbottomXY,Coordinates,CoordiTime,FILE)
  [g size_CT] = size(CoordiTime);
  for j = 1:size_CT
    Hour = CoordiTime(1,j);
    Minute = CoordiTime(2,j);
    Second = CoordiTime(3,j);
    Timestamp_(j) = Second + (60*Minute) + (3600*Hour);
    Timestamp(j) = Timestamp_(j) - Timestamp_(1);
  end

  figure;imagesc(IM);
  h = imrect;
  position = wait(h);
  MAP = IM(position(2):(position(2)+position(4)),position(1): ...
           (position(1)+position(3)));
  MAP = MAP - Calib; % calibration
  MAP_med = medfilt1(MAP,10);
  
  [size_MAP_Y size_MAP_X] = size(MAP);
  HIGHT = lefttopXY(1) - rightbottomXY(1);
  WIDTH = lefttopXY(2) - rightbottomXY(2);
  
  unitX = WIDTH/size_MAP_X;
  unitY = HIGHT/size_MAP_Y;
  
  Coordinates(1,:) = Coordinates(1,:) - rightbottomXY(1);
  Coordinates(2,:) = Coordinates(2,:) - rightbottomXY(2);  
  [g sizeC] = size(Coordinates);
  for i = 1:sizeC
    temperature(i) =  MAP(size_MAP_Y-round(Coordinates(1,i)/unitY), ...
                          size_MAP_X-round(Coordinates(2,i)/unitX));
    temperature_med(i) =  MAP_med(size_MAP_Y-round(Coordinates(1,i)/unitY), size_MAP_X-round(Coordinates(2,i)/unitX));
  end

  figure;imagesc(MAP);colorbar;
  hold on; plot(size_MAP_X-Coordinates(2,:)/unitX, size_MAP_Y-(Coordinates(1,:)/unitY),'w-','linewidth',3);
  hold off;
  FILENAME1 = sprintf('%s/trace_grad.png',FILE);
  print('-dpng',FILENAME1);
%  figure;plot(Timestamp,temperature);title('temperature');
  figure;plot(Timestamp,temperature_med);title(['temperature with ' ...
                      'median filter']);  
  FILENAME2 = sprintf('%s/temp.png',FILE);  
  print('-dpng',FILENAME2);
%  csvwrite('temp_timecourse.csv',temperature);