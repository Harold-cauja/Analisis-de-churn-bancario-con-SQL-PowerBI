Desarrollo del Proyecto en PostgreSQL, siguiendo una secuencia lógica de exploración, limpieza y análisis.

1️⃣ Creación de la base de datos y estructura de tablas

Se definió la base de datos bank_churn y se creó la tabla customers con las principales variables del dataset:

Datos demográficos: age, gender, country

Datos financieros: balance, estimated_salary, credit_score

Comportamiento bancario: products_number, active_member, credit_card, tenure

Variable objetivo: churn (abandono del cliente)

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    credit_score INT,
    country TEXT,
    gender TEXT,
    age INT,
    tenure INT,
    balance NUMERIC(12,2),
    products_number INT,
    credit_card BOOLEAN,
    active_member BOOLEAN,
    estimated_salary NUMERIC(10,2),
    churn BOOLEAN
);

2️⃣ Verificación de calidad de datos

Se realizaron validaciones para asegurar la calidad del dataset:

## Detección de duplicados: comparando variables clave (credit_score, age, tenure, balance, estimated_salary).

SELECT credit_score, 
age, 
tenure, 
balance, 
estimated_salary, 
COUNT (*) AS total
FROM customers
GROUP BY credit_score, age, tenure, balance, estimated_salary
HAVING COUNT (*) >1; 

## Conteo de valores nulos: identificando variables con posibles vacíos en country, gender, tenure, etc.


![alt text](image-1.png)

Estos pasos garantizan una base confiable para el análisis posterior.

3️⃣ Cálculo de indicadores principales

Se elaboraron consultas para obtener los indicadores generales del comportamiento de los clientes:

## Tasa general de abandono (Churn_rate)

![Tasa de abandono general](Capturas/tasa abandono.png) 



## Total de clientes y edad promedio

![alt text](image-3.png)


## Comparativo de clientes que abandonaron vs. los que permanecen

![alt text](image-4.png)

4️⃣ Análisis segmentado

Se desarrollaron análisis por distintas dimensiones para identificar patrones:

## Por país: tasa de abandono promedio por pais

![alt text](image-5.png)

## Por género y país: identificación de diferencias de comportamiento.

![alt text](image-6.png)

## Por tenencia: análisis del tiempo de relación con el banco y su impacto en la retención.

![alt text](image-7.png)


5️⃣ Análisis de balance y riesgo

Se profundizó en el saldo promedio (balance) de clientes activos y no activos, y se identificaron clientes con saldo cero, considerados un riesgo potencial de abandono.

Además, se analizaron combinaciones como:

## Clientes con tarjeta de crédito y saldo cero, eran miembros activos pero aun asi abandonaron 

![alt text](image-8.png)



6️⃣ Preparación de vista para Power BI

Finalmente, se creó una vista limpia para conectar el modelo SQL directamente con Power BI:

CREATE VIEW vista_banca AS (
    SELECT *
    FROM customers

);


