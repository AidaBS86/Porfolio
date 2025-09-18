# 🧪 Ejercicio Técnico — Módulo 2: SQL
  
Consiste en resolver una serie de consultas SQL sobre la base de datos **Sakila**, orientada a simular una tienda de alquiler de películas.

---

## 🎯 Objetivo del ejercicio

Poner en práctica todo lo aprendido sobre SQL a lo largo del módulo, demostrando capacidad para realizar:
- Consultas básicas y avanzadas
- Uso de `JOIN`, `GROUP BY`, `HAVING`, subconsultas y CTEs
- Análisis de datos reales en un entorno relacional

El trabajo debía completarse de forma **individual** y fue evaluado a través de una revisión técnica personalizada, en formato entrevista.

---

## 🗃️ Base de datos utilizada: **Sakila**

Se trata de una base de datos relacional de ejemplo que contiene información sobre:
- 🎬 Películas (`film`)
- 👨‍🎤 Actores (`actor`)
- 👥 Clientes (`customer`)
- 🛒 Alquileres (`rental`)
- 📁 Categorías (`category`)
- Y otras tablas relacionadas (inventario, tienda, personal, etc.)

---

## 📌 Contenido del ejercicio

El ejercicio consta de **25 preguntas SQL** (23 obligatorias + 2 bonus), repartidas en diferentes niveles de dificultad.

### 🧩 Tipos de consultas que se trabajaron:
- Filtrado y búsqueda de datos (`WHERE`, `LIKE`, rangos)
- Funciones agregadas y agrupaciones (`COUNT`, `AVG`, `GROUP BY`, `HAVING`)
- `JOIN` entre múltiples tablas (incluso `JOIN` de una tabla consigo misma)
- Subconsultas simples y correlacionadas
- Uso de `DISTINCT`, `ORDER BY`, `LIMIT`
- CTEs (Common Table Expressions)
- Cálculo de diferencias temporales con `DATEDIFF`
- Exclusiones con `NOT IN` o `NOT EXISTS`

---

## 🔍 Ejemplos de retos incluidos

- Buscar actores que **no hayan actuado nunca en películas de terror**
- Calcular el **número de películas alquiladas** por cada cliente
- Listar actores que **aparecen en más de 10 películas**
- Encontrar películas **con ciertas palabras clave** en la descripción
- Detectar películas alquiladas **durante más de 5 días**
- BONUS: identificar **actores que han actuado juntos** en al menos una película

---

## 🧠 Evaluación y feedback

Durante la revisión con la profesora:
- Defendí mis decisiones técnicas
- Practiqué una dinámica tipo entrevista técnica
- Recibí feedback sobre aspectos a mejorar y puntos fuertes

---

## ⚙️ Cómo ejecutar las consultas

1. Abrir un entorno de trabajo que permita conectarse a la BBDD Sakila (ej. MySQL Workbench).
2. Importar el archivo `.sql` incluido en este repositorio.
3. Ejecutar cada consulta por separado o en bloque según se desee revisar.

---

## 🛠️ Herramientas utilizadas

- SQL (MySQL)
- Sakila DB
- VSCode (como editor)
- Git & GitHub
