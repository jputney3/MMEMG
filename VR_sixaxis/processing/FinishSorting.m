% Script to obtain spike times from Offline Sorter (OFS files):

% This code distributed under GNL GPU license.

% Open OFS files
%% Change the following inputs:
% Experiment date
date = '_08012018_';

% Muscle sorted in open file
muscleName = 'RAx';

%% Comment out/add channels as needed:
% Channel 1
cluster_class = Channel01(:,3);
filename = strcat('times_keep',muscleName,date, '001','.mat');
save(filename,'cluster_class')
% Channel 2
cluster_class = Channel02(:,3);
filename = strcat('times_keep',muscleName,date, '002','.mat');
save(filename,'cluster_class')
% Channel 3
cluster_class = Channel03(:,3);
filename = strcat('times_keep',muscleName,date, '003','.mat');
save(filename,'cluster_class')
% Channel 4
cluster_class = Channel04(:,3);
filename = strcat('times_keep',muscleName,date, '004','.mat');
save(filename,'cluster_class')
% Channel 5
cluster_class = Channel05(:,3);
filename = strcat('times_keep',muscleName,date, '005','.mat');
save(filename,'cluster_class')
% Channel 6
cluster_class = Channel06(:,3);
filename = strcat('times_keep',muscleName,date, '006','.mat');
save(filename,'cluster_class')
% Channel 7
cluster_class = Channel07(:,3);
filename = strcat('times_keep',muscleName,date, '007','.mat');
save(filename,'cluster_class')
% Channel 8
cluster_class = Channel08(:,3);
filename = strcat('times_keep',muscleName,date, '008','.mat');
save(filename,'cluster_class')
% Channel 9
cluster_class = Channel09(:,3);
filename = strcat('times_keep',muscleName,date, '009','.mat');
save(filename,'cluster_class')
% Channel 10
cluster_class = Channel10(:,3);
filename = strcat('times_keep',muscleName,date, '010','.mat');
save(filename,'cluster_class')
% Channel 11
cluster_class = Channel11(:,3);
filename = strcat('times_keep',muscleName,date, '011','.mat');
save(filename,'cluster_class')
% Channel 12
cluster_class = Channel12(:,3);
filename = strcat('times_keep',muscleName,date, '012','.mat');
save(filename,'cluster_class')
% Channel 13
cluster_class = Channel13(:,3);
filename = strcat('times_keep',muscleName,date, '013','.mat');
save(filename,'cluster_class')
% Channel 14
cluster_class = Channel14(:,3);
filename = strcat('times_keep',muscleName,date, '014','.mat');
save(filename,'cluster_class')
% Channel 15
cluster_class = Channel15(:,3);
filename = strcat('times_keep',muscleName,date, '015','.mat');
save(filename,'cluster_class')
% Channel 16
cluster_class = Channel16(:,3);
filename = strcat('times_keep',muscleName,date, '017','.mat');
save(filename,'cluster_class')
% Channel 17
cluster_class = Channel17(:,3);
filename = strcat('times_keep',muscleName,date, '018','.mat');
save(filename,'cluster_class')
% Channel 18
cluster_class = Channel18(:,3);
filename = strcat('times_keep',muscleName,date, '019','.mat');
save(filename,'cluster_class')
% Channel 19
cluster_class = Channel19(:,3);
filename = strcat('times_keep',muscleName,date, '020','.mat');
save(filename,'cluster_class')
% Channel 20
cluster_class = Channel20(:,3);
filename = strcat('times_keep',muscleName,date, '021','.mat');
save(filename,'cluster_class')

