function [ muscleStrokes , newUp, newLow ] = chunkWS(muscle,wingTime, y, x, boundSet )

% function [ muscleStrokes , newUp, newLow ] = chunkWS(muscle,wingTime, y, x, boundSet )

% chunkData outputs a matrix with timing information for each wingstroke of
% the respective muscle (different timings within one wingstroke across and
% different wingstrokes going down) Any value of zero following the first
% column indicates that the previous timing was the final activation for
% that particular wingstroke.
%   muscle- a vector of timing events for each activation of the respective
%   muscle
% wingTime- a vector assigning time values to each wingstroke of the
% recording (usually found from R and/or L DLM timings)
% x - lower bound range to search
% y - upper bound range to search
% boundSet - string specifying which bounds to select to capture bursts.
% 'maxLow' is to get the largest lower bound.
% 'middle' gets a middle of the road range.

%use for initial compilation of M, then input dimensions into function
% muscleStrokes = NaN(length(wingTime),a)

% This code distributed under GNU GPL license.

counts = zeros(length(x),length(y));

for X = 1:length(x)
    for Y = 1:length(y)
        upBound = y(Y);
        lowBound = x(X);
        
        muscleStrokes = []; 
        
        for k = 1:length(wingTime) % counts up through the wingstrokes
            n = 1;
            i = 1; % I should start over at 1 for each time k is redefined
            j = 1;
            %num = false;
            while n <= length(muscle)
                if k == 1
                    if muscle(n,1) < (wingTime(k,1)- lowBound) % avg wingstroke is 50 ms, and I want to document activations that occur
                        % between the second half of the preceding wingstroke and
                        % the first half of the current wingstroke
                        muscleStrokes(k,i) = muscle(n,1);
                        i = i + 1;%i should increase for each time a value is placed in an index
                        %num = true;
                    elseif (wingTime(k,1) - lowBound) <= muscle(n,1) && muscle(n,1) < (wingTime(k,1) + upBound)
                        muscleStrokes(k + 1,j) = (muscle(n,1) - wingTime(k,1));
                        j = j + 1;
                    end
                elseif (muscle(n,1)> (wingTime(k,1) - lowBound)) && (muscle(n,1) <= (wingTime(k,1) + upBound))
                    %if (num == true)
                    %RDLMstrokes(k + 1,i) = (RDLM(n,1) - wingTime(k - 1,1));
                    %i = i + 1;
                    %elseif (num == false)
                    muscleStrokes(k + 1 ,i) = (muscle(n,1) - wingTime(k,1));
                    i = i + 1;
                    
                    % end
                elseif (k == length(wingTime)) && (muscle(n,1) >= (wingTime(k,1) + upBound))
                    break
                end
                n = n + 1;
            end
            %   if length(muscleStrokes) < (length(wingTime) + 1)
            %       muscleStrokes(length(wingTime)+1,1) = 0;
            %   end
            
        end
        
        muscleStrokes(muscleStrokes==0) = NaN;
        
        counts(X,Y) = sum(sum(~isnan(muscleStrokes)));
        if sum(sum(~isnan(muscleStrokes))) == length(muscle)
            break
        end
    end
end

[row,col] = find(counts - length(muscle) == 0);

if boundSet == 'maxLow'
    val = ceil(length(col)/2);
end
if boundSet == 'middle'
    val = ceil(length(row)/2);
end



newUp = y(col(val));
newLow = x(row(val));

upBound = newUp;
lowBound = newLow;

muscleStrokes = [];

for k = 1:length(wingTime) % counts up through the wingstrokes
    n = 1;
    i = 1; % I should start over at 1 for each time k is redefined
    j = 1;
    %num = false;
    while n <= length(muscle)
        if k == 1
            if muscle(n,1) < (wingTime(k,1)- lowBound) % avg wingstroke is 50 ms, and I want to document activations that occur
                % between the second half of the preceding wingstroke and
                % the first half of the current wingstroke
                muscleStrokes(k,i) = muscle(n,1);
                i = i + 1;%i should increase for each time a value is placed in an index
                %num = true;
            elseif (wingTime(k,1) - lowBound) <= muscle(n,1) && muscle(n,1) < (wingTime(k,1) + upBound)
                muscleStrokes(k + 1,j) = (muscle(n,1) - wingTime(k,1));
                j = j + 1;
            end
        elseif (muscle(n,1)> (wingTime(k,1) - lowBound)) && (muscle(n,1) <= (wingTime(k,1) + upBound))
            %if (num == true)
            %RDLMstrokes(k + 1,i) = (RDLM(n,1) - wingTime(k - 1,1));
            %i = i + 1;
            %elseif (num == false)
            muscleStrokes(k + 1 ,i) = (muscle(n,1) - wingTime(k,1));
            i = i + 1;
            
            % end
        elseif (k == length(wingTime)) && (muscle(n,1) >= (wingTime(k,1) + upBound))
            break
        end
        n = n + 1;
    end
    %   if length(muscleStrokes) < (length(wingTime) + 1)
    %       muscleStrokes(length(wingTime)+1,1) = 0;
    %   end
    
end

end

