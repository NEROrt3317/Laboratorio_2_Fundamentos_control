%Algoritmo controlador PID
%Elaborado por: Nehir y Sofia
%Fecha: 15-05-2026
%*************************************


% Comienza de la pagina 93(78), Seleccionar un modelo =! de los de clase,
% El archivo simulink de prueba es ModeloLabo2. 
clear all;
close all;
clc;

%Configurar tiempo de simulación
tfin = 3500;

%Configurar el escalón
tesc = 5; %  Espera
Aesc = 52; % Esto vendria siendo el setPoint

%Función de transferencia -- Mejor modelo Simunlink Toolbox - Primer orden
% Dio una respuesta oscilatoria, entonces toca ajustarla.
Kp = 0.76309;
tao = 180.082;
num = Kp;
den = [tao 1];
tdead = 41.849;

% Vamos a trabajar con el controlador PID, con el metodo  Chien et al.(1952) PAG_93 – regulator.Model: Method 2

%Controlador PID
% Metodo Moros (1999) - Oppelt
% PAG_93 – regulator.Model: Method

Kc = (1.2*tao)/(Kp*tdead);
Ti = 2*tdead;
Td = 0.42*tdead;
sim('ModeloLabo2.slx', tfin)
t = ans.tout;
yout = ans.DatosOut.signals(1).values; %Respuesta del controlador proporcional
r = ans.DatosOut.signals(2).values; %Referencia
figure;
plot(t,r,'--k',t,yout,'LineWidth',1)%cambiar el tipo de linea, cambiar colores
grid;
legend('r(t)','T(t)' );
title('Controlador PID Moron');

A = [t r yout];
xlswrite('Modelomoro1Normal', A)


