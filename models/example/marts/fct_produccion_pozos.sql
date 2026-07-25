{{ config(materialized='table') }}

SELECT 
    id_pozo,
    MIN(fecha_medicion) AS primera_extraccion,
    MAX(fecha_medicion) AS ultima_extraccion,
    SUM(barriles_extraidos) AS total_barriles,
    -- Aquí inyectamos nuestra macro
    {{ convertir_barriles_a_m3('SUM(barriles_extraidos)') }} AS total_metros_cubicos,
    SUM(horas_operacion) AS total_horas,
    (SUM(barriles_extraidos) / NULLIF(SUM(horas_operacion), 0)) AS rendimiento_promedio_historico
FROM 
    {{ ref('stg_extraccion_pozos') }}
GROUP BY 
    id_pozo