-- 1. Definimos una variable Jinja que contiene una lista (array) de nuestras provincias
{% set provincias = ['Santa Cruz', 'Salta', 'Chubut', 'Mendoza', 'Neuquén'] %}

WITH pivot_datos AS (
    SELECT
        id_pozo,
        
        -- 2. Iniciamos el bucle. Por cada provincia en la lista, escribe lo siguiente:
        {% for provincia in provincias %}
        
            -- AQUÍ ESTÁ LA MAGIA: Aplicamos la macro a la columna 'total_barriles'
            SUM(CASE WHEN provincia = '{{ provincia }}' THEN {{ barriles_a_m3('total_barriles') }} ELSE 0 END) AS m3_{{ provincia | replace(' ', '_') | replace('é', 'e') | lower }}
        
        -- 3. Lógica para las comas: Si NO es la última iteración del bucle, pon una coma.
        {% if not loop.last %} , {% endif %}
        
        {% endfor %}
        
    FROM {{ ref('fct_produccion_pozos') }}
    GROUP BY 1
)

SELECT * FROM pivot_datos