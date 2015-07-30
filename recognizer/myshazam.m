% Make a recording or randomly select one

recordingOn = 0;    % 1 for recording from microphone, 0 for random segment
duration = 5;       % Seconds



global hashtable

% Check if we have a database in the workspace
if ~exist('songid')
    % Load database if one exists
    if exist('SONGID.mat')
        load('SONGID.mat');
        load('HASHTABLE.mat');
    else  
        msgbox('No song database');
        return;
    end
end

global numSongs
numSongs = length(songid);


if recordingOn
    % Settings used for recording.
    fs = 44100; % Sample frequency
    bits = 16;  % Bits used per sample

    % Record audio for <duration> seconds.
    recObj = audiorecorder(fs, bits, 2);
    handle1 = msgbox('Recording');
    recordblocking(recObj, duration);
    delete(handle1)

    % Store data in Double-precision array.
    sound = getaudiodata(recObj);
    
    % IF STEREO CLIP, FIND AVERAGE
    [m n] = size(sound);
    if n == 2
        sound = mean(sound, 2);
    end
    
else % Select a random segment
    
    add_noise = 1; % Optionally add noise by making this 1.
    SNRdB = 20; % Signal-to-noise Ratio in dB, if noise is added.  Can be negative.
    
    dir = 'sounds_master'; % This is the folder that the MP3 files are in.
    songs = getMp3List(dir);
    
    % Select random song
    thisSongIndex = ceil(length(songs)*rand);
    filename = strcat(dir, filesep, songs{thisSongIndex});
    [sound,fs] = mp3read(filename);
    
    % If given stereo clip, find the average.
    [m n] = size(sound);
    if n == 2
        sound = mean(sound, 2);
    end
    
    sound = sound - mean(sound);
    % Select random segment
    if length(sound) > ceil(duration*fs)
        shiftRange = length(sound) - ceil(duration*fs)+1;
        shift = ceil(shiftRange*rand);
        sound = sound(shift:shift+ceil(duration*fs)-1);
    end
    
    % Add noise
    if add_noise
        soundPower = mean(sound.^2);
        noise = randn(size(sound))*sqrt(soundPower/10^(SNRdB/10));
        sound = sound + noise;
    end
end

[id, c] = match_segment(sound, fs);
answer = songs{id};         % Set the answer
confidence = c;             


if recordingOn
    msgbox({strcat(answer, '  (matched song)'), strcat(int2str(confidence), '  (confidence)')}, 'Recorded Segment')
else
    msgbox({strcat(songs{thisSongIndex}, '  (actual song)'), strcat(answer, '  (matched song)'), strcat(int2str(confidence), '  (confidence)')}, 'Random Segment')
end