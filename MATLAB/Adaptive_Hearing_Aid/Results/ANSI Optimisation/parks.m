clc;
clear all;
close all;
%% Use the Parks algorithm to get the order of the filter - then you can calculate the group delay
fs1 = [1 30 60 80 153 507 1203 2610];

fp1 = [22 45 90 180 353 707 1403 2810];

fp2 = [45 90 180 353 707 1403 2810 8200];

fs2 = [145 190 280 535 907 1603 3010 8400];

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
    else
        order(i) = n2;
    end
        
end 
order
grpDelay = order./(2*Fs);
grpDelay = 1000.*grpDelay


% 
% f = [19 23]
% [n,fo,ao,w] = firpmord(f,a,dev,fs);
% b = firpm(n,fo,ao,w);
% freqz(b,1,1024,fs)
% title('Lowpass Filter Designed to Specifications')