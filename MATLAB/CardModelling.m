a11 = 2-(2^0.5);


theta = 0:0.01:2*pi;
rho = (1-a11) + a11*cos(theta);
polar(theta,rho)