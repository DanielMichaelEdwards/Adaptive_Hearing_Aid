%% Helper file for some aspects of the ANSI standard
close all;
thirdOctaveMidFrequencyArray = zeros(1,18);
lowerFreqLimit = 245;
upperFreqLimit = 8000;
midfrequency = 245;
bandNumber = 24:41;
index = 1;

while midfrequency >= lowerFreqLimit && midfrequency <= upperFreqLimit
    midfrequency = midbandFrequencyCalculations(bandNumber(index));
    thirdOctaveMidFrequencyArray(1, index) = midfrequency;
    index = index + 1;
end

%%
format long g
thirdOctaveMidFrequencyArray = round(thirdOctaveMidFrequencyArray,5,'significant');
Band = bandNumber';
fm = thirdOctaveMidFrequencyArray';
k = 0;
Lowerfreq = fm.*2^(-1*(1+k)/6);
Upperfreq = fm.*2^((1+k)/6);
Fstop1 = fm.*2^((8+k)/6);
Fstop2 = fm.*2^(-1*(8+k)/6);

Lowerfreq = round(Lowerfreq);
Upperfreq = round(Upperfreq);
Fstop1 = round(Fstop1);
Fstop2 = round(Fstop2);

T = table(Band, fm, Lowerfreq, Upperfreq, Fstop2, Fstop1)
% Sample time for use in the simulink simulations
T = 1/44100
%%
% This script simulates an audiogram

frequencies = [250, 500, 1000, 2000, 3000, 4000, 6000, 8000];
% dBValuesAudiogram = [63, 66, 70, 77, 77, 80, 81, 81]; 
dBValuesAudiogram = [35, 40, 55, 65, 68, 70, 71, 73]; 
H = dBValuesAudiogram
% dBValuesAudiogram1 = [30, 38, 38, 45, 49, 56, 50, 51]; 


% Plot Audiogram 
plot(frequencies, dBValuesAudiogram,'-o')
% hold on;
grid on;
% plot(frequencies, dBValuesAudiogram1,'-o')
xlim([0 8500])
ylim([0 100])
xlabel('Frequency (Hz)')
ylabel('Hearing Level (dB)')
set(gca,'xaxisLocation','top', 'Ydir', 'reverse')

%%
% insertionGainNAL-R
% dBValuesAudiogram = dBValuesAudiogram*-1;
H3FA = (dBValuesAudiogram(2) + dBValuesAudiogram(3) + dBValuesAudiogram(4))/3;
if H3FA < 60
    X = 0.15*H3FA;
elseif H3FA >= 60
    X = 0.15*H3FA + 0.2*(H3FA-60);
end
C = [-17, -8, 1, -1, -2, -2, -2, -2];
insertionGain = zeros(1, length(dBValuesAudiogram));
PC = [0, 0, 0, 0, 0, 0, 0, 0;
      4, 3, 0, -2, -2, -2, -2, -2;
      6, 4, 0, -3, -3, -3, -3, -3;
      8, 5, 0, -5, -5, -5, -5, -5;
      11, 7, 0, -6, -6, -6, -6, -6;
      13, 8, 0, -8, -8, -8, -8, -8;
      15, 9, 0, -9, -9, -9, -9, -9];

if H(4) <= 90
     PC = [0, 0, 0, 0, 0, 0, 0, 0];
elseif H(4) > 90 && H(4) <= 95
     PC = [4, 3, 0, -2, -2, -2, -2, -2];
elseif H(4) > 95 && H(4) <= 100
     PC = [6, 4, 0, -3, -3, -3, -3, -3;];
elseif H(4) > 90 && H(4) <= 105
     PC = [8, 5, 0, -5, -5, -5, -5, -5];
elseif H(4) > 90 && H(4) <= 110
     PC = [11, 7, 0, -6, -6, -6, -6, -6];
elseif H(4) > 110 && H(4) <= 115
     PC = [13, 8, 0, -8, -8, -8, -8, -8];
elseif H(4) > 115 && H(4) <= 120
     PC = [ 15, 9, 0, -9, -9, -9, -9, -9];
end
  
for i = 1:length(frequencies)
    insertionGain(1, i) = X + 0.31.*dBValuesAudiogram(i) + C(i)+ PC(i);
end

% Plot insertion Gain graph
% Plot Audiogram 

figure
plot(frequencies, insertionGain,'-o')
xlim([125 8500])
ylim([0 50])
xlabel('Frequency (Hz)')
ylabel('Insertion Gain (dB)')
%%
%Interpolate values so the gain constants can be worked out
figure;
xq = 0:1:8000;
vq2 = interp1(frequencies,insertionGain,xq,'spline');
plot(frequencies,insertionGain,'o',xq,vq2,':.')
xlim([125 8500])
ylim([0 50])
title('Spline Interpolation');
%%
%Determine the gain values according to audiogram. 
frequencies;
fmRounded = round(fm);
requiredGainDB = zeros(16, 1);
for i = 1:16
    freq = fmRounded(i);
    requiredGainDB(i, 1) = vq2(freq);
end
requiredGainDB
fmRounded
gainConsts = 10.^(requiredGainDB/10)
%%
% This section just defines some values for use in the simulink simulation
fs = 44100;