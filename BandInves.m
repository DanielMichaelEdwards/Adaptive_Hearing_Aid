clc;
clear all;
%% Investigate the effects of the frequency bands
%Set up audiogram
Fh = 8000;
steps = 50;
audioX = [250, 500, 1000, 2000, 4000, 8000];
audioY = [-40, -40, -50, -60, -70, -80];

figure;
plot(audioX, audioY);
set(gca, 'XScale', 'log')

G = mean(audioY);

d = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',20, 250, 8000,10000, -1*G - 3, -1*G, -1*G - 3);
Hd = design(d, 'butter');

freqz(Hd);
    

