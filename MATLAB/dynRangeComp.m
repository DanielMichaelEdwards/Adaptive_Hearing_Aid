clc;
close all;

%% Dynamic Range compression stuff

input = [16.75 21.75 26.8 31.8 36.8 41.8 46.8 51.8 56.8 61.8 66.8 71.8 76.8 81.8 86.8 91.8 96.8 101.6 106.8 111.8 116.8];
output = [26.75 31.8 36.8 41.8 45 46.7 48.4 50.05 51.75 53.4 55.1 56.75 58.5 60.1 61.8 63.5 65.14 66.8 68.5 70.17 71.85];


figure;
plot(input, output);
xlabel('Input (dBSPL)');
ylabel('Output (dBSPL');