clc;
%% Directionality

freq = 1000;
N = 3;
c = 343;
L = 0.5;
d = L/N;
angleRange = 180;
angles = 1:angleRange;
w = 1/N;

D = zeros(1,180);
for i = 1:angleRange    
    for n = (-(N-1)/2):((N-1)/2)
        D(i) = D(i) + exp(1j*((2*pi*freq)/(c))*n*d*cosd(angles(i)));
    end
end

plot(abs(D))