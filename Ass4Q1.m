%Peter Al-Ahmar 100961570
%Assignment 4 Question 1

close all;
clear 
%setting up the circuit


G1 = 1/1;%resistor 1 = 1
c = 0.25;%capacitor = 0.25
G2 = 1/2; %resistor 2 = 2
L = 0.2; %Inductor =0.2
G3 = 1/10; %resistor 3 = 10
alpha = 100;
G4 = 1/0.1; %Resistor 4
Go = 1/1000; %resistor 0 = 1000

%creating G matrix

G=  [1   0     0  0  0  0  0;
    -G2 G1+G2 -1  0  0  0  0;
     0    1    0 -1  0  0  0;
     0    0    -1 G3 0  0  0;
     0    0    0  0  -alpha 1  0;
     0    0    0  G3 -1 0  0;
     0    0    0  0   0 -G4 G4+Go];
 
 %creating C matrix
 
 C = [0 0 0 0 0 0 0;
     -c c 0 0 0 0 0;
      0 0 -L 0 0 0 0;
      0 0 0 0 0 0 0;
      0 0 0 0 0 0 0;
      0 0 0 0 0 0 0;
      0 0 0 0 0 0 0;];

Vdc = zeros(7,1); %DC voltage matrix
Vac = zeros(7,1); %AC voltage matrix
F = zeros(7,1); %F matrix
 
 
for v = -10:0.1: 10 %DC sweep
    F(1,1) = v;
    Vdc = G\F;
    
    figure(1);
    plot(v, Vdc(7,1), 'r.')
    hold on
    
    plot(v, Vdc(4,1), 'b.')
    hold on
    title('Vo(red) and V3(blue) -- DC case') 
end

w = logspace(1,2,500);
F(1) = 1;

for i = 1:length(w)
    
    Vac = (G + C *1j * w(i))\F;
    figure(2);
    semilogx(w(i), abs(Vac(7,1)), 'g.')
    hold on
    title('Vo in AC case')
    
    dB = 20*log(abs(Vac(7,1))/F(1));
    figure(3);
   
    plot(i, dB, 'c.')
    hold on
    title('AC plot of Vo in dB')
    
end

pii = pi;
ACcase =  0.25 + 0.05.*randn(1,1000);
Vgain = zeros(1000,1);

for k = 1:length(Vgain)
    c = ACcase(k);
    C(2,1) = -c;
    C(2,2) = c;
    Vac = (G + C *1j * pii)\F;
    Vgain(k,1) = abs(Vac(7,1))/F(1);   
end
figure(4);
hist(Vgain,50);
