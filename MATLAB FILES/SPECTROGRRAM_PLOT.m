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
    
    % Store power spectrum
    allPowerSpectra{k} = 10*log10(averagePower);
end

% Plotting all power spectra in the same plot
figure;
hold on;
for k = 1:length(audioFiles)
    plot(f, allPowerSpectra{k});
end
hold off;

xlabel('Frequency (Hz)');
ylabel('Power (dB)');
title('Average Power Spectra of All Audio Files');
legend({audioFiles.name}, 'Interpreter', 'none');
grid on;

% Convert results to table and save to Excel file
resultTable = cell2table(results, 'VariableNames', {'FileName', 'MinFreq_Hz', 'MaxFreq_Hz'});
writetable(resultTable, fullfile(outputDir, 'FrequencyRanges.xlsx'));

fprintf('Results saved to %s\n', fullfile(outputDir, 'FrequencyRanges.xlsx'));
