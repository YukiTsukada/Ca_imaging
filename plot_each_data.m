close all;clear all;

% c1 354, c2 26, c3 354, 1 32, 2 170
% 3 98, 4 123, 5 85, 6 106, 7 77, 8 96, 9 101, 10 101, 11 104, 
% 12 84, 13 88, 14 127
I1 = 354;I2 = 26;I3 = 354;
IT1 = 32;IT2 = 170;IT3 = 98;IT4 = 123; IT5 = 85; IT6 = 106;
IT7 = 77;IT8 = 96; IT9 = 101; IT10 = 101; IT11 = 104;
IT12 = 84; IT13 = 88; IT14 = 127;

%%%%%%------------- continuous1 ----------------
IM = tiffread27('data/continuous1.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/continuous1/',I1);
clear R;clear BG;clear RR;
for i = 1:I1
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('continuous1');
SN_V(1) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
title('AIY exposure 50 ms','FontSize',20);print('-dpng','continuous1');
FILT_SN_V(1) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- continuous2 ----------------
IM = tiffread27('data/continuous2.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/continuous2/',I2);
clear R;clear BG;clear RR;
for i = 1:I2
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('continuous2');
SN_V(2) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 500 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','continuous2');
FILT_SN_V(2) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- continuous3 ----------------
IM = tiffread27('data/continuous3.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/continuous3/',I3);
clear R;clear BG;clear RR;
for i = 1:I3
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('continuous3');
SN_V(3) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 150 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','continuous3');
FILT_SN_V(3) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse1 ----------------
IM = tiffread27('data/time-lapse1.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse1/',IT1);
clear R;clear BG;clear RR;
for i = 1:IT1
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse1');
SN_V(4) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 150 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse1');
FILT_SN_V(4) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse2 ----------------
IM = tiffread27('data/time-lapse2.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse2/',IT2);
clear R;clear BG;clear RR;
for i = 1:IT2
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse2');
SN_V(5) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 50 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse2');
FILT_SN_V(5) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse3 ----------------
IM = tiffread27('data/time-lapse3.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse3/',IT3);
clear R;clear BG;clear RR;
for i = 1:IT3
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse3');
SN_V(6) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 50 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse3');
FILT_SN_V(6) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse4 ----------------
IM = tiffread27('data/time-lapse4.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse4/',IT4);
clear R;clear BG;clear RR;
for i = 1:IT4
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse4');
SN_V(7) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 300 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse4');
FILT_SN_V(7) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse5 ----------------
IM = tiffread27('data/time-lapse5.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse5/',IT5);
clear R;clear BG;clear RR;
for i = 1:IT5
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse5');
SN_V(8) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 100 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse5');
FILT_SN_V(8) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse6 ----------------
IM = tiffread27('data/time-lapse6.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse6/',IT6);
clear R;clear BG;clear RR;
for i = 1:IT6
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse6');
SN_V(9) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 100 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse6');
FILT_SN_V(9) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse7 ----------------
IM = tiffread27('data/time-lapse7.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse7/',IT7);
clear R;clear BG;clear RR;
for i = 1:IT7
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse7');
SN_V(10) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 100 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse7');
FILT_SN_V(10) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse8 ----------------
IM = tiffread27('data/time-lapse8.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse8/',IT8);
clear R;clear BG;clear RR;
for i = 1:IT8
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse8');
SN_V(11) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AIY exposure 150 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse8');
FILT_SN_V(11) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse9 ----------------
IM = tiffread27('data/time-lapse9.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse9/',IT9);
clear R;clear BG;clear RR;
for i = 1:IT9
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse9');
SN_V(12) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AFD exposure 50 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse9');
FILT_SN_V(12) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse10 ----------------
IM = tiffread27('data/time-lapse10.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse10/',IT10);
clear R;clear BG;clear RR;
for i = 1:IT10
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse10');
SN_V(13) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AFD exposure 100 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse10');
FILT_SN_V(13) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse11 ----------------
IM = tiffread27('data/time-lapse11.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse11/',IT11);
clear R;clear BG;clear RR;
for i = 1:IT11
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse11');
SN_V(14) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AFD exposure 150 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse11');
FILT_SN_V(14) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse12 ----------------
IM = tiffread27('data/time-lapse12.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse12/',IT12);
clear R;clear BG;clear RR;
for i = 1:IT12
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse12');
SN_V(15) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AFD exposure 100 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse12');
FILT_SN_V(15) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse13 ----------------
IM = tiffread27('data/time-lapse13.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse13/',IT13);
clear R;clear BG;clear RR;
for i = 1:IT13
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse13');
SN_V(16) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AFD exposure 150 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse13');
FILT_SN_V(16) = var(medfilt1(R,15))/var(RR)
%%%%%%------------- time-lapse14 ----------------
IM = tiffread27('data/time-lapse14.tif');
RATIO = im_split(IM);
STACK_TIME = plot_im_split(RATIO,'photo/time-lapse14/',IT14);
clear R;clear BG;clear RR;
for i = 1:IT14
R(i) = RATIO(i).value;
BG(i) = RATIO(i).BG_noise;
end
disp('time-lapse14');
SN_V(17) = (var(R) - var(BG))/var(BG)
figure;plot(R);hold on;plot(BG,'r');
title('AFD exposure 50 ms','FontSize',20);
RR = R - medfilt1(R,15) +1;hold on;plot(RR,'r');plot(medfilt1(R),'g');hold off;
print('-dpng','time-lapse14');
FILT_SN_V(17) = var(medfilt1(R,15))/var(RR)