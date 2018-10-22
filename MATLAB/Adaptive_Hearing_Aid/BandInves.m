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

filtX = [250 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000];

band1 = [20 20.8 20.9 21.04 21 20.76 20.8 21 21.05 20.84 20.75 20.96 21.04 20.9 20.82 21.05 20.2];
pb1 = pchip(filtX, band1, xq);

band2 = [19.3 20.9 20.85 20.93 20.9 20.8 20.95 20.95 22.1 21.14 21 20.9 20.98 21.04 20.98 20.95 20.2];
pb2 = pchip(filtX, band2, xq);

band3 = [19.8 20.85 20.8 20.5 20.58 21.2 23.5 21.15 20.9 20.95 21.1 21.05 20.9 21.02 20.8 21 20.4];
pb3 = pchip(filtX, band3, xq);

band4 = [19.8 20.34 20.3 20.35 20.95 21.35 21.36 21.43 22.8 21.15 21.05 21 22.85 21.05 21.1 21 21.35];
pb4 = pchip(filtX, band4, xq);

band5 = [18.95 20.1 20.27 20.3 20.95 21.7 21.65 23 21 20.95 20.9 20.95 20.92 20.9 21.3 20.95 20.1];
pb5 = pchip(filtX, band5, xq);

band6 = [18.95 19.5 19.6 21.3 21.9 22.05 23.4 21.2 21.19 22.05 20.9 21.2 22.5 21 20.95 21.2 20.3];
pb6 = pchip(filtX, band6, xq);

band7 = [18.2 19.25 19.3 21 22.3 23.95 21.2 21.8 21 21 21.2 21.1 22.9 21.1 21.3 20.9 20];
pb7 = pchip(filtX, band7, xq);

band8 = [18.7 17.5 21.8 23.5 23.5 21.9 21.5 21.3 22.8 21 23 20.9 22.5 20.8 23.3 21.2 20.9];
pb8 = pchip(filtX, band8, xq);

matchError1 = abs(minus(pb1,  pIG));
matchError2 = abs(minus(pb2,  pIG));
matchError3 = abs(minus(pb3,  pIG));
matchError4 = abs(minus(pb4,  pIG));
matchError5 = abs(minus(pb5,  pIG));
matchError6 = abs(minus(pb6,  pIG));
matchError7 = abs(minus(pb7,  pIG));
matchError8 = abs(minus(pb8,  pIG));

figure;
plot(xq, matchError1);
hold on;
plot(xq, matchError2);
hold on;
plot(xq, matchError3);
hold on;
plot(xq, matchError4);
hold on;
plot(xq, matchError5);
hold on;
plot(xq, matchError6);
hold on;
plot(xq, matchError7);
hold on;
plot(xq, matchError8);
xlabel('Frequency (Hz)');
ylabel('Error (dB)');
legend('1 Band', '2 Bands', '3 Bands', '4 Bands', '5 Bands', '6 Bands', '7 Bands', '8 Bands');

meanErrors = 1:8;
meanErrors(1) = mean(matchError1);
meanErrors(2) = mean(matchError2);
meanErrors(3) = mean(matchError3);
meanErrors(4) = mean(matchError4);
meanErrors(5) = mean(matchError5);
meanErrors(6) = mean(matchError6);
meanErrors(7) = mean(matchError7);
meanErrors(8) = mean(matchError8);

figure;
plot(meanErrors);
xlabel('Number of Filters');
ylabel('Mean Matching Error (dB)');

%plot(xq, pb1);

%plot(xq, p);

mean(pIG(81:101))
    

