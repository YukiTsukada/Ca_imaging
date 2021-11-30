% analyze_some(FILE,Num,P_p)
% P_p = 

%function analyze_some(FILE,Num)
function temperature = analyze_some_meeting(FILE,Num,P_p)
Y_p = P_p(1,:); C_p = P_p(2,:); R_p = P_p(3,:);
FILE_C = sprintf('%sCoordinates',FILE)
load(FILE_C);
RATIO = im_split(FILE,Num);

for i = 2:Num  
  R(i) = RATIO(i).value;
  C(i) = RATIO(i).CFP_value;
  Y(i) = RATIO(i).YFP_value;
  BY(i) = RATIO(i).BGY; %  background
  BC(i) = RATIO(i).BGC; %  background
end

  BY_med = medfilt1(BY,15);
  BC_med = medfilt1(BC,15);  
%%  figure;subplot(2,1,1);plot(BY(2:end));hold on;plot(BY_med(2:end),'r');
%%  title('Background YFP');
%%  subplot(2,1,2);plot(BC(2:end));hold on;plot(BC_med(2:end),'r');
%%  title('Background CFP');
%%  BR = BY./BC;BR_med = medfilt1(BR,15);
%%  figure;plot(BR);hold on;plot(BR_med,'r');hold off;
%%  title('Background RATIO');

  R_Back = polyval(R_p,BY./BC); %  background RATIO
  R_Correct = R - R_Back; %  
  Y_Back = polyval(Y_p,BY); %  background YFP
  Y_Correct = Y - Y_Back;
  C_Back = polyval(C_p,BC); %  background CFP
  C_Correct = C - C_Back;  

  Y_Back_med = medfilt1(Y_Back,15);
  C_Back_med = medfilt1(C_Back,15);
%%  figure;subplot(2,1,1);plot(Y_Back(2:end));hold on;plot(Y_Back_med(2:end),'r');
%%  title('Background related YFP');
%%  subplot(2,1,2);plot(C_Back(2:end));hold on;plot(C_Back_med(2:end),'r');
%%  title('Background related CFP');
%%  figure;plot(R_Back);title('Background related Ratio');

C_med = medfilt1(C,15);
Y_med = medfilt1(Y,15);
RR_med = medfilt1(R,15);
R_med = Y_med ./ C_med;

XTi = 0:100:10000;
figure;plot(R);title('Ratio and Ratio medfilt');hold on;
plot(R_med,'r');hold off; print('-dpng','Ratio1');
grid on;
set(gca,'Xtick',XTi);
print('-dpng','AAA3');

%%figure;plot(R,'b');title('Ratio');
%%hold on;plot(R_med,'r');plot(RR_med,'g');hold off;title(['Ratio, ' ...
%%                    'medY/medC, medR']);print('-dpng','Ratio2');

%%figure;subplot(2,1,1);plot(Y(2:end),'b');
%%hold on;plot(Y_med(2:end),'r');hold off;title('YFP and YFPmed');
%%subplot(2,1,2);plot(C(2:end),'b');
%%hold on;plot(C_med(2:end),'r');title('CFP and CFPmed');print('-dpng','YC2');
%%
%%figure;subplot(2,1,1);plot(Y_Correct);title('Background corrected YFP');
%%subplot(2,1,2);plot(C_Correct);title('Background corrected CFP');
%%RRR = Y_Correct./C_Correct;
%%RRR_med = medfilt1(RRR,15);
%%figure;plot(RRR);hold on;plot(RRR_med,'r');title('Background corrected RATIO');
%%figure;plot(R_Correct);title('Directly corrected Ratio');

%----------  Analysis with Position Trace ----------------
%plot_coordi(Coordinates,R);
plot_coordi(Coordinates,RR_med);
%plot_coordi_avi(Coordinates,RR_med);
%plot_coordi(Coordinates,R_Correct);
%%print('-dpng','Ratio_coordi');

%----------  Analysis with Thermography ----------------
FILE_thermo = sprintf('%sThermo.csv',FILE);
FILE_Left = sprintf('%sLeft',FILE);
FILE_Right = sprintf('%sRight',FILE);
load(FILE_Left); Left = Coordi;
load(FILE_Right); Right = Coordi;
load(FILE_thermo);
temperature = thermomap_meeting(Thermo,Left,Right,Coordinates);

%----------  Correlation with Background ----------------
%%[R P] = corrcoef(BR(2:end),R_Correct(2:end))
%%[R_Y P_Y] = corrcoef(Y(2:end),BY(2:end))
%%[R_C P_C] = corrcoef(C(2:end),BC(2:end))

%save data;