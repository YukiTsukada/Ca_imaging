%
% 

function plot_coordi(Coordinate,Ratio)
%Ratio = Ratio(2:end);
size_R = size(Ratio);
Max_R = max(Ratio)
Min_R = min(Ratio)
Medi_R = ((Max_R - Min_R)/2) + Min_R;

Step = (Max_R - Min_R) /63;
Color_R = round((Ratio - Min_R)./ Step )+1;
cmap = colormap;
figure; size(Coordinate);
plot(Coordinate(2,:),Coordinate(1,:),'color',[0.7 0.7 0.7],'linestyle','-');
for i = 1:size_R(2)-1
%for i = 2:size_R(2)  
%hold on;plot(Coordinate(2,2*i),Coordinate(1,2*i),'color', ...
%             cmap(Color_R(i),:),'Marker','o','linewidth',4);
if (isnan(Color_R(i))~=1)
  hold on;plot(Coordinate(2,i),Coordinate(1,i),'color', ...
               cmap(Color_R(i),:),'Marker','o','linewidth',4);
end
end
plot(Coordinate(2,1),Coordinate(1,1),'k+','Markersize',12);
set(gca,'xdir','reverse');
colorbar('Ytick',[1 32 64],'Yticklabel',[Min_R Medi_R Max_R]);
print('-dpng','Ratio_Coordi1');
print('-dpng','AAA4');

%%figure;
%%plot(Coordinate(2,:),Coordinate(1,:),'color',[0.7 0.7 0.7],'linestyle','-');
%%for i = 2:size_R(2)
%%%hold on;plot(Coordinate(2,i),Coordinate(1,i),'color',cmap(Color_R(i),:),'Marker','o');
%%hold on;plot(Coordinate(2,2*i),Coordinate(1,2*i),'color',cmap(Color_R(i),:),'Marker','o');
%%end
%%plot(Coordinate(2,1),Coordinate(1,1),'k+','Markersize',12);
%%set(gca,'xdir','reverse'); axis([-51400 43500 -30800 25900]);
%%colorbar('Ytick',[1 32 64],'Yticklabel',[Min_R Medi_R Max_R]);