clear all;
clc;
%Simulink Variables
Fs = 20000;
T = 1/Fs;
order = 60;
ripple = 1;

G1dB = 43.08;
G1 = 10^(G1dB/10);

G2dB = 55.55;
G2 = 10^(G2dB/10);

G3dB = 63.09;
G3 = 10^(G3dB/10);

G4dB = 68.05;
G4 = 10^(G4dB/10);

G5dB = 71.7;
G5 = 10^(G5dB/10);

G6dB = 74.88                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          G8dB = 79.4;
G8 = 10^(G8dB/10);