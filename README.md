# Laboratorio_2_Fundamentos_control



Este repositorio contiene los scripts de simulación en **MATLAB** y los modelos de **Simulink** desarrollados para la identificación de sistemas y la sintonización de controladores industriales (PI/PID) aplicados a una planta térmica.

## 📁 Estructura del Repositorio y Descripción de Archivos

El proyecto está compuesto por archivos de dos extensiones principales:
* **`.m` (Scripts de MATLAB):** Archivos de código fuente basados en texto donde se ejecutan las cargas de datos experimentales (`xlsread`), el procesamiento de variables de desviación, la graficación comparativa y el cálculo del Error Cuadrático Medio (ECM).
* **`.slx` (Modelos de Simulink):** Diagramas de bloques interactivos en formato continuo utilizados para simular el comportamiento dinámico de la planta térmica en lazo cerrado frente a perturbaciones y cambios de *setpoint*.

---

### 📑 Guía de Archivos Incluidos

#### 1. `FigureModeloMoro.m`
* **Descripción:** Script encargado de validar el modelo matemático de primer orden con tiempo muerto (FOPDT) obtenido mediante la sintonía clásica de Moros. 
* **Funcionamiento:** Importa los datos experimentales desde el archivo Excel, calcula de manera analítica la amplitud del escalón necesaria en lazo abierto usando la ganancia de la planta ($K_p$) y la temperatura ambiente inicial, grafica la respuesta esperada contra la real y calcula el Error Cuadrático Medio (ECM).

#### 2. `FiguraModeloH.m`
* **Descripción:** Script de validación para el método de sintonización basado en el Modelo de Control Interno (IMC) - Caso H.
* **Funcionamiento:** Adapta las constantes de tiempo y los retardos calculados por el Toolbox a las expresiones de sintonía analítica del Caso H, permitiendo comparar de forma gráfica el ajuste de curvas en variables físicas reales.

#### 3. `FiguraModeloTurner.m`
* **Descripción:** Script de procesamiento de datos para la sintonía optimizada por medio de la herramienta integrada PID Tuner (Turner) de MATLAB.
* **Funcionamiento:** Almacena los parámetros calculados por el entorno gráfico ($K_p$, $T_i$, $T_d$, $N$), ejecuta la simulación lineal mediante el comando `lsim` adaptando el comportamiento a la temperatura ambiente inicial y exporta las métricas de precisión temporal.


__NOTA__: Los mismos codigos se presentan con su respectivas perturbaciones
#### 4. Archivos de Simulación de Bloques (`.slx`)
* **`ModeloLabo2.slx`:** Modelo en Simulink configurado para evaluar la respuesta temporal y la robustez del sistema ante los modelos Moro y H y sus respectivas perturbaciones.
* **`Controlador2.slx`:** Modelo en Simulink configurado bajo la estructura **Ideal/Standard**. Modela el comportamiento del lazo térmico real donde el término derivativo se reduce a cero ($T_d = 0$), actuando como un controlador PI optimizado para mitigar el ruido de alta frecuencia del sensor, evaluado ante una perturbación en el segundo 1410 utilizado para el Controlador PID Turner de Simulink.

#### 4. Contruccion de los controladores  (`.m`)
* **`ModeloLabo2H.m`:** Modelo en Matlab configurado para evaluar la respuesta temporal y la robustez del sistema ante el Modelo H y sus respectivas perturbaciones; `ModeloLabo2HPerturbaciones.m` .
* **`ModeloMoro2.slx`:** Modelo en Matlab configurado Para evaluar la respuesta y la robustez del sistema antes el modelo Moro, Como dio una respuesta oscilatoria se modico los valores y se creo un nuevo archivo `ModeloMoroModificacionSubamortiguamiento.m` y sus respectivas Perturbaciones; `ModeloMoroPerturbacion.m`.
* **`CodigoTurner.m`:** Modelo en Matlab configurado para evaluar la respuesta temporal y la robustez del sistema ante el Modelo PID turner y sus respectivas perturbaciones;`CodigoTurnerPerturbacion.m`
