%Peter Al-Ahmar 100961570
%Assignment 4 Question 2

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
Vin = 1;
timestep = 1000;              % Time step

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
  
%The F matrix
F = [Vin;
      0;
      0;
      0;
      0;
      0;
      0;];

Foff = [0;
        0;
        0;
        0;
        0;
        0;
        0;];
    
V1 = zeros(7, timestep);
Vstart = zeros(7, 1);
dt = 20e-3;

%using step of 1000 as input
for i = 1:timestep

    if i < 30
        
        V1(:,i) = (C./dt+G)\(Foff+C*Vstart/dt);
    elseif i == 30
        
        V1(:,i) = (C./dt+G)\(F+C*Vstart/dt);
    else
        
        V1(:,i) = (C./dt+G)\(F+C*Vold/dt);
    end
    
    Vold = V1(:, i);
    
end

figure(1)
plot(1:timestep,V1(7,:),'b')
hold on
plot(1:timestep,V1(1,:),'g')
grid on
ylabel('Voltage')
xlabel('Time')
title('Vin(green) and Vo(blue)')

%using a sin input
V2 = zeros(7, timestep);
Fsin = zeros(7,1);
for k = 1:timestep

    Voltsin = sin(2*pi*(1/0.01)*k/timestep);
    Fsin(1,1) = Voltsin;
    
    if k == 1
        
        V2(:,k) = (C./dt+G)\(Fsin+C*Vstart/dt);
    else
        
        V2(:,k) = (C./dt+G)\(Fsin+C*Vold2/dt);
    end
    
    Vold2 = V2(:, k);
        
end
figure(2)
plot(1:timestep,V2(7,:),'b')
hold on
plot(1:timestep,V2(1,:),'g')
grid on
ylabel('Voltage')
xlabel('Time')
title('Vin(green) and Vo(blue) with Sin Input')

%using gauss pulse input
V3 = zeros(7, timestep);
Fgauss = zeros(7,1);

for j = 1:timestep
    %the pulse
    Vgauss = exp(-1/2*((j/timestep-0.06)/(0.03))^2);
    Fgauss(1,1) = Vgauss;
    if j == 1
        
        V3(:,j) = (C./dt+G)\(Fgauss+C*Vstart/dt);
    else
        
        V3(:,j) = (C./dt+G)\(Fgauss+C*Vold3/dt);
    end
    
    Vold3 = V3(:, j);
        
end
figure(3)
plot(0:timestep-1,V3(7,:),'b')
hold on
plot(0:timestep-1,V3(1,:),'g')
grid on
ylabel('Voltage (V)')
xlabel('Time (ms)')
title('Vin (green) and Vo(blue) with Gaussian Pulse')


%setting up frequency range
freq = (-timestep/2:timestep/2-1); 

%
fV1in = fft(V1(1, :));
fV1out = fft(V1(7, :));
fsV1in = fftshift(fV1in);
fsV1out = fftshift(fV1out);
figure(4)
plot(freq, abs(fsV1in), 'b')
hold on
plot(freq, abs(fsV1out), 'g')
grid on
ylabel('Volt')
xlabel('Freq(kHz)')
title('Vin(blue) and Vout(green) Freq Plot')


fV2 = fft(V2.');
fsV2 = fftshift(fV2);
figure(5)
plot(freq, abs(fsV2(:, 1)), 'b')
hold on
plot(freq, abs(fsV2(:, 7)), 'g')
grid on
ylabel('Volt')
xlabel('Freq(kHz)')
title('Vin(blue) and Vo(green) Freq Plot with Sin Input')


fV3 = fft(V3.');
fsV3 = fftshift(fV3);
figure(6)
plot(freq, abs(fsV3(:, 1)), 'b')
hold on
plot(freq, abs(fsV3(:, 7)), 'g')
grid on
ylabel('Volt')
xlabel('Freq(kHz)')
title('Vin(blue) and Vo(green) Freq Plot with Gaussian Pulse Input')

