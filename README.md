# Acoustic Filter Design for Enhancing Poultry Health Management

## Authors
- **Muhammad Huzaifa**  
  School of Electrical Engineering and Computer Sciences, SEECS  
  National University of Sciences and Technology, NUST  
  Islamabad, Pakistan  
  [mhuzaifa.bee21seecs@seecs.edu.pk](mailto:mhuzaifa.bee21seecs@seecs.edu.pk)

- **Wajiha Ali**  
  School of Electrical Engineering and Computer Sciences, SEECS  
  National University of Sciences and Technology, NUST  
  Islamabad, Pakistan  
  [wali.bee21seecs@seecs.edu.pk](mailto:wali.bee21seecs@seecs.edu.pk)

---

## Abstract
The increasing global demand for animal protein has heightened reliance on the poultry industry for meat and eggs. Timely detection and management of infectious diseases in poultry are critical for maintaining animal welfare and preventing economic losses. This study focuses on compiling a dataset of healthy and unhealthy chickens to address this challenge. Audio data collected from a controlled environment at Bowen University's poultry research farm was analyzed to detect respiratory symptoms in poultry birds.

---

## Table of Contents
1. [Introduction](#introduction)
2. [Methodology](#methodology)
   - [Loading Data](#loading-data)
   - [Noise Reduction](#noise-reduction)
   - [Feature Extraction](#feature-extraction)
   - [Application in Respiratory Disease Detection](#application-in-respiratory-disease-detection)
   - [Frequency Range Determination](#frequency-range-determination)
   - [Bandpass Filter Design with FIR Method](#bandpass-filter-design-with-fir-method)
3. [Results and Discussion](#results-and-discussion)
4. [Conclusion](#conclusion)

---

## Introduction
In the realm of agricultural innovation, acoustic filters stand out as a transformative technology with the potential to redefine poultry health management. These devices, adept at selectively isolating desired frequencies while mitigating background noise, offer a novel solution to the longstanding challenge of detecting respiratory diseases in poultry populations. This report delves into the application of acoustic filters in the context of avian health monitoring.

---

## Methodology

### Loading Data
The initial step involved loading audio data captured in a poultry house using high-quality microphones. These recordings were converted from analog to digital format using an Analog-to-Digital Converter (ADC).

### Noise Reduction
To enhance the quality of the audio data, a noise reduction process was applied involving the following steps:
1. **Frame-Based Processing**: Segmenting the continuous audio signal into small, overlapping frames.
2. **Fast Fourier Transform (FFT)**: Transforming each frame of the audio signal from the time domain to the frequency domain.
3. **Noise Estimation**: Estimating the noise level in the frequency domain.
4. **Spectral Subtraction**: Subtracting the estimated noise spectrum from the signal spectrum in each frame.
5. **Clipping**: Clipping any negative values resulting from the subtraction to zero.
6. **Inverse FFT (IFFT)**: Transforming the modified frequency-domain data back to the time domain.
7. **Filtered Audio Files**: Saving the final noise-reduced audio signal as new files and generating visual plots comparing the original and filtered signals.

### Feature Extraction
Analyzing the frequency components of the audio signals involved applying a Fourier Transform to the denoised signals. The following features were extracted:
- **Fast Fourier Transform (FFT)**
- **Spectral Centroid**
- **Spectral Bandwidth**
- **Spectral Roll-off**

### Application in Respiratory Disease Detection
Features were used in machine learning models to recognize patterns indicative of respiratory diseases in poultry. This helped differentiate normal from abnormal sounds, enabling early detection and intervention.

### Frequency Range Determination
A spectrogram analysis was performed to determine the frequency range of interest, focusing on the range of 11-12 kHz.

### Bandpass Filter Design with FIR Method
The bandpass filter was designed using the FIR method, with defined passband frequencies, stopband attenuation, and transition width. MATLAB's `fir1` function was used to design the filter, and `freqz` was used for analysis.

---

## Results and Discussion
Reduction in noise of any audio signal results in a significant drop in frequency but heightens the accuracy of any methodology performed. Spectrograms provided a visual representation of the frequency content of audio signals over time. Filtered power spectra showed increased power within the 11-12 kHz range, indicating successful isolation of the desired frequencies.

---

## Conclusion
The project successfully developed an integrated audio analytics framework for respiratory disease detection in poultry, leveraging advanced signal processing techniques and machine learning algorithms. By effectively reducing noise, extracting relevant features, classifying frequency ranges, and visualizing spectrograms, the system enables accurate and timely identification of disease symptoms in poultry farms. The framework's potential impact extends to proactive health management, minimizing economic losses, and advancing research in avian health.

Moving forward, further enhancements such as IoT integration, model optimization, and field deployment will strengthen the system's efficacy and applicability, empowering stakeholders to ensure poultry welfare and farm productivity in a sustainable manner.
