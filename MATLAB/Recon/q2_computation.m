clc;
clear all;
close all;
%%
%This script is used to generated computations for the signals and systems
%lab calculations to verify the correctness of the hand-done calculations.
%each section coresponds to sections in the course notes.

%created by Christopher Maree - 1101946 and Brandon Verkerk - 875393

%This version is for question 2, generating the required values for the
%second system filter

%Note that for each section, the axis is shifted after the creation of the
%hamming window to simplify the calculation

%%
%First, we defined the given desinition of the system
disp('***System properties to be designed***')
T = 0.00005 %system sampling period
fs = 1/T;
systemOrder = 24 %system order
N0 = systemOrder + 1 %N0 of the system
M = (N0 - 1)/2 %M of the system



%Next, we need to define a range over which the system will be generated.
%this is used for the creation of the bode of the system and the filter

%Note that know that the region will only operate from 0->24 at the end of
%the day but a larger range enables one to see the filter responce over a
%wider region
n = -25:1:25;

%Next, the fourier transfrom of the rectangle is taken. this was done by hand
%and defined below interms of a sinc function (sinx/x)
hd = (1/6).*sin(n*(pi/6))./(n*(pi/6));

%as we did not use the built in sinc function, one needs to now define the
%value for sinc(0) this can then be explisitly filled as 1*amplitude of
%system. %31 is the centre of the system
hd(26) = 1/6; 

%we now plott the system to show the window
figure
scatter(n,hd);
hold on
title('Rectangular window in the time domain');
grid on;
xlabel('Frequency')
ylabel('Magnitude')
plot(n,hd);
hold off


%next, the hamming window is generated. for this, we will run on purly
%positive values, then shift it later. the size of this vector is 1->61 to
%accomidate the zeroth position in the n vector

%start by filling the hamming window with zeros and then fill back later
wh = zeros(1,51);
    
%next, we itterate over the the full n space to calculate the hamming
%window at each point.
for k = 1:1:51 
    %query the magnitude each k value to ensure that we are only generating
    %the filter once. this is a periodic function so we need only one
    %period
    if abs(n(k)) <= M
       wh(k) = 0.54 + 0.46*cos((2*pi*n(k))/(N0-1));
    end
end

%Next, we plot the hamming window generated
figure
scatter(n, wh);
hold on
title('Hamming window plot')
grid on
xlabel('Frequency')
ylabel('Magnitude')
plot(n, wh);
hold off
    
%The window is now applied, using the standard equation from the notes

nH = hd.*wh;
    
figure
scatter(n, nH);
hold on
title('Window applied to system, before shifting')
grid on
xlabel('Frequency')
ylabel('Magnitude')
plot(n, nH);
hold off


%Last step is to apply a transformation to the generated output, to
%simulate the shift done before. the order of this is inconsequential. note
%that if it was done before then the equation used to generate the hamming
%window would have changed
shiftedAxis = -25+M:1:25+M;

figure
scatter(shiftedAxis, nH);
hold on
title('Final output of the system')
grid on
xlabel('Frequency')
ylabel('Magnitude')
plot(shiftedAxis, nH);
hold off
