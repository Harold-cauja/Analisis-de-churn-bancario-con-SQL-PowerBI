# Analisis de Churn en Clientes Bancarios

## Descripcion
Proyecto de análisis de datos que identifica los factores que influyen en la pérdida de clientes (*churn*) de una entidad bancaria. 

Utiliza **PostgreSQL** para la limpieza y exploración de datos y **Power BI** para la visualización interactiva.

## Objetivo
Detectar patrones de abandono y segmentar a los clientes para ayudar al banco a **reducir la tasa de churn** y diseñar **estrategias de retención** más efectivas.

## Dataset
- **Fuente:** [Bank Customer Churn – Kaggle](https://www.kaggle.com/datasets/gauravtopre/bank-customer-churn-dataset)  

- **Registros:** ~10 000 clientes  
- **Variables clave:** Edad, País, Género, Balance, Número de productos, Tarjeta de credito, Antiguedad, Salario estimado, Estado de salida (*churn*).

## Herramientas
- **PostgreSQL**: creación de base de datos, limpieza, vistas, consultas analíticas.
- **Power BI**: construcción de dashboard con KPIs, segmentadores y visuales dinámicos.

## Metodología
1. **Carga de datos**: revisión de tipos de dato, estandarización a UTF-8, importación con `\copy`.
2. **Limpieza y validación**: tratamiento de nulos, creación de vistas y medidas agregadas.
3. **Análisis exploratorio (SQL)**:
   - Tasa de churn global y por país.
   - Relación de churn con edad, género, productos contratados y antigüedad.
4. **Visualización (Power BI)**:
   - Tarjetas con KPIs clave.
   - Gráficos de barras y líneas para tasas de abandono por segmento.
   - Filtros por país, edad y número de productos.

## Resultados
- **Tasa global de churn** calculada y segmentada por pais 
- Identificación de **segmentos de mayor riesgo**, por ejemplo: clientes jóvenes con solo un producto.
- Dashboard interactivo que facilita la **toma de decisiones en tiempo real**

## Cómo ejecutar
1. Clona este repositorio.
2. Importa el script SQL en tu instancia de PostgreSQL (`bank_churn.sql`).
3. Abre el archivo `BankChurn.pbix` en Power BI Desktop para explorar el dashboard.

## Licencia
Dataset con licencia de uso público de Kaggle.  
Este proyecto es únicamente para **fines educativos**.

Harold Cauja Portilla
Guayaquil - Ecuador
