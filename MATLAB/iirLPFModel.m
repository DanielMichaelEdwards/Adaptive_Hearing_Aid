function [wPlot, HdBVec] = iirLPFModel (fp, fs, GaindB, GainsdB, fh, steps)

%% This is used to mess around in
disp('%%%%%%%%%%%%% LOW PASS FILTER %%%%%%%%%%%%%');
wh = fh*2*pi;    %Highest frequency to be processed
T = 1/(2*(wh/(2*pi)));  %Sampling frequency
wpprime = fp*2*pi;
wsprime = fs*2*pi;
disp('Passband frequency (rad/s)');
disp(wpprime);
disp('Stopband frequency (rad/s)');
disp(wsprime);
Gpprime = -0.0000001;     %Passband gain in dB
Gsprime = GainsdB - GaindB;  %Stopband gain in dB

wp = (2/T)*tan((wpprime*T)/(2));
ws = (2/T)*tan((wsprime*T)/(2));


%Get the order of the filter

n = (log10((10^(-(Gsprime)/(10)) - 1)/(10^(-(Gpprime)/(10)) - 1)))/(2*log10((ws)/(wp)));
n = ceil(n);
disp('Order: ');
disp(n);

%Get the cutoff frequency - pass band specification
wc = (wp)/((10^(-(Gsprime)/(10)) - 1)^(1/(2*n)));
disp('Cut-off frequency:   ');
disp(wc);

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

transWc = s/wc;
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

