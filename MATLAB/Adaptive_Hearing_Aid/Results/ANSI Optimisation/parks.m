clc;
clear all;
close all;
%% Use the Parks algorithm to get the order of the filter - then you can calculate the group delay
fs1 = [10 60 123 153 361 900 2020 4250];

fp1 = [90 145 223 353 561 1250 2220 4450];

fp2 = [140 223 353 561 1100 2220 4450 8976];

fs2 = [240 323 535 761 1300 2420 4650 9176];

order = 1:length(fs1);


rp = 1;           % Passband ripple
rs = 40;          % Stopband ripple
Fs = 20000;        % Sampling frequency
a = [1 0];        % Desired amplitudes

dev = [(10^(rp/20)-1)/(10^(rp/20)+1)  10^(-rs/20)]; 
for i=1:length(order)
    f = [fs1(i) fp1(i)];
    [n1,fo,ao,w] = firpmord(f,a,dev,Fs);
    f = [fp2(i) fs2(i)];
    [n2,fo,ao,w] = firpmord(f,a,dev,Fs);
    if n1 > n2
        order(i) = n1;
        disp('L');
    else
        order(i) = n2;
        disp('H');
    end
        
end 
order
grpDelay = order./(2*Fs);
grpDelay = 1000.*grpDelay
sum(order)

% 
% f = [19 23]
% [n,fo,ao,w] = firpmord(f,a,dev,fs);
% b = firpm(n,fo,ao,w);
% freqz(b,1,1024,fs)
% title('Lowpass Filter Designed to Specifications')