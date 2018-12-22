function [] = compileSpikes( muscleNames, dateNum, bound, keepAll, shiftTrigger)

% function [] = compileSpikes( muscleNames, dateNum, bound, keepAll, shiftTrigger)

%compileSpikes opens each of the files containing sorted spike data from
%wave_clus for a particular recording and generates variable names labeled
%as the name of each muscle. This function does not output anything, but it
%opens the new variables in the current workspace. This function can be
%used similarly to the 'load' function except it assigns new variable names
%according to the name of the muscles inputted as strings. 
%  muscleNames should be a list of abreviations for each muscle as strings
% dateNum is the date that the recordings were taken with the ending number
% of the recording as a string
% keepZeros is a boolean value of True or False which determines whether to
% call the discardSpikes function. True will not call the discardSpikes
% function, False will call the discardSpikes function and get rid of all
% the spikes in cluster zero

% This code is distributed under GNU GPL license.

filestart = 'times_keep';
fileend = strcat('_',dateNum, '.mat');
i = 1;
theSpikes = ones(1,length(muscleNames));
while i <= length(muscleNames)
    muscle = char(muscleNames(i,1));
    filename = strcat(filestart, muscle, fileend);
   if keepAll(i,1) == 1
    load(filename)
    cluster_class(:,1) = cluster_class(:,1) + shiftTrigger;
    cluster_class(:,1) = cluster_class(:,1)*1000;
    assignin('caller', muscle, cluster_class(:,1));
        %theSpikes(:,i) = cluster_class(:,2);% whose name is associated with the muscle name
    % then compiles muscle spike vector into complete muscle matrix
       % muscleArray(:,i) = muscle
    muscleUpBound = strcat(muscle,'upBound');
    muscleLowBound = strcat(muscle,'lowBound');
    assignin('caller',muscleUpBound,bound(i,2));
    assignin('caller',muscleLowBound,bound(i,1));
    i = i + 1;
    else
        trueSpikes = discardSpikes(filename, keepAll(i,:)); % iterates through the indices to ensure that muscles stay in correct order when compiled into matrix
        trueSpikes = trueSpikes * 1000;
        assignin('caller', muscle, trueSpikes); %assigns muscle spike times to variable called muscle name
        %theSpikes(1,i) = muscle;
        %theSpikes(:,i) = trueSpikes; % order should match the order inputted into the muscleNames variable
        muscleUpBound = strcat(muscle,'upBound');
        muscleLowBound = strcat(muscle,'lowBound');
        assignin('caller',muscleUpBound,bound(i,2));
        assignin('caller',muscleLowBound,bound(i,1));
        i = i + 1;
        %muscleArray(:,i) = muscle
  end
end % at this point we have a for loop that assigns each muscle name to a single vector
% The next step is to chunk the data into wingstrokes one muscle at a time.
% 

end
