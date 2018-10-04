clc;
%% This script is just to verify that I can implement:
%IIR filter using bilinear transforms
%FIR filter using a bunch of different windows
%% Generate a noisy signal
%The code on generating the noisy signal and FFT is adapted from MATLABs resource on FFT 
clear all;
Fh = 10000;
T = 1/(2*Fh);         % Sampling period  
Fs = 1/T;             % Sampling frequency       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector
freq = 3500;
freqN = 8000;

S = 0.7*sin(2*pi*freq*t) + sin(2*pi*freqN*t);
X = S + 2*randn(size(t));

plot(1000*t(1:50),X(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')


%% Get the FFT of the signal
Y = fft(X);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%% IIR - Bilinear LPF
steps = 200;

[w, HLPF] = iirLPFModel(3000, 4500, 2, -8, Fh, steps);

figure;
plot(w, HLPF);
ylabel('|Magnitude (dB)|');
xlabel('\omega (rad/s)')

%% IIR - Bilinear BPF

% [w, HBPF] = iirBPFModel(3000, 1500, 4000, 5500, 2, -8, Fh, steps);
% 
% figure;
% plot(w, HBPF);
% ylabel('|Magnitude (dB)|');
% xlabel('\omega (rad/s)')
