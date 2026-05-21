%Algoritmo controlador PID Moro MODIFICADO
%Elaborado por: Nehir y Sofia
%Fecha: 15-05-2026
%*************************************

clear all;
close all;
clc;

%% Tiempo de simulación
tfin = 3500;

%% Escalón de referencia
tesc = 5;
Aesc = 52;

%% Modelo de primer orden con tiempo muerto
Kp = 0.76309;
tao = 180.082;
tdead = 41.849;

num = Kp;
den = [tao 1];

%% =====================================================
% PID MOROS ORIGINAL
%% =====================================================

Kc_original = (1.2*tao)/(Kp*tdead);
Ti_original = 2*tdead;
Td_original = 0.42*tdead;

%% =====================================================
% PID MODIFICADO PARA REDUCIR OSCILACIONES
%% =====================================================

Kc = 0.55*Kc_original;     % Menos agresivo
Ti = 1.8*Ti_original;      % Integración más lenta
Td = 0.5*Td_original;      % Menor acción derivativa

%% Simulación
sim('ModeloLabo2.slx', tfin)

t = ans.tout;
yout = ans.DatosOut.signals(1).values;
r = ans.DatosOut.signals(2).values;

%% Gráfica
figure;

plot(t,r,'--k','LineWidth',1.5)
hold on
plot(t,yout,'LineWidth',1.2)

grid on

legend('r(t)','T(t)');
title('Controlador PID Moros Modificado subamortiguado');
xlabel('Tiempo (s)');
ylabel('Temperatura');

%% Exportar datos
A = [t r yout];

xlswrite('ModeloMoros_Modificado_suba.xlsx',A)