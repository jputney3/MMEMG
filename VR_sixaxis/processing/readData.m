function [data] = readData( filename, vname )
% function [data] = readData( filename, vname )

% runs through .mat data files and writes new files with single variables
%'data' saved as  each muscle name.

% Data formated with rows of matrix as samples and columns as:
% column 1 - time
% column 2 - L3AX signal
% column 3 - LBA signal
% column 4 - LSA signal
% column 5 - LDVM signal
% column 6 - LDLM signal
% column 7 - R3AX signal
% column 8 - RBA signal
% column 9 - RSA signal
% column 10 - RDVM signal
% column 11 - RDLM signal

% This code distributed under GNL GPU license.

endstr = filename(19:length(filename));
time = vname(:,1);
data = vname(:,2);
data = data';
save(strcat('LAx',endstr),'data')
data = vname(:,3);
data = data';
save(strcat('LBa',endstr),'data')
data = vname(:,4);
data = data';
save(strcat('LSa',endstr),'data')
data = vname(:,5);
data = data';
save(strcat('LDVM',endstr),'data')
data = vname(:,6);
data = data';
save(strcat('LDLM',endstr),'data')
data = vname(:,7);
data = data';
save(strcat('RDLM',endstr),'data')
data = vname(:,8);
data = data';
save(strcat('RDVM',endstr),'data')
data = vname(:,9);
data = data';
save(strcat('RSa',endstr),'data')
data = vname(:,10);
data = data';
save(strcat('RBa',endstr),'data')
data = vname(:,11);
data = data';
save(strcat('RAx',endstr),'data')

end

