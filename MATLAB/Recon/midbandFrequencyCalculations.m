function a = midbandFrequencyCalculations(bandNumber)
% ANSI defined function to calculate midband frequencies for bandpass filters
    fr = 1000;
    a = (2.^((bandNumber-30)/(3)))*fr;
end
