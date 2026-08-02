-- Este test busca pozos donde las horas registradas sean un error matemático (menores a cero)
-- Si la consulta devuelve filas, el test fallará y nos alertará.

SELECT
    id_pozo,
    hs_operacion_total
FROM {{ ref('fct_produccion_pozos') }}
WHERE hs_operacion_total < 0