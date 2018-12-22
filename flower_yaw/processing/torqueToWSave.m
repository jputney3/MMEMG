function [ws_ave,freq_ave] = torqueToWSave(Tz_WS)

% function [ws_ave,freq_ave] = torqueToWSave(Tz_WS)

% Tz_WS = matrix from chunkTorqueToWS.m, with rows as each characteristic time
% period in the data (ex. stride, wing stroke), and columns as each sample
% point during the time period. Rows should look like waveforms.

% ws_ave = vector with rows as characteristic time periods in data (ex.
% stride, wing stroke). Each value is the average Tz during each time
% period.

% freq_ave = average instantaneous frequency of each characteristic time
% period. Here, sampling rate is assumed to be 10000 Hz.

% This code is distributed under a GNU GPL license.

% Takes average while ignoring NaN values:
ws_ave = nanmean(Tz_WS');

% Determines average instantaneous frequency:
% Here, sampling rate is assumed to be 10000 Hz
freq_ave = 1/mean(sum(~isnan(Tz_WS'))/10000);