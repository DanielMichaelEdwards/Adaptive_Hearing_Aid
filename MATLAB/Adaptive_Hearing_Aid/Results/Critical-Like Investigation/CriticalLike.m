clc;
clear all;
%% Investigate the effects of the frequency bands
%Set up audiogram
Fh = 8000;
steps = 50;
audioX = [250 500 1000 2000 4000 8000];
audioConY = [-50 -45 -45 -60 -50 -60];
xq = 0:25:8000;
pCond = pchip(audioX, audioConY, xq);

audioNormY = [0 -8 -5 0 -10 0];
pNorm = pchip(audioX, audioNormY, xq);
% 
% figure;
% plot(xq, pNorm);
% hold on;
% plot(xq, pCond);
% xlabel('Frequency (Hz)');
% ylabel('Hearing Loss (dB)');
% legend('Normal', 'Conductive');

audioConY = -1*audioConY;

H3FA = (audioConY(2) + audioConY(3) + audioConY(4))/3;
X = 0.15*H3FA;
ki = [-17 -8 1 -1 -2 -2 -2];

IG = 1:length(audioConY);
for i=1:length(audioConY)
   IG(i) = X + (0.31*H3FA) + ki(i);
end

pIG = pchip(audioX, IG, xq);

% figure;
% plot(xq, pIG);
% xlabel('Frequency (Hz)');
% ylabel('Insertion Gain (dB)');

filtX = [25 50 100 200 250 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000];

band8 = [5.4 6.15 7.8 11.2 12.8 12.75 22 22.9 21.2 22.1 21.3 21.3 20.8 22 21.25 20.5 21.2 21.4 20.6 20.75 20.75];

pb8 = pchip(filtX, band8, xq);

matchError8 = abs(minus(pb8,  pIG));

figure;
plot(xq, matchError8);
xlabel('Frequency (Hz)');
ylabel('Matching Error (dB)');

meanError = mean(matchError8)
maxError = max(matchError8)


mean(pIG(173:319))
    

