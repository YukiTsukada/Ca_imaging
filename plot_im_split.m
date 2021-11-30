% plot Ratio vs time 
% according to calculated ratio and timestamp in images
%

function STACK_TIME = plot_im_split(RATIO,FILENAME,N)

for i = 1:N
  FILE = sprintf('%s%03d.tif',FILENAME,i);
  IM_INFO = imfinfo(FILE); % read IM information
  IM_DATE = strrep(IM_INFO.DateTime,':',''); % transform DateTIme
  IM_HOUR = IM_DATE(10:11);
  IM_MIN = IM_DATE(12:13); % extract IM Time in min order
  IM_SEC = IM_DATE(14:17);
  IM_TIME = (str2num(IM_HOUR)*3600) + (str2num(IM_MIN)*60) + ...
            (str2num(IM_SEC));
%  IM_TIME = (str2num(IM_MIN)*60) + (str2num(IM_SEC));
  STACK_TIME(i) = IM_TIME;
  R(i) = RATIO(i).value;
end
  STACK_TIME = sort(STACK_TIME);
% figure;
% subplot(1,3,1);plot(STACK_TIME',R','-');
% subplot(1,3,2);plot(STACK_TIME',R','.');
% subplot(1,3,3);plot(R);

 figure;plot(STACK_TIME',R','-o');
 figure;plot(R);
 