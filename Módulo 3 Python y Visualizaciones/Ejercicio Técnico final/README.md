# ✈️ Ejercicio Técnico — Módulo 3: Python + Visualización

Este ejercicio forma parte de la **evaluación final individual** del tercer módulo del bootcamp de Data Analyst.  
Se centra en la **limpieza, análisis y visualización de datos reales** de una aerolínea con programa de fidelización.

---

## 🎯 Objetivo del ejercicio

Aplicar los conocimientos adquiridos durante el módulo para:
- Realizar un **análisis exploratorio de datos (EDA)**
- Limpiar datos y tratar valores nulos
- Unir datasets de forma eficiente
- Crear visualizaciones claras e informativas con `matplotlib` y `seaborn`
- Realizar una **prueba estadística** para comprobar diferencias entre grupos

---

## 📦 Datos utilizados

El ejercicio se basa en **dos datasets reales** sobre el comportamiento y perfil de clientes de una aerolínea:

### `Customer Flight Analysis.csv`
Contiene información mensual sobre la actividad de vuelo:
- Vuelos reservados y totales
- Vuelos con acompañantes
- Distancias voladas
- Puntos acumulados y redimidos
- Valor en dólares de los puntos redimidos

### `Customer Loyalty History.csv`
Proporciona datos de perfil:
- País, ciudad, nivel educativo, género, estado civil, ingresos
- Tipo de tarjeta de fidelización
- Valor del cliente (CLV)
- Año y mes de inscripción o cancelación

Ambos archivos están unidos mediante el identificador `Loyalty Number`.

---

## 🧪 Fases del ejercicio

### 🔍 1. Exploración y limpieza de datos
- Detección y tratamiento de valores nulos
- Conversión de tipos de datos
- Revisión de outliers y consistencia interna
- Unión eficiente de los dos datasets

### 📊 2. Visualización de datos
Se solicitaron diferentes gráficos para responder preguntas específicas, como:
- Distribución mensual de vuelos reservados
- Relación entre distancia volada y puntos acumulados
- Comparación de salario promedio por nivel educativo
- Proporción de tipos de tarjeta
- Distribución de clientes por estado civil y género

Se utilizaron **`matplotlib` y `seaborn`** para todas las visualizaciones.

### 📈 3. BONUS: Prueba estadística
Evaluar si existen **diferencias significativas en el número de vuelos reservados según el nivel educativo**:
- Preparación y filtrado de datos
- Análisis descriptivo (media, desviación estándar)
- Prueba de hipótesis usando estadística inferencial

---

## ⚙️ Herramientas utilizadas

- **Python** (Jupyter Notebook)
- **pandas**, **numpy**
- **matplotlib**, **seaborn**
- Estadística básica aplicada
- Git & GitHub para control de versiones

