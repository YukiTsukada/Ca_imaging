% analyze some without background images
% 

function analyze_some_nb(FILE,Num)

FILE_C = sprintf('%sCoordinates',FILE)
load(FILE_C);
RATIO = im_split_nb(FILE,Num);

for i = 2:Num
  R(i) = RATIO(i).value;
  C(i) = RATIO(i).CFP_value;
  Y(i) = RATIO(i).YFP_value;
end
  
figure;plot(R);title('Ratio');print('-dpng','Ratio1');
%figure;subplot(2,1,1);plot(Y);title('YFP');
%subplot(2,1,2);plot(C,'r');title('CFP');print('-dpng','YC1');

%R_med_C = medfilt1(R_Correct,30);

C_med = medfilt1(C,15);
Y_med = medfilt1(Y,15);
RR_med = medfilt1(R,15);

R_med = Y_med ./ C_med;
%R_med(1:30) = 3;
%R_med(180:191) = 3;

figure;plot(R_med);title('Ratio medfilt');print('-dpng', ...
                                                'Ratio_med');

figure;plot(R,'b');title('Ratio');
hold on;plot(R_med,'r');plot(RR_med,'g');hold off;title('Ratio');print('-dpng','Ratio2');

figure;subplot(2,1,1);plot(Y,'b');
hold on;plot(Y_med,'r');hold off;title('YFP and YFPmed');
subplot(2,1,2);plot(C,'b');
hold on;plot(C_med,'r');title('CFP and CFPmed');print('-dpng','YC2');

plot_coordi(Coordinates,R);
print('-dpng','Ratio_coordi');
save data;

%figure;subplot(2,1,1);plot(BY);title('Background YFP');
%subplot(2,1,2);plot(BC);title('Background CFP');
%BR = BY./BC;
%figure;plot(BR);

%[R P] = corrcoef(BR(2:end),R(2:end))