% Convert gage voltages to torques.
function gv2t(folder_name,q_file_num)

% function gv2t(folder_name,q_file_num)

% Put .mat files that you want to convert into a new folder. Folder_name is
% the string input of that path directory. This code will save converted
% torques to the .mat files.

% folder_name = string with directory/path info for the folder with FT data
% files in it.

% q_file_num = this is a file used as the zero/quiescent to deal with any
% bias/offset present in the FT strain gauge data.

% This code is distributed under a GNU GPL license.

% Count # of files in folder
D = dir([folder_name,'\*.mat']);
Num = length(D(not([D.isdir])));

% Create list of files
file_list = {D.name}';

% Change current directory to folder with files:
cd(folder_name)

% Determine bias offsets from first file
% Note: Quiescent file is assumed to be the first file. This may not be
% true.

currdata_name = strsplit(file_list{q_file_num},'.');

q_data = load(file_list{q_file_num},currdata_name{1});
q_data = eval(strcat('q_data.',currdata_name{1}));

bias_offset = mean(q_data(:,2:7));

% Now, transform strain gage data from all files in directory to torque and
% save new files.

for i = 1:Num
    currdata_name = strsplit(file_list{i},'.');
    
    torque_data = load(file_list{i},currdata_name{1});
    torque_data = eval(strcat('torque_data.',currdata_name{1}));
    
    FT_values = transformFTdata(torque_data(:,2:7)',bias_offset');
    
    % Fourth-order Butterworth filter, cutoff = 1000 Hz
    % These filter settings may be modified for your specific application.
    % Here, sampling freqency = 10000 Hz
    [b,a] = butter(4,1000/(10000/2));
    
    torque_data(:,2:7) = FT_values';
    [t,Fz,fFz,idxi] = triggerT(torque_data);
    
    % Filter forces and torques:
    torque_data(:,2:7) = filtfilt(b,a,torque_data(:,2:7));
    
    % Chunk torque to wingstrokes:
    Tz_WS = chunkTorqueToWS(torque_data,idxi);
    [ws_ave,freq_ave] = torqueToWSave(Tz_WS);

    save(file_list{i},'torque_data','idxi','Tz_WS','ws_ave','freq_ave','-append');
end




    
