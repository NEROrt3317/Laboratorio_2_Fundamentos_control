%Algoritmo controlador PID
%Elaborado por: Duby Castellanos
%Fecha: 21-04-2026
%*************************************

clear all;
close all;
clc;

%Configurar tiempo de simulación
tfin = 3500;

%Configurar el escalón
tesc = 5;
A = 52; %Grados

%Función de transferencia
Kp = 0.76309;
tao = 180.082;
num = Kp;
den = [tao 1];
tdead = 41.849;


%Ejecutar simulink
sim('Controlador2.slx', tfin)

t = ans.tout;
yout = ans.DatosOut.signals(1).values; %Respuesta del controlador proporcional
r = ans.DatosOut.signals(2).values; %Referencia
figure;
plot(t,r,'--k',t,yout,'LineWidth',1)%cambiar el tipo de linea, cambiar colores
grid;
legend('r(t)','T(t)' );
title('Controlador PID Turner');



A = [t r yout];
xlswrite('DatosModeloTurnernormal', A)




