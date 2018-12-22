function [t,Fz,fFz,idxi] = triggerT(torque_data)

% function [t,Fz,fFz,idxi] = triggerT(torque_data)

% torque_data = matrix of FT data with rows as
% each sample point and columns as:
% column 1 - time
% column 2 - Fx
% column 3 - Fy
% column 4 - Fz
% column 5 - Tx
% column 6 - Ty
% column 7 - Tz

% t = time data from torque_data, transformed to positive values.
% Our data is collected pre-trigger (neg. values)

% Fz = column 4 of torque_data

% fFz = filtered Fz data to extract wing stroke frequency

% idxi = index indicating peak downward force after treating Fz as a cosine
% wave. This roughly corresponds to zero-phase crossing of Tz. Peak
% downward force occurs roughly 10 ms before DLM activation.

% This code is distributed under a GNU GPL license.

%Pull data on time and force in z-dir:
t = torque_data(:,1)+20;
Fz = torque_data(:,4);

% % Bandpass Fz data with 8th order Type II Chebychev filter:
n = 4;
Rs = 20;
Ws = [3 35]/5000;

% % Using this set-up causes problems in the filter. See cheby2
% documentation and section 'More About'. Have to use z,p,k to construct
% filter.
% %[b,a] = cheby2(n,Rs,Ws,'bandpass');
% %fFz = filter(b,a,Fz);

[z,p,k] = cheby2(n,Rs,Ws,'bandpass');
soshi = zp2sos(z,p,k);
fFz = filtfilt(soshi,1,Fz);

% % Another way to filter is using the IIR filter below but results are
% very similar to filter above, and the Type II Cheby was what was used in
% Simon's previous paper (Sponberg et al. 2012):
% % d = designfilt('bandpassiir','FilterOrder',8, ...
% %     'StopbandFrequency1',3,'StopbandFrequency2',35, ...
% %     'StopbandAttenuation',10,'SampleRate',10000);
% % fFz2 = filter(d,Fz);

% Transform data to hilbert space:
hFz = hilbert(fFz);

% Was using only the imaginary variable to find phase crossing; more
% appropriate to use the angle as below.
% x = real(hFz);
% y = imag(hFz);

phase = angle(hFz);

% Identify zero-phase-crossings of data as changing sign of imaginary
% (phase??) variable:
idx = find(diff(sign(phase)));
% Remove crossings at points that are negative in force (have to pick one):
idx = idx(fFz(idx)>0);

idxi = idx;

% Output is indices where Fz is maximized at each wingstroke. Corresponds
% to treating the force in z-dir as a cosine wave (zero-phase is max).


% Without filtering data, need to use some sort of winnowing method to get
% rid of points detected close together:
% dist = diff(idxi);
% thr = 300;
% 
% while min(dist)<thr
%     i = find(dist==min(dist));
%     [k,k2] = min([fFz(idxi(i)) fFz(idxi(i+1))]');
%     idxi(i+(k2-1)') = [];
%     dist = diff(idxi);
% end