view: balances_section_energy_daily_not_accumulated {
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
      WHEN {% parameter infrastructure_type %} = "RT"
      THEN section_name IN ("TR_SAG", "RT_ETN", "RT_ENA")
    END
    AND TS >= TIMESTAMP_SUB({% date_start date_filter %}, INTERVAL 1 DAY)
    AND TS <= {% date_end date_filter %}),

  deduplicated AS (
  SELECT
    * EXCEPT(rn)
  FROM
    temp_table
  WHERE
    rn = 1),

  existencias AS (
  SELECT
      a.stock_E AS `Existencias Iniciales`,
      b.stock_E AS `Existencias Finales`,
      a.stock_E - b.stock_E AS `Delta de Existencias`,
      a.section_name,
      b.TS,
  FROM
    deduplicated AS a
    JOIN deduplicated AS b
      ON a.TS = TIMESTAMP_SUB(b.TS, INTERVAL 1 DAY)
      AND a.section_name = b.section_name),

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
    TS
  FROM
    deduplicated
  WHERE
    TS >= {% date_start date_filter %}
    AND TS <= {% date_end date_filter %}
  GROUP BY
    section_name,
    TS),

  medida_de_gas_de_operacion AS (
  SELECT
    COALESCE(SUM(CAST( deduplicated.delta_E_total_fuelgas AS INT) ), 0) AS `EC`,
    COALESCE(SUM(CAST( deduplicated.delta_E_total_cald AS INT) ), 0) AS `ERM`,
    section_name,
    TS
  FROM
    deduplicated
  WHERE
    TS >= {% date_start date_filter %}
    AND TS <= {% date_end date_filter %}
  GROUP BY
    section_name,
    TS),

  existencias_pivoted AS (
  SELECT
    dimension,
    "" AS subtotal,
    value,
    section_name,
    TS
  FROM
    existencias UNPIVOT(value FOR dimension IN (`Existencias Iniciales`,
        `Existencias Finales`,
        `Delta de Existencias`))),

  medidas_pivoted AS (
  SELECT
    dimension,
    "" AS subtotal,
    value,
    section_name,
    TS
  FROM
    medidas UNPIVOT(value FOR dimension IN (`Medida de Entrada`,
        `Medida de Salida`,
        `Medida de Gas de Operación`,
        `Perdidas y DDM`))),

  medida_de_gas_de_operacion_pivoted AS (
  SELECT
    '' AS dimension,
    subtotal,
    value,
    section_name,
    TS
  FROM
    medida_de_gas_de_operacion UNPIVOT(value FOR subtotal IN (`EC`,
        `ERM`))),

  measures AS (
  SELECT
    *
  FROM
    existencias_pivoted
  UNION ALL
  SELECT
    *
  FROM
    medidas_pivoted
  UNION ALL
  SELECT
    *
  FROM
    medida_de_gas_de_operacion_pivoted),

  add_status AS (
  SELECT
    *,
    'CERRADO' AS status
  FROM
    measures
  )

SELECT
  *,
  ROW_NUMBER() OVER(
    PARTITION BY TS
    ORDER BY
      section_name,
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
      END) AS dimension_order,
  ROW_NUMBER() OVER(
    PARTITION BY dimension, subtotal, section_name
    ORDER BY
      TS ASC) AS ts_order
FROM
  add_status
    ;;
  }


  # DIMENSIONS

  dimension: dimension {
    label: "Balance Físico"
    type: string
    order_by_field: dimension_order
    sql: ${TABLE}.dimension ;;
  }

  dimension: subtotal {
    label: "Desglose"
    type: string
    order_by_field: dimension_order
    sql: ${TABLE}.subtotal ;;
  }

  dimension: dimension_order {
    type: number
    hidden: yes
    sql: ${TABLE}.dimension_order ;;
  }

  dimension: section_name {
    type: string
    sql: ${TABLE}.section_name ;;
  }

  dimension: TS {
    label: "Dia de Gas"
    type: date
    order_by_field: ts_order
    sql: ${TABLE}.TS ;;
  }

  dimension: ts_order {
    type: number
    hidden: yes
    sql: ${TABLE}.ts_order ;;
  }

  dimension: status {
    label: "Estado"
    type: string
    sql: ${TABLE}.status ;;
  }


  # MEASURES

  measure: value {
    type: sum
    label: "Energía [kWh]"
    sql: ${TABLE}.value ;;
  }


  # FILTERS

  filter: date_filter {
    type: date
  }


  # PARAMETERS

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
