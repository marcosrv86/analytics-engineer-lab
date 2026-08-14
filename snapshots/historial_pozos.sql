{% snapshot historial_pozos_snapshot %}

    {{
        config(
          target_schema='snapshots',
          unique_key='id_pozo',
          strategy='check',
          check_cols=['provincia']
        )
    }}

    -- Seleccionamos los datos de origen que queremos auditar a lo largo del tiempo
    SELECT 
        id_pozo, 
        provincia, 
        total_barriles
    FROM {{ ref('fct_produccion_pozos') }}

{% endsnapshot %}