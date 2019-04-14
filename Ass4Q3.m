%Peter Al-Ahmar 100961570
%Assignment 4 Question 3

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

G = [1, 0, 0, 0, 0, 0, 0, 0;
    -G1, G1+G2, -1, 0, 0, 0, 0, 0;
    0, 1, 0, -1, 0, 0, 0, 0;
    0, 0, -1, G3, 0, 0, 0, 1;
    0, 0, 0, 0, -alpha, 1, 0, -alpha;
    0, 0, 0, G3, -1, 0, 0, 1;
    0, 0, 0, 0, 0, -G4, G4+G0, 0;
    0, 0, 0, 0, 0, 0, 0, 1];

