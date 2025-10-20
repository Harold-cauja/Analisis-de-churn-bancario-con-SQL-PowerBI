CREATE DATABASE bank_churn


CREATE TABLE curstomers (
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
estimated_salary NUMERIC (10,2),
churn BOOLEAN
); 


SELECT * FROM customers; 

--verificar duplicados
SELECT credit_score, age, tenure, balance, estimated_salary, COUNT (*) AS total
FROM customers
GROUP BY credit_score, age, tenure, balance, estimated_salary
HAVING COUNT (*) >1; 


--verificar valore nulos

SELECT COUNT (*) AS total,

	COUNT (*) FILTER (WHERE credit_score IS NULL) nulos_credit_score,
	COUNT (*) FILTER (WHERE country IS NULL) nulos_country,
	COUNT (*) FILTER (WHERE gender IS NULL) nulos_gender,
	COUNT (*) FILTER (WHERE age IS NULL) nulos_age,
	COUNT (*) FILTER (WHERE tenure IS NULL) nulos_tenure
FROM customers; 

--Churn Rate

SELECT ROUND (100* AVG(CASE WHEN churn THEN 1 ELSE 0 END),2) AS Churn_rate
FROM customers;

-- Esta consulta calcula el total de clientes, asi como cuantos se dieron de baja y su edad promedio 

SELECT COUNT(*) AS total_clientes,
       SUM(CASE WHEN churn THEN 1 ELSE 0 END) AS clientes_perdidos,
       ROUND(AVG(age),1) AS edad_promedio
FROM customers;

-- cantidad de churn y no_churn

SELECT 
	SUM(CASE WHEN churn THEN 1 ELSE 0 END) AS suma_churn,
	SUM(CASE WHEN churn THEN 0 ELSE 1 END) AS suma_no_churn
FROM customers; 


--Tasa abandono (churn) por país
SELECT country,
		ROUND (100* AVG(CASE WHEN churn THEN 1 ELSE 0 END),2) AS Porcentaje_abandono
FROM customers
GROUP BY country
ORDER BY Porcentaje_abandono DESC;

--Tasa abandono (churn) por genero y pais 
SELECT gender, country,
		ROUND (100* AVG(CASE WHEN churn THEN 1 ELSE 0 END),2) AS Porcentaje_abandono,
		SUM(CASE WHEN churn THEN 1 ELSE 0 END) 
FROM customers
GROUP BY  gender,country
ORDER BY country, Porcentaje_abandono DESC;


--tasa abandono por tenencia (años que tiene una cuenta bancaria en el Banco)
--Es igual a la retención según tenencia de años 
SELECT tenure AS tenencia_años,
ROUND (100* AVG(CASE WHEN churn THEN 1 ELSE 0 END),2) AS Promedio_abandono,
ROUND (100* AVG(CASE WHEN churn THEN 0 ELSE 1 END),2) AS Promedio_no_abandono
		,SUM(CASE WHEN churn THEN 1 ELSE 0 END) clientes_abandono
FROM customers
GROUP BY  tenure
ORDER BY tenure; 

--tasa abanadono por edad 

SELECT age,
		ROUND (100* AVG(CASE WHEN churn THEN 1 ELSE 0 END),2) AS Porcentaje_abandono
FROM customers
GROUP BY  age
ORDER BY Porcentaje_abandono DESC;

SELECT
    active_member,
    churn,
    ROUND(AVG(balance), 2) AS promedio_saldo
FROM customers
GROUP BY active_member, churn
ORDER BY active_member, churn;



SELECT
    active_member,
    ROUND(AVG(balance), 2) AS saldo_promedio_abandono,
    COUNT(*)               AS clientes_abandono
FROM customers
WHERE churn
GROUP BY active_member;

SELECT *
FROM customers




SELECT
    products_number,
    ROUND(AVG(balance), 2) AS saldo_promedio_abandono,
    COUNT(*)               AS clientes_abandono,
	CASE WHEN active_member THEN 'activo'
		ELSE 'inactivo'
		END AS activo_inactivo
		,credit_card
FROM customers
WHERE churn
GROUP BY  products_number,active_member,credit_card
ORDER BY products_number, clientes_abandono DESC;



SELECT COUNT(*) AS clientes_saldo_cero
FROM customers
WHERE balance = 0
  AND customer_id IN (
        SELECT customer_id
        FROM customers
        WHERE churn
          AND credit_card = true
          AND active_member = true
);

--Total clientes que abandonaron, con TC, miembros activos y balance 0 

SELECT COUNT(*) AS clientes_saldo_cero
FROM customers
WHERE churn
  AND credit_card = TRUE
  AND active_member = TRUE
  AND balance = 0;


--Saldo promedio de clientes que abandonaron y no abandonaron 
    SELECT 
    ROUND(AVG(balance), 2) AS saldo_promedio,
    COUNT(*)               AS clientes_abandono,
	CASE WHEN churn THEN 'abandono'
		ELSE 'no abandono'
		END AS churn_cantidad		
FROM customers
GROUP BY churn
ORDER BY  clientes_abandono 


--Crear vista de tabla limpia para conectar a Power BI

CREATE VIEW vista_banca AS (
SELECT *
FROM customers
)


SELECT *
fROM vista_banca