clc;
close all;
%% Calculate the group delay for each design

Fs = 20000;
order = [219 597 647 1498 1891];
grpDelay = 1:length(order);

for i=1:length(order)
   grpDelay(i) = order(i)/Fs;
end
grpDelay = 1000.*grpDelay;

matError = [1.36 1.34 0.87 0.72 0.23];
xaxis = 1:length(order);


filterBank = {'Uniform', 'Symmetric', 'Critical-Like', 'Octave', 'ANSI S1.11'};

figure;
yyaxis left;
plot(xaxis, matError);
ylabel('Mean Matching Error (dB)');
yyaxis right;
plot(xaxis, grpDelay);
ylabel('Group Delay (ms)')
xlabel('Filter Bank Design');
legend('Matching Error', 'Group Delay');
set(gca, 'xtick', [1:length(order)],'xticklabel', filterBank);