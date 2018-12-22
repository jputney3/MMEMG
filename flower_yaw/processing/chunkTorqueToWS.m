function Tz_WS = chunkTorqueToWS(torque_data,idxi)

%function Tz_WS = chunkTorqueToWS(torque_data,idxi)

% torque_data = matrix of FT data with rows as
% each sample point and columns as:
% column 1 - time
% column 2 - Fx
% column 3 - Fy
% column 4 - Fz
% column 5 - Tx
% column 6 - Ty
% column 7 - Tz

% idxi - indices used to separate characteristic time periods
% in the data (ex. stride, wing stroke, etc.)

% Tz_WS = matrix of yaw torque data with rows as each characteristic time
% period in the data (ex. stride, wing stroke), and columns as each sample
% point during the time period. Rows should look like waveforms.

% This code is distributed under a GNU GPL license.

% Pull yaw torque (Tz) data from torque_data variable:
Tz = torque_data(:,7)';

% Determine number of data points in between each wingstroke:
dist = diff(idxi);

% Initialize wingstroke-chunked Tz matrix (Tz_WS):
Tz_WS = NaN(length(idxi),max(dist));

% Populate this matrix:
% Starting wingstroke:
Tz_WS(1,1:idxi(1)) = Tz(1:idxi(1));

for i = 2:length(idxi)
    Tz_WS(i,1:dist(i-1)) = Tz(idxi(i-1)+1:idxi(i));
end

% Ending wingstroke:
Tz_WS(length(idxi)+1,1:length(Tz)-idxi(end)) = Tz(idxi(end)+1:end);

% Deal with zeros at the end:
% This is due to variable length of samples in each time period
Tz_WS(length(idxi)+1,length(Tz)-idxi(end)+1:end)=NaN;
