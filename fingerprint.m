function peaks = fingerprint(sound, fs)
%function peaks = fingerprint(sound, fs)
%   
% This function takes a sound and sampling frequency.  It returns a binary
% matrix indicating the locations of peaks in the spectrogram.
%
% This function is currently incomplete.


new_smpl_rate = 8000; % sampling rate
time_res = .064; % for spectrogram
gs = 4; % grid size for spectrogram peak search
desiredPPS = 30; % scales the threshold


% INSERT PREPROCESING CODE HERE


% Create the spectrogram
% Because the signal is real, only positive frequencies will be returned by
% the spectrogram function, which is all we will need.

resampledSound = resample(sound, new_smpl_rate, fs);
    
averagedSound = mean(resampledSound')';
dcBias = mean(averagedSound);
averagedSound = averagedSound - dcBias;



window = 0.064 * new_smpl_rate;
noverlap = 0.032 * new_smpl_rate;
[S,F,T] = spectrogram(averagedSound, round(window), round(noverlap), [], new_smpl_rate);
S = abs(S);
% INSERT SPECTROGRAM CODE HERE.
magS = S; % Remove and replace this line to create a magS that is the magnitute of the spectrogram



% Find the local peaks with respect to the nearest gs entries in both
% directions




% INSERT PEAK FINDING CODE HERE.
peaks = ones(size(magS)); % 2D boolean array indicating position of local peaks
for horShift = -gs:gs
    for vertShift = -gs:gs
        if(vertShift ~= 0 || horShift ~= 0) % Avoid comparing to self
            CS = circshift(S, [vertShift, horShift]);
            P = (S > CS);
            peaks = peaks .* P;
        end
    end
end



% Calculate threshold to use.
% We will set one threshold for the entire segment.  Improvements might be
% possible by adapting the threshold throughout the length of the segment,
% and setting a lower threshold for higher frequencies.

% THE FOLLOWING CODE TO BE UNCOMMENTED AFTER EXPERIMENTING WITH THRESHOLD
peakMags = peaks.*magS;
sortedpeakMags = sort(peakMags(:),'descend'); % sort all peak values in order
threshold = sortedpeakMags(ceil(max(T)*desiredPPS));

% Apply threshold
if (threshold > 0)
    peaks = (peakMags >= threshold);
end


% CODE TO PRODUCE GRAPH
% imagesc(T,F,peaks);
% colormap (1-gray);
% fprintf(1, 'After threshold: %d\n', sum(sum(peaks)));


optional_plot = 0; % turn plot on or off

if optional_plot
    % plot spectrogram
    figure(1)
    Tplot = [5, 10]; % Time axis for plot

    logS = log(magS);
    imagesc(T,F,logS);
    title('Log Spectrogram');
    xlabel('time (s)');
    ylabel('frequency (Hz)');
    axis xy
    axis([Tplot, -inf, inf])
    frame1 = getframe;

    % plot local peaks over spectrogram
    peaksSpec = (logS - min(min(logS))).*(1-peaks);
    imagesc(T,F,peaksSpec);
    title('Log Spectrogram');
    xlabel('time (s)');
    ylabel('frequency (Hz)');
    axis xy
    axis([Tplot, -inf, inf])
    frame2 = getframe;

    movie([frame1,frame2],10,1)
end

end

