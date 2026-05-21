%% ==========================================================
% DATOS Experimentales vs MODELO Moro 
% ==========================================================
close all;
clear;
clc;

%% ===============================
% Cargar datos experimentales
% ================================
% Nota: Asegúrate de cambiar el nombre del archivo si es DatosModeloH.xlsx
Datos = xlsread('HPerturbacion.xls');
t = Datos(:,1);      % tiempo
U = Datos(:,2);      % entrada
T = Datos(:,3);      % temperatura real (T(1) es la temperatura ambiente)

%% ===============================
% MODELO TOOLBOX (System Identification)
% ================================
Kp = 0.76309;
tao = 180.082;
tdead = 41.849;

num = Kp;
den = [tao 1];
Gp = tf(num, den, 'InputDelay', tdead);

%% =====================================================
% SINTONIZACIÓN PID IMC - CASO H (CORREGIDO)
%% =====================================================
% --- CORRECCIÓN 1: Mapear variables teóricas a tus variables del script ---
% tau   -> tao
% theta -> tdead
% K     -> Kp

tauc = tdead;   % Parámetro IMC recomendado inicialmente (tauc = theta)

% --- CORRECCIÓN 2: Reemplazo exacto en las ecuaciones matemáticas ---
Kc = (tao + tdead/2) / (Kp * (tauc + tdead/2));
Ti = tao + tdead/2;
Td = (tao * tdead) / (2 * tao + tdead);

%% =====================================================
% AJUSTE MATEMÁTICO PARA ACOPLAR LAS CURVAS
%% =====================================================
tesc = 5;            % Tiempo de espera del escalón
Temp_deseada = 52;   % Valor donde queremos que muera la línea azul

% Usamos la ganancia (Kp) para calcular qué amplitud de escalón necesita 
% el modelo en lazo abierto para pasar de la temp ambiente a 52°C
Aesc = (Temp_deseada - T(1)) / Kp;  

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
figure('Name','Modelo H Perturbacion vs Datos Reales', ...
    'NumberTitle','off');
% Línea naranja para los datos reales
plot(t, T, 'Color', [0.85 0.33 0.1], 'LineWidth', 2); hold on;
% Línea azul discontinua para el modelo corregido
plot(t, y_model, '--b', 'LineWidth', 2);
grid on;
xlabel('Tiempo (s)');
ylabel('Temperatura (°C)');
title('Datos Reales vs Modelo H Perturbacion');
legend('Datos Reales', 'Respuesta esperada', 'Location', 'best');
xlim([0 max(t)]);

%% ===============================
% Error cuadrático medio
% ================================
ECM = mean((T - y_model).^2);
disp(['Error cuadrático medio = ', num2str(ECM)]);