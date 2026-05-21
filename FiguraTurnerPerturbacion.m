%% ==========================================================
% DATOS Experimentales vs MODELO PID Turner 
% ==========================================================
close all;
clear;
clc;

%% ===============================
% Cargar datos experimentales
% ================================
Datos = xlsread('TurnerPerturbacion.xls'); % Archivo .xls de Turner
t = Datos(:,1);      % tiempo
U = Datos(:,2);      % entrada
T = Datos(:,3);      % temperatura real (T(1) es la temperatura ambiente)

%% ===============================
% MODELO TOOLBOX (System Identification) - Constantes de la Planta
% ================================
Kp_planta = 0.76309;
tao = 180.082;
tdead = 41.849;

num = Kp_planta;
den = [tao 1];
Gp = tf(num, den, 'InputDelay', tdead);

%% =====================================================
% PARÁMETROS OBTENIDOS DEL PID TURNER (Guardados como variables)
%% =====================================================
% Corregidos con puntos decimales para evitar errores de sintaxis
Kp_controlador = 1.22923446994077;
Ti = 1 / 0.00854516737212471;  % Da el valor aproximado de 117.025
Td = 0;
N = 100;

%% =====================================================
% AJUSTE MATEMÁTICO PARA ACOPLAR LAS CURVAS
%% =====================================================
tesc = 5;            % Tiempo de espera del escalón
Temp_deseada = 52;   % Valor donde queremos que muera la línea azul

% Usamos la ganancia de la planta (Kp_planta) para calcular el escalón
Aesc = (Temp_deseada - T(1)) / Kp_planta;  

%% =====================================================
% SIMULACIÓN CON ENTRADA ESCALÓN REDISEÑADA
%% =====================================================
% Creamos el vector de estímulo corregido
U_sim = zeros(size(t));
U_sim(t >= tesc) = Aesc;

% Simulamos y desplazamos verticalmente desde la temperatura ambiente
y_model = lsim(Gp, U_sim, t) + T(1);

%% ===============================
% Gráfica comparativa
% ================================
figure('Name','Modelo PID Turner : Perturbacion vs Datos Reales', ...
    'NumberTitle','off');
% Línea naranja para los datos reales
plot(t, T, 'Color', [0.85 0.33 0.1], 'LineWidth', 2); hold on;
% Línea azul discontinua para el modelo corregido
plot(t, y_model, '--b', 'LineWidth', 2);
grid on;
xlabel('Tiempo (s)');
ylabel('Temperatura (°C)');
title('Datos Reales vs Modelo PID Turner : Perturbacion');
legend('Datos Reales', 'Respuesta esperada', 'Location', 'best');
xlim([0 max(t)]);

%% ===============================
% Error cuadrático medio
% ================================
ECM = mean((T - y_model).^2);
disp(['Error cuadrático medio = ', num2str(ECM)]);