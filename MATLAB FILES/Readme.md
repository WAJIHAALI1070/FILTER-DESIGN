# MATLAB Files
# load_audio.m
Loads audio data from the raw_audio directory and prepares it for processing.

Usage: 
  
    audio_data = load_audio('data/raw_audio');

# NOISE_REDUCTION.m
Applies noise reduction techniques to the loaded audio data.

Usage: 
  
    filtered_audio = noise_reduction(audio_data);

# FREQUENCY_RANGE.m
Classifies the audio data based on predefined frequency ranges.
Usage: 

    classification_results = frequency_classification(features, 'data/FrequencyRanges.csv');

# BANDPASSFILTER.m
Designs a bandpass filter using the FIR method to isolate specific frequency ranges.
Usage: 
              
    bpf_audio = bandpass_filter_design(filtered_audio, 11000, 12000);

# SPECTROGRAM_PLOT
Plots the spectrogram of each file in the data set 
Usage: 

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

# FILTER_DEPLOYMENT.m
Generates visual plots comparing original and processed signals, and displays classification results.

Usage:
    
    visualize_results(original_audio, filtered_audio, bpf_audio, classification_results);

# Usage
1. Load Audio Data: Run load_audio.m to load raw audio files.
2. Noise Reduction: Apply noise reduction by running noise_reduction.m.
3. Feature Extraction: Extract features from the denoised audio using feature_extraction.m.
4. Frequency Classification: Classify the audio data based on frequency ranges with frequency_classification.m.
5. Bandpass Filter Design: Design and apply a bandpass filter using bandpass_filter_design.m.
6. Visualize Results: Generate and view visualizations using visualize_results.m.
