view: balances_section_energy_daily_accumulated {
  derived_table: {
    sql:
WITH
  connection_point AS (
  SELECT
    *
  FROM
    `sea-produccion.target_reporting.balances_section_energy_daily` AS energy
    JOIN `sea-produccion.target_reporting.looker_connection_point` AS connection_point
      ON energy.measurementunit_id = measurementUnitId
  WHERE
    CASE
      WHEN {% parameter infrastructure_type %} = "Red de Transporte"
        THEN section_name IN ("TR_SAG", "RT_ETN", "RT_ENA")
    END
    AND TS >= TIMESTAMP_SUB({% date_start date_filter %}, INTERVAL 1 DAY)
    AND TS < {% date_end date_filter %}),

  temp_table AS (
  SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY TS, section_name, measurementunit_id ORDER BY TS DESC) AS rn
  FROM
    connection_point),

  deduplicated AS (
  SELECT
    * EXCEPT(rn)
  FROM
    temp_table
  WHERE
    rn = 1),

  existencias AS (
  SELECT
    COALESCE(
      SUM(
        DISTINCT
        CASE
          WHEN (
            (DATE(deduplicated.TS))
            = (DATE_SUB(DATE({% date_start date_filter %}), INTERVAL 1 DAY))
          ) THEN CAST(deduplicated.stock_E AS INT)
          ELSE
            NULL
        END
      ), 0) AS `Existencias Iniciales`,
    COALESCE(
      SUM(
        DISTINCT
        CASE
          WHEN (
            (DATE(deduplicated.TS))
            = (DATE(IF(
                {% date_end date_filter %} >= TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'),
                TIMESTAMP_SUB(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), INTERVAL 1 DAY),
                TIMESTAMP_SUB({% date_end date_filter %}, INTERVAL 1 DAY))))
          ) THEN CAST(deduplicated.stock_E AS INT)
          ELSE
            NULL
        END
      ), 0) AS `Existencias Finales`,
    COALESCE(
      SUM(
        DISTINCT
        CASE
          WHEN (
            (DATE(deduplicated.TS))
            = (DATE_SUB(DATE({% date_start date_filter %}), INTERVAL 1 DAY))
          ) THEN CAST(deduplicated.stock_E AS INT)
          ELSE
            NULL
        END
      ), 0) - COALESCE(
      SUM(
        DISTINCT
        CASE
          WHEN (
            (DATE(deduplicated.TS))
            = (DATE(IF(
                {% date_end date_filter %} >= TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'),
                TIMESTAMP_SUB(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), INTERVAL 1 DAY),
                TIMESTAMP_SUB({% date_end date_filter %}, INTERVAL 1 DAY))))
          ) THEN CAST(deduplicated.stock_E AS INT)
          ELSE
            NULL
        END
      ), 0) AS `Delta de Existencias`,
    section_name
  FROM
    deduplicated
  GROUP BY
    section_name),

  medidas AS (
  SELECT
    COALESCE(SUM(CAST(
      IF(role = "IN", delta_E, 0) AS INT)
    ), 0) AS `Medida de Entrada`,
    COALESCE(SUM(CAST(
      IF(role = "OUT", delta_E, 0) AS INT)
    ), 0) AS `Medida de Salida`,
    COALESCE(SUM(CAST(
      deduplicated.totalizados_SELF_E AS INT)
    ), 0) AS `Medida de Gas de Operación`,
    COALESCE(SUM(DISTINCT CAST(
      deduplicated.mermas_E AS INT)
    ), 0) AS `Pérdidas + DDM`,
    section_name
  FROM
    deduplicated
  WHERE
    TS >= {% date_start date_filter %}
    AND TS <= {% date_end date_filter %}
  GROUP BY
    section_name),

  medida_de_gas_de_operacion AS (
  SELECT
    COALESCE(SUM(CAST(
      deduplicated.delta_E_total_fuelgas AS INT)
    ), 0) AS `EC`,
    COALESCE(SUM(CAST(
      deduplicated.delta_E_total_cald AS INT)
    ), 0) AS `ERM`,
    section_name,
    '' AS role
  FROM
    deduplicated
  WHERE
    TS >= {% date_start date_filter %}
    AND TS <= {% date_end date_filter %}
  GROUP BY
    section_name,
    role),

  medidas_de_entrada AS (
  SELECT
    '' AS dimension,
    name AS subtotal,
    COALESCE(SUM(CAST(delta_E AS INT)), 0) AS value,
    section_name,
    role
  FROM
    deduplicated
  WHERE
    TS >= {% date_start date_filter %}
    AND TS <= {% date_end date_filter %}
    AND role = 'IN'
  GROUP BY
    dimension,
    subtotal,
    section_name,
    role),

  medidas_de_salida AS (
  SELECT
    '' AS dimension,
    name AS subtotal,
    COALESCE(SUM(CAST(delta_E AS INT)), 0) AS value,
    section_name,
    role
  FROM
    deduplicated
  WHERE
    TS >= {% date_start date_filter %}
    AND TS <= {% date_end date_filter %}
    AND role = 'OUT'
  GROUP BY
    dimension,
    subtotal,
    section_name,
    role),

  existencias_pivoted AS (
  SELECT
    dimension,
    '' AS subtotal,
    value,
    section_name,
    '' AS role
  FROM
    existencias UNPIVOT(value FOR dimension IN (
      `Existencias Iniciales`,
      `Existencias Finales`,
      `Delta de Existencias`))),

  medidas_pivoted AS (
  SELECT
    dimension,
    '' AS subtotal,
    value,
    section_name,
    '' AS role
  FROM
    medidas UNPIVOT(value FOR dimension IN (
      `Medida de Entrada`,
      `Medida de Salida`,
      `Medida de Gas de Operación`,
      `Pérdidas + DDM`))),

  medida_de_gas_de_operacion_pivoted AS (
  SELECT
    '' AS dimension,
    subtotal,
    value,
    section_name,
    'SELF' AS role
  FROM
    medida_de_gas_de_operacion UNPIVOT(value FOR subtotal IN (
      `EC`,
      `ERM`))),

  measures AS (
  SELECT
    *
  FROM
    existencias_pivoted
  UNION ALL
    SELECT
      *
    FROM medidas_pivoted
  UNION ALL
    SELECT
      *
    FROM
      medida_de_gas_de_operacion_pivoted
  UNION ALL
    SELECT
      *
    FROM
      medidas_de_entrada
  UNION ALL
    SELECT
      *
    FROM
      medidas_de_salida)

{% assign counter = 0 %}

SELECT
  *,
  CASE
    WHEN dimension = 'Existencias Iniciales' THEN {% increment counter %}
    WHEN dimension = 'Existencias Finales' THEN {% increment counter %}
    WHEN dimension = 'Delta de Existencias' THEN {% increment counter %}
    WHEN dimension = 'Medida de Entrada' THEN {% increment counter %}
    WHEN role = 'IN' THEN {% increment counter %}
    WHEN dimension = 'Medida de Salida' THEN {% increment counter %}
    WHEN role = 'OUT' THEN {% increment counter %}
    WHEN dimension = 'Medida de Gas de Operación' THEN {% increment counter %}
    WHEN role = 'SELF' THEN {% increment counter %}
    WHEN dimension = 'Pérdidas + DDM' THEN {% increment counter %}
    ELSE 100
  END AS rn,
  CONCAT(CAST(FORMAT_DATE("%d/%m/%Y", DATE({% date_start date_filter %})) AS STRING),
    " - ",
    CAST(
      FORMAT_DATE("%d/%m/%Y", DATE_SUB(DATE({% date_end date_filter %}), INTERVAL 1 DAY)
    ) AS STRING)) AS date_range,
  CONCAT({% parameter infrastructure_type %}, " - ", section_name) AS infrastructure
FROM
  measures ;;
  }

  dimension: dimension {
    label: "Balance Físico"
    type: string
    order_by_field: rn
    sql: ${TABLE}.dimension ;;
  }

  dimension: subtotal {
    label: "Desglose"
    type: string
    order_by_field: rn
    sql: ${TABLE}.subtotal ;;
  }

  dimension: value {
    type: number
    label: "Energía [kWh]"
    order_by_field: rn
    sql: ${TABLE}.value ;;
  }

  dimension: rn {
    type: number
    hidden: yes
    sql: ${TABLE}.rn ;;
  }

  dimension: section_name {
    type: string
    sql: ${TABLE}.section_name ;;
  }

  dimension: date_range {
    type: string
    label: "Rango de Fechas"
    sql: ${TABLE}.date_range ;;
  }

  dimension: infrastructure {
    type: string
    label: "Infraestructura"
    sql: ${TABLE}.infrastructure ;;
  }

  filter: date_filter {
    type: date
  }

  parameter: infrastructure_type {
    type: string
    allowed_value: {
      label: "Red de Transporte"
      value: "Red de Transporte"
    }
    allowed_value: {
      label: "Plantas"
      value: "Plantas"
    }
    allowed_value: {
      label: "AASS"
      value: "AASS"
    }
  }

  parameter: tipo_balance {
    type: string
    allowed_value: {
      label: "Prebalance"
      value: "prebalance"
    }
    allowed_value: {
      label: "Diario Provisional"
      value: "diario_provisional"
    }
    allowed_value: {
      label: "Final Provisional"
      value: "final_provisional"
    }
    allowed_value: {
      label: "Final Definitivo"
      value: "final_definitivo"
    }
  }
}
