clc;
close all;

%% Dynamic Range compression stuff

input = [16.8 26.8 36.8 46.8 56.8 66.8 76.8 86.8 96.8 106.8 116.8];
output = [36.8 46.8 56.8 64.5 66.7 68.7 70.75 72.75 74.75 76.75 78.75];


figure;
plot(input, output);