function [muscles] = makeM( infoFile , wingTimeFile )

% function [muscles] = makeM( infoFile , wingTimeFile )

% makeM- this function runs through all of the timing information acquired
% from all of the muscle recordings and spike sorting and chunks them into
% wingstrokes to form a single matrix of muscle activations on a
% wing-stroke-to-wingstroke basis
%   infoFile is a workspace file which contains at least four variables:
% 1- muscleNames- an array of muscle names, in the form of strings, which are the muscles that will be used in the M matrix
% indicates the spikes from cluster zero need to be kept
% 2- dateNum- a string representing the date and the number associated with
% the recorded data
% 3- bound a matrix that contains the plus or minus time bounds for each
% muscle relative to the wingstroke time. 
% In current version of code, bound is unused but still needs to be present
% for subfunctions to work.
% 4- keepAll- a 10x2 matrix with the first column indicating whether you
% want to keep all units of a particular muscle. If column 1 has a zero,
% then the second column indicates which unit to keep. 
% 5 - shiftTrigger is used to shift timings if trigger falls before end of EMG
% recording. is the time value to shift EMG spikes by.
%   wingTimeFile- a file containing the variable with the wingstroke times for that muscle. 

% This code distributed under GNU GPL license.

load(infoFile)
load(wingTimeFile)
compileSpikes(muscleNames, dateNum, bound, keepAll,shiftTrigger)
% wingTime = (LDLM(1:393,1) + RDLM)/2; %calculates the start of each wingstroke
% Chunk Right DLM
[RDLMstrokes,RDLMup,RDLMlow] = chunkWS(RDLM,wingTime, 5:1:45, 10:-1:-10, 'maxLow');
dRDLM = size(RDLMstrokes);
[LDLMstrokes,LDLMup,LDLMlow] = chunkWS(LDLM,wingTime, 5:1:45, 10:-1:-10, 'maxLow');
dLDLM = size(LDLMstrokes);
[RDVMstrokes,RDVMup,RDVMlow] = chunkWS(RDVM, wingTime, 5:1:50, 10:-1:-10, 'maxLow');
dRDVM = size(RDVMstrokes);
[LDVMstrokes,LDVMup,LDVMlow] = chunkWS(LDVM, wingTime, 5:1:50, 10:-1:-10, 'maxLow');
dLDVM = size(LDVMstrokes);
[RAXstrokes,RAxup,RAxlow] = chunkWS(RAx, wingTime, 5:1:40, 30:-1:-10, 'middle');
dRAX = size(RAXstrokes);
[LAXstrokes,LAxup,LAxlow] = chunkWS(LAx, wingTime, 5:1:40, 30:-1:-10, 'middle');
dLAX = size(LAXstrokes);
[RBAstrokes,RBaup,RBalow] = chunkWS(RBa, wingTime, 5:1:50, 25:-1:-10, 'middle');
dRBA = size(RBAstrokes);
[LBAstrokes,LBaup,LBalow] = chunkWS(LBa, wingTime, 5:1:50, 25:-1:-10, 'middle');
dLBA = size(LBAstrokes);
[RSAstrokes,RSaup,RSalow] = chunkWS(RSa, wingTime, 5:1:35, 25:-1:-10, 'middle');
dRSA = size(RSAstrokes);
[LSAstrokes,LSaup,LSalow] = chunkWS(LSa, wingTime, 5:1:35, 25:-1:-10, 'middle');
dLSA = size(LSAstrokes);

%Now we know the size of M, so we can convert from zeros to NaNs
RDLMstrokes = chunkWS2(RDLM,wingTime,RDLMup, RDLMlow, dRDLM(:,2));
LDLMstrokes = chunkWS2(LDLM,wingTime,LDLMup, LDLMlow, dLDLM(:,2));
RDVMstrokes = chunkWS2(RDVM, wingTime,RDVMup, RDVMlow, dRDVM(:,2));
LDVMstrokes = chunkWS2(LDVM, wingTime, LDVMup, LDVMlow, dLDVM(:,2));
RAXstrokes = chunkWS2(RAx, wingTime,RAxup, RAxlow, dRAX(:,2));
LAXstrokes = chunkWS2(LAx, wingTime,LAxup, LAxlow, dLAX(:,2));
RBAstrokes = chunkWS2(RBa, wingTime,RBaup, RBalow, dRBA(:,2));
LBAstrokes = chunkWS2(LBa, wingTime,LBaup, LBalow, dLBA(:,2));
RSAstrokes = chunkWS2(RSa, wingTime,RSaup, RSalow, dRSA(:,2));
LSAstrokes = chunkWS2(LSa, wingTime,LSaup, LSalow, dLSA(:,2));

newBound = [LAxlow LAxup; LBalow LBaup;LSalow LSaup; LDVMlow LDVMup;LDLMlow LDLMup;RDLMlow RDLMup; RDVMlow RDVMup;RSalow RSaup;RBalow RBaup;RAxlow RAxup];
muscles = [LAXstrokes, LBAstrokes, LSAstrokes, LDVMstrokes, LDLMstrokes, RDLMstrokes, RDVMstrokes, RSAstrokes, RBAstrokes, RAXstrokes];
% muscles_header = {'LAX', 'LBA', 'LSA', 'LDVM', 'LDLM', 'RDLM', 'RDVM', 'RSA', 'RBA', 'RAX'; dLAX(:,2), dLBA(:,2), dLSA(:,2), dLDVM(:,2), dLDLM(:,2), dRDLM(:,2), dRDVM(:,2), dRSA(:,2), dRBA(:,2), dRAX(:,2)};

newFileName = strcat('Muscles_', dateNum);
save(newFileName, 'LAXstrokes', 'LBAstrokes', 'LSAstrokes', 'LDVMstrokes', 'LDLMstrokes', 'RDLMstrokes', 'RDVMstrokes', 'RSAstrokes', 'RBAstrokes', 'RAXstrokes');

