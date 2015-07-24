function [bestMatchID, confidence] = match_segment(clip, fs)
%function [bestMatchID, confidence] = match_segment(clip, fs)
%  This function requires the global variables 'hashtable' and 'numSongs'
%  in order to work properly.
%
%  This function is currently incomplete.


global hashtable
global numSongs

hashTableSize = size(hashtable,1);

soundsc(clip, fs);
% Find peak pairs from the clip


clipTuples = convert_to_pairs(fingerprint(clip, fs));     % Replace this line

% Construct the cell of matches
matches = cell(numSongs,1);
for k = 1:size(clipTuples, 1)
    clipHash = simple_hash(clipTuples(k,3), clipTuples(k,4), clipTuples(k,2)-clipTuples(k,1), hashTableSize);
    %clipHash = 1;   % Replace this line
    
    % If an entry exists with this hash, find the song(s) with matching peak pairs
    if (~isempty(hashtable{clipHash, 1}))
        matchID = hashtable{clipHash, 1}; % row vector of collisions
        matchTime = hashtable{clipHash, 2}; % row vector of collisions
        
        % Calculate the time difference between clip pair and song pair
        matchTime = matchTime - clipTuples(k,1);
                
        % Add matches to the lists for each individual song
        for n = 1:numSongs
            % INSERT CODE HERE
            matches{n} = [matches{n}, matchTime(find(matchID == n))];
        end
    end
end

% Find the counts of the mode of the time offset array for each song
% INSERT CODE HERE
maxV = 0;
maxI = 0;
for k = 1:numSongs
    [blah, count] = mode(matches{k});
    if maxV < count
        maxV = count;
        maxI = k;
    end
end
bestMatchID = maxI;


% Song decision and confidence
confidence = 1;


optional_plot = 1; % turn plot on or off

% plot(matches{16})
if optional_plot
    figure(3)
    clf
    y = zeros(2,1);
    for k = 16
        subplot(2,1,1)
        hist(matches{k},1000)
        y(k) = max(hist(matches{k},1000));
    end
    for k = maxI
        subplot(2,1,2)
        hist(matches{k},1000)
        y(k) = max(hist(matches{k},1000));
    end
    
    for k = 16
        subplot(2,1,1)
        axis([-inf, inf, 0, max(y)])
    end
    for k = maxI
        subplot(2,1,2)
        axis([-inf, inf, 0, max(y)])
    end

    %subplot(1,1,1)
    title('Histogram of offsets for each song')
end

end

