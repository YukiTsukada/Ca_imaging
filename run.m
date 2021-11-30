% run(FILENAME,Back,images,temp,N) Back= number of background rest
% neuronal image images = number of images temp = calibration for
% temperature diff between thermograph and themometer N = image number
% for calibrating CFP YFP image diff ex.
% run('D:\yuki-ts\Data\2013\20130831\2',72,1175,1.4,32);

function run(FILENAME,Back,images,temp,N)

FILE = sprintf('%s',FILENAME);
FILE_ = sprintf('%s/0000%d.tif',FILENAME,N);
FILE__ = sprintf('%s/',FILENAME);
P_p = backgroundplot(FILE,20,Back);
[gapY gapX] = calib_position(FILE_)
close;pause;
analyze_some_TC_BCneo(FILE__,images,P_p,temp,gapY,gapX);
%analyze_some_meeting(FILE__,Num,P_p)
figure(7);

% figure;plotyy(Time_Point,delta_Ratio,Timestamp,temperature_med);grid on;