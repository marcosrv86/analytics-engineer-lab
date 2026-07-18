{{ config(materialized='view') }}

SELECT 
    id_lote,
    fecha_cosecha,
    toneladas_netas AS tn_netas,
    hectareas_sembradas AS ha_sembradas
FROM 
    `analytics-lab-sandbox.raw_data.cosecha_2026`