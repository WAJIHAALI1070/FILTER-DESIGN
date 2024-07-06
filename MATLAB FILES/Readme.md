# MATLAB Files
# load_audio.m
Loads audio data from the raw_audio directory and prepares it for processing.

Usage: 
  
            audio_data = load_audio('data/raw_audio');

# noise_reduction.m
Applies noise reduction techniques to the loaded audio data.

Usage: 
                
           filtered_audio = noise_reduction(audio_data);

# feature_extraction.m
Extracts frequency domain features from the denoised audio data.
Usage: 

            features = feature_extraction(filtered_audio);

# frequency_classification.m
Classifies the audio data based on predefined frequency ranges.
Usage: 

            classification_results = frequency_classification(features, 'data/FrequencyRanges.csv');

# bandpass_filter_design.m
Designs a bandpass filter using the FIR method to isolate specific frequency ranges.
Usage: 
              
              bpf_audio = bandpass_filter_design(filtered_audio, 11000, 12000);

# visualize_results.m
Generates visual plots comparing original and processed signals, and displays classification results.

Usage: 
      
                visualize_results(original_audio, filtered_audio, bpf_audio, classification_results);

# Usage
Load Audio Data: Run load_audio.m to load raw audio files.
Noise Reduction: Apply noise reduction by running noise_reduction.m.
Feature Extraction: Extract features from the denoised audio using feature_extraction.m.
Frequency Classification: Classify the audio data based on frequency ranges with frequency_classification.m.
Bandpass Filter Design: Design and apply a bandpass filter using bandpass_filter_design.m.
Visualize Results: Generate and view visualizations using visualize_results.m.
