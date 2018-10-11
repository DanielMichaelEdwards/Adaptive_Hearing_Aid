function [wPlot, HdBVec] = iirBPFModel (fp1, fs1, fp2, fs2, GaindB, GainsdB, fh, steps)
%% 
%This is a model of a BPF using the Infinite Impulse method using a
%bilinear transform
disp('%%%%%%%%%%%%% BANDPASS FILTER %%%%%%%%%%%%%');
wh = fh*2*pi;    %Highest frequency to be processed
T = 1/(2*(wh/(2*pi)));  %Sampling frequency
wp1prime = 2*pi*fp1;    % Digital passband frequency 1
wp2prime = 2*pi*fp2;    % Digital passband frequency 2
ws1prime = 2*pi*fs1;    % Digital stopband frequency 1
ws2prime = 2*pi*fs2;    % Digital stopband frequency 2
disp('Lower passband frequency (rad/s)');
disp(wp1prime);
disp('Upper passband frequency (rad/s)');
disp(wp2prime);
disp('Lower stopband frequency (rad/s)');
disp(ws1prime);
disp('Upper stopband frequency (rad/s)');
disp(ws2prime);
Gpprime = -0.0000001;        % Band gain (dB) - used for the model
Gsprime = GainsdB - GaindB;  % Stopband gain (dB). Keep as zero so that it doesn't interfere with other frequency bands.


wp1 = (2/T)*tan((wp1prime*T)/(2));
ws1 = (2/T)*tan((ws1prime*T)/(2));
wp2 = (2/T)*tan((wp2prime*T)/(2));
ws2 = (2/T)*tan((ws2prime*T)/(2));
% wp1 = wp1prime;
% wp2 = wp2prime;
% ws1 = ws1prime;
% ws2 = ws2prime;


%Get the order of the filter

n1 = (log10((10^(-(Gsprime)/(10)) - 1)/(10^(-(Gpprime)/(10)) - 1)))/(2*log10((ws1)/(wp1)));
n2 = (log10((10^(-(Gsprime)/(10)) - 1)/(10^(-(Gpprime)/(10)) - 1)))/(2*log10((ws2)/(wp2)));

n = n1;
if n2>n1
   n = n2;
end
n = ceil(n);
disp('Order:');
disp(n);

%Get the poles of the system

poles = 1:n;

for k = 1:n
   poles(k) = cos((pi/(2*n))*((2*k) + n - 1)) + 1j*sin((pi/(2*n))*((2*k) + n - 1));
end

syms s;

Ha = 10^(GaindB/20);

for i = 1:n
   Ha = Ha*(1/(s - poles(i))); 
end

%transWc = (s^2 + wp1prime*wp2prime)/(s*(wp2prime - wp1prime));
B = wp2prime - wp1prime;
transWc = (1/B)*(s + ((wp1prime*wp2prime)/(s)));
Hanew = subs(Ha, s, transWc);

syms z;

BTrans = (2/T)*((z-1)/(z+1));

Hz = subs(Hanew, s, BTrans);
syms w;

freqRes = exp(1j*w*T);

Hjw = subs(Hz, z, freqRes);
HdB = 20*log10(abs(Hjw));

HdBPlot = 1:steps:wh;
wPlot = 1:steps:wh;
count = 1;


for i = 1:steps:wh
   HdBPlot(count) = subs(HdB,w,i);
   wPlot(count) = (2/T)*tan((i*T)/(2));
   count = count + 1;
end

HdBVec = HdBPlot;
end