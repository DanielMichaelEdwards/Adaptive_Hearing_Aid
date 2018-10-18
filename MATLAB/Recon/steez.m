clc;
clear all;
%% Calculations
close all;
thirdOctaveMidFrequencyArray = zeros(1,28);
lowerFreqLimit = 20;
upperFreqLimit = 8000;
midfrequency = 25;
bandNumber = 14:41;
index = 1;

while midfrequency >= lowerFreqLimit && midfrequency <= upperFreqLimit
    midfrequency = midbandFrequencyCalculations(bandNumber(index));
    thirdOctaveMidFrequencyArray(1, index) = midfrequency;
    index = index + 1;
end


format long g
thirdOctaveMidFrequencyArray = round(thirdOctaveMidFrequencyArray,5,'significant');
Band = bandNumber';
fm = thirdOctaveMidFrequencyArray';
k = 0;
% These commented out parameters represent the official max limits for the
% ANSI standard.
Lowerfreq = fm.*2^(-1*(1+k)/6);
Upperfreq = fm.*2^((1+k)/6);
Fstop1 = fm.*(2^((8+k)/6));
Fstop2 = fm.*(2^(1*(-8+k)/6));
% Lowerfreq = (2^(-1/10)).*fm;
% Upperfreq = (2^(1/10)).*fm;
% Fstop1 = (2^(8/10)).*fm;
% Fstop2 = (2^(-4/10)).*fm;




Lowerfreq = round(Lowerfreq);
Upperfreq = round(Upperfreq);
Fstop1 = round(Fstop1);
Fstop2 = round(Fstop2);

T = table(Band, fm, Lowerfreq, Upperfreq, Fstop2, Fstop1)


%% filter
% f = [0:1:20000];
% fs = 36000
% 
% filterArray = zeros(1,16);
% 
% for i =1:9
%     
%     Fst1 = Fstop2(i)*2/fs;
%     Fp1 = Lowerfreq(i)*2/fs;
%     Fp2 = Upperfreq(i)*2/fs;
%     Fst2 = Fstop1(i)*2/fs;
%     temp = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', ...
%     Fst1,Fp1,Fp2,Fst2,67,1,67);
%     tempFIR = design(temp,'equiripple');
%     [h,f] = freqz(tempFIR, f, fs);
%     dB = mag2db(abs(h));
%     plot(f,dB)
%     hold on;
%     info(tempFIR)
% end
% 
% for i =10:15
%     i
%     Fst1 = Fstop2(i)*2/fs;
%     Fp1 = Lowerfreq(i)*2/fs;
%     Fp2 = Upperfreq(i)*2/fs;
%     Fst2 = Fstop1(i)*2/fs;
%     temp = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', ...
%     Fst1,Fp1,Fp2,Fst2,60,1,60);
%     tempFIR = design(temp,'equiripple');
%     [h,f] = freqz(tempFIR, f, fs);
%     dB = mag2db(abs(h));
%     plot(f,dB)
%     hold on;
%     info(tempFIR)
% end
% 
% % [h,f] = freqz(filterArray(1, i), f, fs);
% % dB = mag2db(abs(h));
% % plot(f,dB)
% xlim([0 9000])
% ylim([-80 10])
% % legend('Ideal','firpm Design')
% xlabel 'Frequency (kHz)', ylabel 'Magnitude (dB)'


