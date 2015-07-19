[y,fs] = mp3read('viva.mp3');
averagedSound = mean(y')';
dcBias = mean(averagedSound);
averagedSound = averagedSound - dcBias;

fs2 = 8000;
resampledSound = resample(averagedSound, fs2, fs);
window = 0.064 * fs2;
noverlap = 0.032 * fs2;
[S,F,T] = spectrogram(resampledSound, window, noverlap, [], fs2);
%imagesc(T,F,log(abs(S)));
xlabel('Time');
ylabel('Frequency');
axis xy;
S = abs(S);





magS = 0;
new_smpl_rate = 8000; % sampling rate
time_res = .064; % for spectrogram
gs = 4; % grid size for spectrogram peak search
desiredPPS = 30; % scales the threshold
    
% INSERT PEAK FINDING CODE HERE.
peaks = ones(size(magS)); % 2D boolean array indicating position of local peaks
for horShift = -gs:gs
    for vertShift = -gs:gs
        if(vertShift ~= 0 || horShift ~= 0) % Avoid comparing to self
            CS = circshift(S, [vertShift, horShift]);
            P = (S < CS);
            peaks = peaks .* P;
        end
    end
end
imagesc(T,F,peaks);
colormap (1-gray);
fprintf(1, '%d', sum(sum(P)));
sai = peaks;