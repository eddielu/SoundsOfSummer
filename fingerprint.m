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


% INSERT SPECTROGRAM CODE HERE.
magS = 0; % Remove and replace this line to create a magS that is the magnitute of the spectrogram



% Find the local peaks with respect to the nearest gs entries in both
% directions


% INSERT PEAK FINDING CODE HERE.
peaks = ones(size(magS)); % 2D boolean array indicating position of local peaks
for horShift = -gs:gs
    for vertShift = -gs:gs
        if(vertShift ~= 0 || horShift ~= 0) % Avoid comparing to self
            % peaks = peaks.* (INSERT CODE HERE);
        end
    end
end


% EXPERIMENT WITH DIFFERENT THRESHOLD VALUES HERE.
threshold = 0;

% Calculate threshold to use.
% We will set one threshold for the entire segment.  Improvements might be
% possible by adapting the threshold throughout the length of the segment,
% and setting a lower threshold for higher frequencies.

% THE FOLLOWING CODE TO BE UNCOMMENTED AFTER EXPERIMENTING WITH THRESHOLD
% peakMags = peaks.*magS;
% sortedpeakMags = sort(peakMags(:),'descend'); % sort all peak values in order
% threshold = sortedpeakMags(ceil(max(T)*desiredPPS));

% Apply threshold
if (threshold > 0)
    peaks = (peakMags >= threshold);
end




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

