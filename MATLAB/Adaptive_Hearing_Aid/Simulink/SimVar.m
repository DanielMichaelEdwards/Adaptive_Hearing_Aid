clear all;
clc;
%Simulink Variables
Fs = 20000;
T = 1/Fs;
order = 60;
ripple = 1;

G1dB = 0;
G1 = 10^(G1dB/10);

G2dB = 1.16;
G2 = 10^(G2dB/10);

G3dB = 6.4;
G3 = 10^(G3dB/10);

G4dB = 15.44;
G4 = 10^(G4dB/10);

G5dB = 23.3;
G5 = 10^(G5dB/10);

G6dB = 22.05;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
G6 = 10^(G6dB/10);

G7dB = 21.06;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
G7 = 10^(G7dB/10);

G8dB = 21;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
G8 = 10^(G8dB/10);