{{ config(materialized='table') }}

WITH extraccion AS (
    SELECT * FROM {{ ref('stg_extraccion_pozos') }}
),

geografia AS (
    SELECT * FROM {{ ref('mapa_pozos') }}
)

SELECT 
    e.id_pozo,
    g.cuenca,
    g.provincia,
    MIN(e.fecha_medicion) AS primera_extraccion,
    MAX(e.fecha_medicion) AS ultima_extraccion,
    SUM(e.barriles_extraidos) AS total_barriles,
    {{ convertir_barriles_a_m3('SUM(e.barriles_extraidos)') }} AS total_metros_cubicos,
   SUM(e.horas_operacion) AS horas_trabajada,
   SUM(e.horas_operacion) AS hs_operacion_total
FROM 
    extraccion e
LEFT JOIN 
    geografia g ON e.id_pozo = g.id_pozo
GROUP BY 
    e.id_pozo,
    g.cuenca,
    g.provincia