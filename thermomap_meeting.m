%
% 

function temperature = thermomap_meeting(IM,lefttopXY,rightbottomXY,Coordinates)
  figure;imagesc(IM);
  h = imrect;
  position = wait(h);
  MAP = IM(position(2):position(2)+position(4),position(1):position(1)+position(3));
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
  print('-dpng','AAA2');
%  figure;plot(temperature);title('temperature');
Xti = 0:200:10000;
  figure;plot(temperature_med);title('temperature with median filter'); ...
  grid on;    
   set(gca,'Xtick',Xti);
   print('-dpng','AAA1');
%  csvwrite('temp_timecourse.csv',temperature);