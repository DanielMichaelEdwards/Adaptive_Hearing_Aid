clc;
%% This is the Delay-Sum implementation. 
%Advantages:
%   Simple
%Disadvantages:
%   Low frequency performance
%   Narrow Band
%Characteristics:
%   Fixed
%   Incoherant Noise Condition
%   Broadside
%% Directionality

freq = 1000;
N = 10;
c = 343;
d = 0.15;
phi = 45;
phiPrime = 90;
angleRange = 180;
angles = 1:angleRange;

D = zeros(1,180);
for i = 1:angleRange    
    for n = (-(N-1)/2):((N-1)/2)
        D(i) = D(i) + exp(1j*((2*pi*freq*(n-1)*d*(cosd(angles(i)) - cosd(phiPrime)))/(c)));
        %abs(exp(1j*2*pi*freq*(n-1)*d*(cosd(angles(i)) - cosd(phiPrime))))
        %cosd(angles(i)) - cosd(phiPrime)
    end
end

plot(abs(D));