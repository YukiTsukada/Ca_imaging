%
%

function T_ref = Time_reference(IM_Date)

Year = str2num(IM_Date(1:4));
Mon = str2num(IM_Date(5:6));
Day = str2num(IM_Date(7:8));
Hour = str2num(IM_Date(10:11));
Minute = str2num(IM_Date(13:14));
Second = str2num(IM_Date(16:18));

Est_day = datenum(Year,Mon,Day,Hour,Minute,Second);
T_ref = Est_day * 24 * 60 * 60;
