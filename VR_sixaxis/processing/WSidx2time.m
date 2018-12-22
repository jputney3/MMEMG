function [ wingTime] = WSidx2time( fileName )

% function [ wingTime] = WSidx2time( fileName )

%takes the time period indices (idxi) and converts them to time values

%fileName = the adjusted Moth_FT_date_num.mat file from the Torque_Code
%folder

% wingTime = takes the indices and converts them to real time units in
% seconds (s).

% This code distributed under GNL GPU license.

load(fileName)
time = torque_data(:,1);
k = 1;
while k <= length(idxi)
    wingTime(k) = 1000*(time(idxi(k))+20);%defines the wing time as the time associated with the index marked from the torque code. 
    k = k + 1;
end
wingTime = wingTime';
newName = strcat('wingTime',fileName(end-16:end-4),'.mat');
save(newName,'wingTime')
end

