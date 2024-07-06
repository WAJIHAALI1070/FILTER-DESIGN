% Define input and output directories
audioDir = 'H:\EE SEM VI\Digital Signal Processing\DSP_project\Filtered_Dataset';
outputDir = 'H:\EE SEM VI\Digital Signal Processing\DSP_project\OUTPUT';

% Get list of all .wav files in the input directory
audioFiles = dir(fullfile(audioDir, '*.wav'));

% Ensure there are .wav files to process
if isempty(audioFiles)
    error('No .wav files found in the specified directory');
end

% Initialize an array to store the results
results = cell(length(audioFiles), 3);

% Initialize a cell array to store power spectra
allPowerSpectra = cell(length(audioFiles), 1);
filteredPowerSpectra = cell(length(audioFiles), 1);

% Define the bandpass filter parameters
lowFreq = 11000;
highFreq = 12000;
Fs = 96000;

% Design the FIR bandpass filter using fir1 function
filterOrder = 1000; % High order for sharper transitions
band = [lowFreq highFreq] / (Fs / 2); % Normalized frequency
b = fir1(filterOrder, band, 'bandpass');

% Plot the frequency response of the filter
figure;
[H, freq] = freqz(b, 1, 2048, Fs);
offset = 30; % Offset in dB
plot(freq, 20*log10(abs(H)) + offset, 'r', 'LineWidth', 2); % Change color to red and increase line width
title('Frequency Response of Bandpass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
axis([10500 12500 -70 40]); % Adjust the y-axis limits accordingly
grid on;

% Process each file
for k = 1:length(audioFiles)
    file = audioFiles(k).name;
    filename = fullfile(audioDir, file);
    [y, Fs] = audioread(filename);
    
    window = hamming(1024);
    noverlap = 512;
    nfft = 1024;

    [s, f, t, p] = spectrogram(y, window, noverlap, nfft, Fs, 'yaxis');
    averagePower = mean(p, 2);
    
    % Store original power spectrum
    allPowerSpectra{k} = 10*log10(averagePower);

    % Apply bandpass filter to the time-domain signal
    y_filtered = filter(b, 1, y);
    
    % Compute the spectrogram of the filtered signal
    [s_filtered, ~, ~, p_filtered] = spectrogram(y_filtered, window, noverlap, nfft, Fs, 'yaxis');
    averagePowerFiltered = mean(p_filtered, 2);
    
    % Store filtered power spectrum
    filteredPowerSpectra{k} = 10*log10(averagePowerFiltered);
end

