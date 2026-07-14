-- Capa Staging: Limpieza inicial de rendimiento por lote
SELECT 
    id_lote,
    fecha_cosecha,
    toneladas_netas AS tn_netas,
    (toneladas_netas * 0.985) AS tn_secas_estimadas, -- 1.5% de merma por humedad
    hectareas_sembradas AS ha_sembradas,
    (toneladas_netas / hectareas_sembradas) AS rinde_ha
FROM 
    raw_data.cosecha_2026
WHERE 
    estado = 'FINALIZADO';