view: balances_section_energy_daily_report {
  derived_table: {
    sql:
WITH
  temp_table AS (
  SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY TS, section_name ORDER BY TS DESC) AS rn
  FROM
    `sea-produccion.target_reporting.balances_section_energy_daily`
  WHERE
    CASE
      WHEN {% parameter infrastructure_type%} = "RT"
        THEN section_name IN ("TR_SAG", "RT_ETN", "RT_ENA")
    END
    AND TS >= TIMESTAMP_SUB({% date_start date_filter2 %}, INTERVAL 1 DAY)
    AND TS <= {% date_end date_filter2 %}
  ORDER BY
    TS DESC),

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
        CASE
          WHEN (
            (DATE(deduplicated.TS))
            = (DATE_SUB(DATE({% date_start date_filter2 %}), INTERVAL 1 DAY))
          ) THEN CAST(deduplicated.stock_E AS INT)
          ELSE
            NULL
        END
      ), 0) AS `Existencias Iniciales`,
    COALESCE(
      SUM(
        CASE
          WHEN (
            (DATE(deduplicated.TS))
            = (DATE(IF(
                {% date_end date_filter2 %} >= TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'),
                TIMESTAMP_SUB(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), INTERVAL 1 DAY),
                TIMESTAMP_SUB({% date_end date_filter2 %}, INTERVAL 1 DAY))))
          ) THEN CAST(deduplicated.stock_E AS INT)
          ELSE
            NULL
        END
      ), 0) AS `Existencias Finales`,
    COALESCE(
      SUM(
        CASE
          WHEN (
            (DATE(deduplicated.TS))
            = (DATE_SUB(DATE({% date_start date_filter2 %}), INTERVAL 1 DAY))
          ) THEN CAST(deduplicated.stock_E AS INT)
          ELSE
            NULL
        END
      ), 0)
    - COALESCE(
      SUM(
        CASE
          WHEN (
            (DATE(deduplicated.TS))
            = (DATE(IF(
                {% date_end date_filter2 %} >= TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'),
                TIMESTAMP_SUB(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), INTERVAL 1 DAY),
                TIMESTAMP_SUB({% date_end date_filter2 %}, INTERVAL 1 DAY))))
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
      deduplicated.totalizados_IN_E AS INT)
    ), 0) AS `Medida de Entrada`,
    COALESCE(SUM(CAST(
      deduplicated.totalizados_OUT_E AS INT)
    ), 0) AS `Medida de Salida`,
    COALESCE(SUM(CAST(
      deduplicated.totalizados_SELF_E AS INT)
    ), 0) AS `Medida de Gas de Operación`,
    COALESCE(SUM(CAST(
      deduplicated.mermas_E AS INT)
    ), 0) AS `Perdidas y DDM`,
    section_name,
  FROM
    deduplicated
  WHERE
    TS >= {% date_start date_filter2 %}
    AND TS <= {% date_end date_filter2 %}
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
  FROM
    deduplicated
  WHERE
    TS >= {% date_start date_filter2 %}
    AND TS <= {% date_end date_filter2 %}
  GROUP BY
    section_name),

  existencias_pivoted AS (
  SELECT
    dimension,
    "" AS subtotal,
    value,
    section_name
  FROM
    existencias UNPIVOT(value FOR dimension IN (
      `Existencias Iniciales`,
      `Existencias Finales`,
      `Delta de Existencias`))),

  medidas_pivoted AS (
  SELECT
    dimension,
    "" AS subtotal,
    value,
    section_name
  FROM
    medidas UNPIVOT(value FOR dimension IN (
      `Medida de Entrada`,
      `Medida de Salida`,
      `Medida de Gas de Operación`,
      `Perdidas y DDM`))),

  medida_de_gas_de_operacion_pivoted AS (
    SELECT
      '' AS dimension,
      subtotal,
      value,
      section_name
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
      medida_de_gas_de_operacion_pivoted)

SELECT
  *,
  ROW_NUMBER() OVER(
    ORDER BY
      CASE
        WHEN dimension = 'Existencias Iniciales' THEN 1
        WHEN dimension = 'Existencias Finales' THEN 2
        WHEN dimension = 'Delta de Existencias' THEN 3
        WHEN dimension = 'Medida de Entrada' THEN 4
        WHEN dimension = 'Medida de Salida' THEN 5
        WHEN dimension = 'Medida de Gas de Operación' THEN 6
        WHEN dimension = 'Perdidas y DDM' THEN 9
        WHEN dimension = '' THEN
          CASE
            WHEN subtotal = 'EC' THEN 7
            WHEN subtotal = 'ERM' THEN 8
            ELSE 100
          END
        ELSE 100
      END) AS rn
FROM
  measures
;;
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
    label: "Energía (kWh)"
    value_format: "#,##0"
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

  filter: date_filter2 {
    type: date
  }

  parameter: infrastructure_type {
    type: string
    allowed_value: {
      label: "Red de Transporte"
      value: "RT"
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

  parameter: infrastructure_parameter {
    type:  string
    allowed_value: {
      label: "TR_SAG"
      value: "TR_SAG"
    }
    allowed_value: {
      label: "RT_ENA"
      value: "RT_ENA"
    }
    allowed_value: {
      label: "RT_ETN"
      value: "RT_ETN"
    }
  }
}
