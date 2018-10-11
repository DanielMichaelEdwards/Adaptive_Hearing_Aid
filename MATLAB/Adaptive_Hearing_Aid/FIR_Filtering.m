clc;
clear all;
%% Parameters for Simulink
Fs = 20000;
T = 1/Fs;
G = 10^(2/20);


%%
syms n;
fs = 2000;
T = 1/fs;
order = 6;
N0 = order + 1;
M = (N0-1)/2;

fcl = 350;
fcu = 650;
wcl = fcl*2*pi;
wcu = fcu*2*pi;


% n = -N0:1:N0;
% 
% hdBP = ((wcu/pi).*(sin((wcu*n)/pi)./((wcu*n)/pi))) - ((wcl/pi).*(sin((wcl*n)/pi)./((wcl*n)/pi)));
% 
% % Define sinc(0)
% hdBP(N0+1) = (wcu/pi) - (wcl/pi);
% 
% figure;
% plot(n, hdBP);
% title('Impulse Response');
% xlabel('n');
% ylabel('Amplitude');
% 
% %Hamming Window
% 
% wind = zeros(1,(2*N0) + 1);
% 
% for k = 1:1:(2*N0) + 1
%     if abs(n(k)) <= M
%        wind(k) = 0.54 + 0.46*cos((2*pi*n(k))/(N0-1));
%     end
% end
% 
% figure;
% plot(n, hdBP);
% title('Window Function');
% xlabel('n');
% ylabel('Amplitude');
% 
% %Apply the windowing function
% h = wind .* hdBP;
% 
% figure;
% plot(n, hdBP);
% title('Applied Window Function Impulse Response');
% xlabel('n');
% ylabel('Amplitude');
% 
% %Apply delay to make it causal.
% 
% hCaus = -N0:1:N0;
% nNew = -N0:1:N0;
% 
% for i = -N0:1:N0
%    hCaus(i) = h(N0 + i-M);
% end
% 
% figure;
% plot(nNew, hCause);
% title('Delayed Impulse Response');
% xlabel('n');
% ylabel('Amplitude');

syms n;

%hdBP = (wcu/pi)*(sinc((wcu*n)/pi)) - (wcl/pi)*(sinc((wcl*n)/pi));
hdBP = (0.5)*(sinc((pi*(n))/(2)));
wind = 0.54 + 0.46*cos((2*pi*n)/M);
%wind = 1;
h = hdBP * wind;

hCaus = subs(h, n, n-M);




hCaus = (0.42 - 0.5*cos(n*pi/60) + 0.08*cos(n*pi/30))*(0.7*sinc(0.7*(n - 60)) - 0.3*sinc(0.3*(n-60)) );
%hCaus = (0.5)*(sinc((pi*(n-3))/(2)))

syms z;
Hz = 0;
order = 6;
for i = 0:0.1:1
    %temp = (0.42 - 0.5*cos((i*pi)/(60)) + 0.08*cos((i*pi)/(30)))*(0.7*sinc(0.7*(i - 60)) - 0.3*sinc(0.3*(i - 60)));
    %Account for sinc(0) error
    %num = i + 0.1*10^(-10);
    num = i;
    temp = subs(hCaus, n, num);
    Hz =  Hz + (temp*z^(-i));
end

syms w;

freqRes = exp(1j*w*T);

Hjw = subs(Hz, z, freqRes);

HdB = 20*log10(abs(Hjw));

steps = 50;

wPlot = 1:steps:2*pi*fs;
HdBPlot = 1:steps:2*pi*fs;
count = 1;
for i = 1:steps:2*pi*fs
   HdBPlot(count) = subs(HdB,w,i);
   count = count + 1;
end

figure;
plot(wPlot, HdBPlot);