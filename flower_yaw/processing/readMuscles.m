function [muscleData] = readMuscles( date, nfiles, fileNums,muscles, keepNum )

% function [muscleData] = readMuscles( date, nfiles, fileNums,muscles, keepNum )

%runs through .mat muscle file and writes new file with all of the trials
%for each muscle in the same file
%nfiles represents the number of recordings that were taken that day
%fileNums is always 'fileNums.mat', which is a file saved in the  with an array of
%strings 001, 002, 003,... for each of the numbers of the data files that
%we saved for the particular moth
%muscles is always 'muscleNames.mat' which is a file saved in the Code
%keepNum is a vector with the numbers of the recordings that we want to
%spike sort.

% This code distributed under GNL GPU license.

load(fileNums)
load(muscles)
muscleData = [];
for n = 1:length(muscleNames)
    m = 1;
    for k = 1:nfiles
        if keepNum(m) ==k
            mus = char(muscleNames(n));
            num = char(fileNums(k));
            filename = strcat(mus,date,num,'.mat');
            load(filename)
            %data = filtfilt(sos,1,data);%converts volts to microvolts to prepare the data for OFS
            muscleData(m,:) = data'; 
            m = m + 1;
        else
            continue
        end
    end
    newFileName = strcat(mus,date,'.mat');
    save(newFileName,'muscleData')
end
end

