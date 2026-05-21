

% Algoritmo controlador PID
clear all;
close all;
clc;

%% Tiempo de simulación
tfin = 3500;

%% Escalón de referencia
tesc = 5; %  Espera
Aesc = 52; % Esto vendria siendo el setPoint

%% Modelo de primer orden con tiempo muerto
K = 0.76309;
tau = 180.082;
theta = 41.849;

num = K;
den = [tau 1];

%% Parámetro IMC
tauc = theta;   % recomendado inicialmente

%% Controlador PID IMC - Caso H
Kc = (tau + theta/2)/(K*(tauc + theta/2));

Ti = tau + theta/2;

Td = (tau*theta)/(2*tau + theta);

%% Simulación
sim('ModeloLabo2.slx', tfin)

%% Variables de salida
t = ans.tout;
yout = ans.DatosOut.signals(1).values; %Respuesta del controlador proporcional
r = ans.DatosOut.signals(2).values; %Referencia
figure;
plot(t,r,'--k',t,yout,'LineWidth',1)%cambiar el tipo de linea, cambiar colores
grid;
legend('r(t)','T(t)' );
title('Controlador PID H ');

A = [t r yout];
xlswrite('DatosModeloHnormal', A)
