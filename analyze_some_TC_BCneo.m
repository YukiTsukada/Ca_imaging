% analyze_some_TC(FILE,Num,P_p)
% P_p = light field correction value

function [RATIO RRR RRR_med Y_Correct C_Correct Timestamp temperature_med ...
         Time_Point] = analyze_some_TC_BCneo(FILE,Num,P_p,Calib,calY,calX)
%function RATIO = analyze_some_TC_BCneo(FILE,Num,P_p)
Y_p = P_p(1,:); C_p = P_p(2,:); R_p = P_p(3,:);
FILE_C = sprintf('%sCoordinates',FILE)
load(FILE_C);
FILE_CT = sprintf('%sCoordiTime',FILE)
load(FILE_CT);
RATIO = im_split_ontime(FILE,Num,calY,calX);

for i = 2:Num  
  R(i) = RATIO(i).value;
  C(i) = RATIO(i).CFP_value;
  Y(i) = RATIO(i).YFP_value;
  BY(i) = RATIO(i).BGY; %  background YFP
  BC(i) = RATIO(i).BGC; %  background CFP
  Time_Point(i) = RATIO(i).Time_Point;
end

  BY_med = medfilt1(BY,15);
  BC_med = medfilt1(BC,15);  
  figure;subplot(2,1,1);plot(Time_Point(2:end),BY(2:end));xlabel('seconds');
  hold on;plot(Time_Point(2:end),BY_med(2:end),'r');xlabel('seconds');
  title('Background YFP');
  subplot(2,1,2);plot(Time_Point(2:end),BC(2:end));xlabel('seconds');
  hold on;plot(Time_Point(2:end),BC_med(2:end),'r');xlabel('seconds');
  title('Background CFP');
  BR = BY./BC;BR_med = medfilt1(BR,15);
  figure;plot(Time_Point(2:end),BR(2:end));xlabel('seconds');
  hold on;plot(Time_Point(2:end),BR_med(2:end),'r');xlabel('seconds');hold off;
  title('Background RATIO');

  R_Back = polyval(R_p,BY./BC); %  estimated RATIO
  R_Correct = R - R_Back;
  Y_Back = polyval(Y_p,BY); %  estimated background YFP
  [MaxC_y MaxI_y] = max(BY);
  Shift_y = Y_Back(MaxI_y) - MaxC_y;
  Y_Correct = Y - (Y_Back - Shift_y);
% Y_Correct = Y - BY;  % correct backtround by just subtracting agar illmination
  C_Back = polyval(C_p,BC); %  estimated background CFP
  [MaxC_c MaxI_c] = max(BC);
  Shift_c = C_Back(MaxI_c) - MaxC_c;
  C_Correct = C - (C_Back - Shift_c);
% C_Correct = C; - BC;  % correct backtround by just subtracting agar illmination

  Y_Back_med = medfilt1(Y_Back,15);
  C_Back_med = medfilt1(C_Back,15);
  figure;subplot(2,1,1);plot(Time_Point(2:end),Y_Back(2:end));xlabel('seconds');
  hold on;plot(Time_Point(2:end),Y_Back_med(2:end),'r');xlabel('seconds');
  title('Background related YFP');
  subplot(2,1,2);plot(Time_Point(2:end),C_Back(2:end));xlabel('seconds');
  hold on;plot(Time_Point(2:end),C_Back_med(2:end),'r');xlabel('seconds');
  title('Background related CFP');
  figure;plot(Time_Point(2:end),R_Back(2:end));xlabel('seconds');
  title('Background related Ratio');

C_med = medfilt1(C,15);
Y_med = medfilt1(Y,15);
RR_med = medfilt1(R,15);
R_med = Y_med ./ C_med;

figure;plot(Time_Point(2:end),R(2:end));xlabel('seconds');
title('Ratio and Ratio medfilt');hold on;
plot(Time_Point(2:end),R_med(2:end),'r','LineWidth',2);xlabel('seconds');
Max_R_med = max(R_med)*1.1;
Min_R_med = min(R_med(R_med~=0))*0.9;
AX3 = axis; axis([AX3(1) AX3(2) Min_R_med Max_R_med]);
hold off; print('-dpng','Ratio1');
FILE_RATIO = sprintf('%s/RATIO.png',FILE);
print('-dpng',FILE_RATIO);

%figure;plot(Time_Point(2:end),R(2:end),'b');title('Ratio');xlabel('seconds');
%hold on;plot(Time_Point(2:end),R_med(2:end),'r');xlabel('seconds');
%plot(Time_Point(2:end),RR_med(2:end),'g');hold off;xlabel('seconds');
%title(['Ratio, ' 'medY/medC, medR']);print('-dpng','Ratio2');

figure;subplot(2,1,1);plot(Time_Point(2:end),Y(2:end),'b');xlabel('seconds');
hold on;plot(Time_Point(2:end),Y_med(2:end),'r','LineWidth',2);xlabel('seconds');
Max_Y_med = max(Y_med)*1.1;
Min_Y_med = min(Y_med(Y_med~=0))*0.9;
AX = axis; axis([AX(1) AX(2) Min_Y_med Max_Y_med]);
hold off;title('YFP and YFPmed');
subplot(2,1,2);plot(Time_Point(2:end),C(2:end),'b');xlabel('seconds');
hold on;plot(Time_Point(2:end),C_med(2:end),'r','LineWidth',2);xlabel('seconds');
Max_C_med = max(C_med)*1.1;
Min_C_med = min(C_med(C_med~=0))*0.9;
AX2 = axis; axis([AX2(1) AX2(2) Min_C_med Max_C_med]);
title('CFP and CFPmed');print('-dpng','YC2');
FILE_YC = sprintf('%s/YC.png',FILE);
print('-dpng',FILE_YC);

figure;subplot(2,1,1);plot(Time_Point(2:end),Y_Correct(2:end));xlabel('seconds');
title('Background corrected YFP');
subplot(2,1,2);plot(Time_Point(2:end),C_Correct(2:end));xlabel('seconds');
title('Background corrected CFP');
RRR = Y_Correct./C_Correct;
RRR_med = medfilt1(RRR,15);
RRR_med_min = min(RRR_med(100:Num-100));
delta_Ratio = RRR_med/RRR_med_min;
figure;plot(Time_Point(2:end),RRR(2:end));xlabel('seconds');
hold on;plot(Time_Point(2:end),RRR_med(2:end),'r','LineWidth',2);xlabel('seconds');
title('Background corrected RATIO');
figure;plot(Time_Point(2:end),R_Correct(2:end));xlabel('seconds');
title('Directly corrected Ratio');


%----------  Analysis with Thermography ----------------
FILE_thermo = sprintf('%sThermo.csv',FILE);
FILE_Left = sprintf('%sLeft',FILE);
FILE_Right = sprintf('%sRight',FILE);
load(FILE_Left); Left = Coordi;
load(FILE_Right); Right = Coordi;
load(FILE_thermo);
[Timestamp temperature_med] = thermomap_TC(Thermo,Left,Right,Coordinates, ...
                           CoordiTime,FILE,Calib);
%----------  Analysis with Position Trace ----------------
[Uni_Time_Point U_index] = unique(Time_Point);
inter_delta_R = interp1(Uni_Time_Point,delta_Ratio(U_index), ...
                        Timestamp);
plot_coordi(Coordinates,inter_delta_R);

%plot_coordi(Coordinates,R);
%plot_coordi(Coordinates,RR_med);
%plot_coordi_avi(Coordinates,RR_med);
%plot_coordi(Coordinates,R_Correct);
print('-dpng','Ratio_coordi');
FILE_PC = sprintf('%s/PC.png',FILE);
print('-dpng',FILE_PC);

%----------  Correlation with Background ----------------
[R P] = corrcoef(BR(2:end),R_Correct(2:end))
[R_Y P_Y] = corrcoef(Y(2:end),BY(2:end))
[R_C P_C] = corrcoef(C(2:end),BC(2:end))
figure;plotyy(Time_Point,delta_Ratio,Timestamp,temperature_med);grid on;
%FILE_variables = sprintf('%svalues',FILE);
%FILE_variables = sprintf('D:/yuki-ts/Data/sum/data');
FILE_variables = sprintf('/Users/yuki/Documents/data');
save(FILE_variables);