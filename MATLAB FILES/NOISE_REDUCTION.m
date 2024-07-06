% Specify the directories for input and output files
inputDir = 'H:\EE SEM VI\Digital Signal Processing\DSP_project\Dataset';
outputDir = 'H:\EE SEM VI\Digital Signal Processing\DSP_project\Filtered_Dataset';

% Create the output directory if it doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Specify the file extension (e.g., '.wav')
fileExtension = '*.wav';

% Get a list of all files in the directory with the specified extension
audioFiles = dir(fullfile(inputDir, fileExtension));

% Define parameters
frameLength = 1024; % Length of each frame for FFT analysis
overlapRatio = 0.5; % Overlap ratio between frames
noiseThreshold = 0.1; % Threshold for noise estimation (adjust as needed)

% Iterate over each audio file
for fileIndex = 1:length(audioFiles)
    % Read the audio file
    filePath = fullfile(inputDir, audioFiles(fileIndex).name);
    [y, Fs] = audioread(filePath);
    
    % Ensure y is a column vector
    if size(y, 2) > 1
        y = mean(y, 2); % Convert to mono by averaging channels
    end
    
    % Initialize filtered signal
    yFiltered = zeros(size(y));

    % Compute the number of overlapping frames
    frameShift = round(frameLength * (1 - overlapRatio));
    numFrames = floor((length(y) - frameLength) / frameShift) + 1;

    % Iterate over frames
    for i = 1:numFrames
        % Extract a frame of audio data
        startIndex = (i - 1) * frameShift + 1;
        endIndex = startIndex + frameLength - 1;
        
        % Handle the case where endIndex exceeds the length of y
        if endIndex > length(y)
            frame = [y(startIndex:end); zeros(endIndex - length(y), 1)];
        else
            frame = y(startIndex:endIndex);
        end
        
        % Compute the FFT of the frame
        frameFFT = fft(frame);

        % Estimate the noise spectrum (e.g., using median statistics)
        noiseRegion = frameFFT(1:round(length(frameFFT) * 0.1)); % Assuming noise is present in the first 10% of the spectrum
        noise = median(abs(noiseRegion));

        % Apply spectral subtraction
        frameFFTFiltered = frameFFT - noiseThreshold * noise;
        frameFFTFiltered = max(frameFFTFiltered, 0); % Ensure non-negative values
        frameFiltered = ifft(frameFFTFiltered, 'symmetric'); % Ensure real output

        % Overlap-add the filtered frame to the output signal
        yFiltered(startIndex:endIndex) = yFiltered(startIndex:endIndex) + frameFiltered;
    end

    % Normalize the filtered signal
    yFiltered = yFiltered / max(abs(yFiltered));

    % Create the output file path
    [~, name, ext] = fileparts(audioFiles(fileIndex).name);
    outputFilePath = fullfile(outputDir, [name '_filtered' ext]);

    % Write the filtered audio data to a new file
    audiowrite(outputFilePath, yFiltered, Fs);

    % Plot and compare the original and filtered signals
    t = (0:length(y)-1) / Fs;
    tFiltered = (0:length(yFiltered)-1) / Fs;
    figure;
    subplot(2, 1, 1);
    plot(t, y);
    title(['Original Signal: ', name]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    subplot(2, 1, 2);
    plot(tFiltered, yFiltered);
    title(['Filtered Signal: ', name]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    % Save the plot as an image file
    saveas(gcf, fullfile(outputDir, [name '_comparison.png']));
end
