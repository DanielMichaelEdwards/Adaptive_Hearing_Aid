clc;
clear all;
%% Get the tutorial one working again
syms n;
fs = 2000;
T = 1/fs;

%[0.42?0.5cos(n?60)+0.08cos(n?30)][0.7sinc(0.7(n?60))?0.3sinc(0.3(n?60))]
order = 240;
syms n;
h = (0.42 - 0.5*cos((n*pi)/60) + 0.08*cos((n*pi)/30) )*( 0.7*sinc(0.7*(n-60)) - 0.3*sinc(0.3*(n-60)));
%h = 0.5*sinc((pi*(n-3))/2);

syms z;

Hz = 0;
for i=0:6
    
%     if i == 3
%         temp = 0.5;
%         Hz = Hz + temp*(z^(-i))
%         break;
%     end
    temp = subs(h,n,i);
    Hz = Hz + temp*(z^(-i));
end

%Get the frequency response
syms w;
trans = exp(1j*w*T);
Hjw = subs(Hz, z, trans);

%Hjw = exp(-1j*3*w*T)*(0.5 + 0.49*cos(w*T) - 0.001696*cos(3*w*T));

HdB = 20*log10(abs(Hjw));

steps = 100;
wPlot = 1:steps:2*pi*fs;
HdBPlot = 1:steps:2*pi*fs;
count = 1;

for i = 1:steps:2*pi*fs
   HdBPlot(count) = subs(HdB,w,i);
   count = count + 1;
end

figure;
plot(wPlot, HdBPlot);