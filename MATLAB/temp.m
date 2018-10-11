clear all;
clc;
%% This is used to mess around in
wh = 10000*2*pi;    %Highest frequency to be processed
T = 1/(2*(wh/(2*pi)));  %Sampling frequency
wpprime = 3000*2*pi
wsprime = 4500*2*pi
Gpprime = -0.00001;     %Passband gain in dB
Gsprime = -8 ;          %Stopband gain in dB

wp = (2/T)*tan((wpprime*T)/(2));
ws = (2/T)*tan((wsprime*T)/(2));


%Get the order of the filter

n = (log10((10^(-(Gsprime)/(10)) - 1)/(10^(-(Gpprime)/(10)) - 1)))/(2*log10((ws)/(wp)));
n = ceil(n)

%Get the cutoff frequency

wc = (ws)/((10^(-(Gsprime)/(10)) - 1)^(1/(2*n)));

%Get the poles of the system

poles = 1:n;

for k = 1:n
   poles(k) = cos((pi/(2*n))*((2*k) + n - 1)) + 1j*sin((pi/(2*n))*((2*k) + n - 1));
end

syms s;

Ha = 1;

for i = 1:n
   Ha = Ha*(1/(s - poles(i))); 
end

transWc = s/wc;
Hanew = subs(Ha, s, transWc);

syms z;

BTrans = (2/T)*((z-1)/(z+1));

Hz = subs(Hanew, s, BTrans);
syms w;

freqRes = exp(1j*w*T);

Hjw = subs(Hz, z, freqRes);
HdB = 20*log10(abs(Hjw));


HdBPlot = 1:200:wh;
wPlot = 1:200:wh;
count = 1;
for i = 1:200:wh
   HdBPlot(count) = subs(HdB,w,i);
   count = count + 1;
end

disp('Plot');
figure;
plot(wPlot, HdBPlot);
ylabel('|Magnitude (dB)|');
xlabel('\omega (rad/s)');
%set(gca, 'YScale','log');

% figure;
% fplot(HdB, [1, wh])
% 

