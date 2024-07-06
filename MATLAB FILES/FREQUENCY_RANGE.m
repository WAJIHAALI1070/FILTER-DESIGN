% Define the CSV file path
csvFile = 'H:\EE SEM VI\Digital Signal Processing\DSP_project\OUTPUT\FrequencyRanges.csv';

% Check if the CSV file exists
if ~isfile(csvFile)
    error('Unable to find or open %s. Check the path and filename or file permissions.', csvFile);
end

% Read the CSV file with frequency ranges
frequencyData = readtable(csvFile);
% Define the healthy frequency range
healthyRange = [11000, inf]; % Adjust if needed

% Define the unhealthy frequency range
unhealthyRange = [6005, 9800]; % Adjust if needed

% Define the noise frequency range
noiseRange = [0, 6000]; % Adjust if needed

% Initialize results storage
results = struct('filename', {}, 'minFreq', {}, 'maxFreq', {}, 'classification', {});

% Process each row in the CSV file
for k = 1:height(frequencyData)
    baseFileName = frequencyData.FileName{k};
    minFreq = frequencyData.MinFreq_Hz(k);
    maxFreq = frequencyData.MaxFreq_Hz(k);

    % Classification based on frequency range
    if minFreq >= noiseRange(1) && maxFreq <= noiseRange(2)
        classification = 'Noise';
    elseif minFreq >= unhealthyRange(1) && maxFreq <= unhealthyRange(2)
        classification = 'Unhealthy';
    elseif minFreq >= healthyRange(1) && maxFreq <= healthyRange(2)
        classification = 'Healthy';
    else
        classification = 'Unknown';
    end

    % Save the result
    results(k).filename = baseFileName;
    results(k).minFreq = minFreq;
    results(k).maxFreq = maxFreq;
    results(k).classification = classification;
end

% Display the results
disp('Classification Results:');
for k = 1:length(results)
    fprintf('%s: MinFreq = %.2f Hz, MaxFreq = %.2f Hz, Classification = %s\n', ...
        results(k).filename, results(k).minFreq, results(k).maxFreq, results(k).classification);
end


