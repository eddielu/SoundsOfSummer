function [bestMatchID, confidence] = match_segment(clip, fs)
%function [bestMatchID, confidence] = match_segment(clip, fs)
%  This function requires the global variables 'hashtable' and 'numSongs'
%  in order to work properly.
%
%  This function is currently incomplete.


global hashtable
global numSongs

hashTableSize = size(hashtable,1);


% Find peak pairs from the clip

% INSERT CODE HERE
clipTuples = 0;     % Replace this line

% Construct the cell of matches
matches = cell(numSongs,1);
for k = 1:size(clipTuples, 1)
    % INSERT CODE HERE TO CALCULATE HASH
    clipHash = 1;   % Replace this line
    
    % If an entry exists with this hash, find the song(s) with matching peak pairs
    if (~isempty(hashtable{clipHash, 1}))
        matchID = hashtable{clipHash, 1}; % row vector of collisions
        matchTime = hashtable{clipHash, 2}; % row vector of collisions
        
        % Calculate the time difference between clip pair and song pair
        % INSERT CODE HERE
                
        % Add matches to the lists for each individual song
        for n = 1:numSongs
            % INSERT CODE HERE
            % matches{n} = [matches{n}, ...
        end
    end
end

% Find the counts of the mode of the time offset array for each song
% INSERT CODE HERE
for k = 1:numSongs
    % INSERT CODE HERE
end


% Song decision and confidence
% INSERT CODE HERE


optional_plot = 0; % turn plot on or off

if optional_plot
    figure(3)
    clf
    y = zeros(length(matches),1);
    for k = 1:length(matches)
        subplot(length(matches),1,k)
        hist(matches{k},1000)
        y(k) = max(hist(matches{k},1000));
    end
    
    for k = 1:length(matches)
        subplot(length(matches),1,k)
        axis([-inf, inf, 0, max(y)])
    end

    subplot(length(matches),1,1)
    title('Histogram of offsets for each song')
end

end

