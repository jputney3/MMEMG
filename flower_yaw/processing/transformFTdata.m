function FT_values = transformFTdata(raw_data,bias_offset)

% function FT_values = transformFTdata(raw_data,bias_offset)

% This function converts the raw voltages from the DAQ of the force/torque
% transducer to real force and torque values using the ATI calibration
% matrix, bias offset settings, and translation matrix of the axes.

% IN CURRENT VERSION:
% Input variables
% raw_data = 6 x 1 matrix of gauge voltage values at single time point
% bias_offset = 6 x 1 matrix of offset correction voltage values

% Output variables
% FT_values = 6 x 1 matrix of transformed force/torque values in units of N
% and N-mm.

% All FT units are N and N-mm.

% This code is distributed under a GNU GPL license.

% Calibration Matrix, in N and N-mm:
% Provided by ATI for our custom FT transducer
cal_m = [-0.000352378	0.020472451	-0.02633045	-0.688977299	0.000378075	0.710008955
-0.019191418	0.839003543	-0.017177775	-0.37643613	0.004482987	-0.434163392
0.830046806	0.004569748	0.833562339	0.021075403	0.802936538	-0.001350335
-0.316303442	5.061378026	4.614179159	-2.150699522	-4.341889297	-2.630773662
-5.320003676	-0.156640061	2.796170871	4.206523866	2.780562472	-4.252850011
-0.056240509	3.091367987	0.122101875	2.941467741	0.005876647	3.094672928];

% Translation Matrix, in N and N-mm:
% Translated to attachment point of the tether
transl_m = [1	0	0	0	0	0
0	1	0	0	0	0
0	0	1	0	0	0
0	94.5	0	1	0	0
-94.5	0	0	0	1	0
0	0	0	0	0	1];

% Bias Offset

FT_values = zeros(size(raw_data,1),size(raw_data,2));

for i = 1:size(raw_data,2)
FT_values(:,i) = raw_data(:,i) - bias_offset;
end

% Calibrated Output

FT_values = cal_m*FT_values;

% Translated Output (new axes)

FT_values = transl_m*FT_values;