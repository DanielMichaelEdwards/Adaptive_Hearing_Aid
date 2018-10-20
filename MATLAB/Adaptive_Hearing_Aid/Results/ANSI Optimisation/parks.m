clc;
clear all;
close all;
%% Use the Parks algorithm to get the order of the filter - then you can calculate the group delay

fm = [25 32 40 50 63 80 100 125 160 200 250 315 400 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000];

fp1 = [23 29 37 47 59 75 93 117 149 187 233 294 373 467 588 746 933 1166 1493 1866 2333 2939 3732 4665 5878 7464];

fp2 = [27 34 43 54 68 86 107 134 171 214 268 338 429 536 675 857 1072 1340 1714 2144 2679 3376 4287 5359 6752 8574];

fs1 = [19 24 30 38 48 61 76 95 121 152 189 239 303 379 477 606 758 947 1213 1516 1895 2387 3031 3789 4775 6063];

fs2 = [44 55 70 87 110 139 174 218 279 348 435 548 696 871 1097 1393 1741 2176 2786 3482 4353 5484 6964 8706 10969 13929];

order = 1:length(fs1);


rp = 1;           % Passband ripple
rs = 20;          % Stopband ripple
fs = 28000;        % Sampling frequency
a = [1 0];        % Desired amplitudes

dev = [(10^(rp/20)-1)/(10^(rp/20)+1)  10^(-rs/20)]; 
for i=1:length(order)
    f = [fs1(i) fp1(i)];
    [n1,fo,ao,w] = firpmord(f,a,dev,fs);
    f = [fp2(i) fs2(i)];
    [n2,fo,ao,w] = firpmord(f,a,dev,fs);
    if n1 > n2
        order(i) = n1;
    else
        order(i) = n2;
    end
        
end 
order
% 
f = [19 23]
[n,fo,ao,w] = firpmord(f,a,dev,fs);
b = firpm(n,fo,ao,w);
freqz(b,1,1024,fs)
title('Lowpass Filter Designed to Specifications')