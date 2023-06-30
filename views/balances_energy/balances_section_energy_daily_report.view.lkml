view: balances_section_energy_daily_report {
  derived_table: {
    sql:
WITH
  measures AS (
  WITH
    balances_section_energy_daily_deduplicated AS (
    WITH
      temp_table AS (
      SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY TS, section_name ORDER BY TS DESC) AS rn
      FROM
        `sea-produccion.target_reporting.balances_section_energy_daily`
      WHERE
        section_name = {% parameter infrastructure_parameter %}
        AND TS >= {% date_start date_filter2 %}
        AND TS <= {% date_end date_filter2 %}
      ORDER BY
        TS DESC )
    SELECT
      * EXCEPT(rn)
    FROM
      temp_table
    WHERE
      rn = 1 )
  SELECT
    COALESCE(SUM(CASE
          WHEN ( (DATE(balances_section_energy_daily_deduplicated.TS )) = (DATE({% date_start date_filter2 %})) ) THEN CAST( balances_section_energy_daily_deduplicated.stock_E AS INT)
        ELSE
        NULL
      END
        ), 0) AS `Existencias Iniciales`,
    COALESCE(SUM(CASE
          WHEN ( (DATE(balances_section_energy_daily_deduplicated.TS )) = (DATE(IF({% date_end date_filter2 %} >= TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), TIMESTAMP_SUB(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), INTERVAL 1 DAY), {% date_end date_filter2 %}) )) ) THEN CAST( balances_section_energy_daily_deduplicated.stock_E AS INT)
        ELSE
        NULL
      END
        ), 0) AS `Existencias Finales`,
    COALESCE(SUM(CASE
          WHEN ( (DATE(balances_section_energy_daily_deduplicated.TS )) = DATE({% date_start date_filter2 %}) ) THEN CAST( balances_section_energy_daily_deduplicated.stock_E AS INT)
        ELSE
        NULL
      END
        ), 0) - COALESCE(SUM(CASE
          WHEN ( (DATE(balances_section_energy_daily_deduplicated.TS )) = (DATE(IF({% date_end date_filter2 %} >= TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), TIMESTAMP_SUB(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), INTERVAL 1 DAY), {% date_end date_filter2 %}) )) ) THEN CAST( balances_section_energy_daily_deduplicated.stock_E AS INT)
        ELSE
        NULL
      END
        ), 0) AS `Delta de Existencias`,
    COALESCE(SUM(CAST( balances_section_energy_daily_deduplicated.totalizados_IN_E AS INT) ), 0) AS `Medida de Entrada`,
    COALESCE(SUM(CAST( balances_section_energy_daily_deduplicated.totalizados_OUT_E AS INT) ), 0) AS `Medida de Salida`,
    COALESCE(SUM(CAST( balances_section_energy_daily_deduplicated.totalizados_SELF_E AS INT) ), 0) AS `Medida de Gas de Operación`,
    COALESCE(SUM(CAST( balances_section_energy_daily_deduplicated.delta_E_total_fuelgas AS INT) ), 0) AS `Medida de Gas de Operación - EC`,
    COALESCE(SUM(CAST( balances_section_energy_daily_deduplicated.delta_E_total_cald AS INT) ), 0) AS `Medida de Gas de Operación - ERM`,
    COALESCE(SUM(CAST( balances_section_energy_daily_deduplicated.mermas_E AS INT) ), 0) AS `Perdidas y DDM`
  FROM
    balances_section_energy_daily_deduplicated )
SELECT
  dimension,
  value,
  ROW_NUMBER() OVER(
    ORDER BY
      CASE
        WHEN dimension='Existencias Iniciales' THEN 1
        WHEN dimension='Existencias Finales' THEN 2
        WHEN dimension='Delta de Existencias' THEN 3
        WHEN dimension='Medida de Entrada' THEN 4
        WHEN dimension='Medida de Salida' THEN 5
        WHEN dimension='Medida de Gas de Operación' THEN 6
        WHEN dimension='Medida de Gas de Operación - EC' THEN 7
        WHEN dimension='Medida de Gas de Operación - ERM' THEN 8
        WHEN dimension='Perdidas y DDM' THEN 9
      ELSE 100
      END) AS rn
FROM
  measures UNPIVOT(value FOR dimension IN (
    `Existencias Iniciales`,
    `Existencias Finales`,
    `Delta de Existencias`,
    `Medida de Entrada`,
    `Medida de Salida`,
    `Medida de Gas de Operación`,
    `Medida de Gas de Operación - EC`,
    `Medida de Gas de Operación - ERM`,
    `Perdidas y DDM`))
;;
  }

  dimension: dimension {
    label: "Balance Físico"
    type: string
    order_by_field: rn
    sql: ${TABLE}.dimension ;;
  }

  dimension: value {
    type: string
    label: "Energía (kWh)"
    value_format: "#,##0"
    sql: ${TABLE}.value ;;
  }

  dimension: rn {
    type: number
    hidden: yes
    sql: ${TABLE}.rn ;;
  }

  filter: date_filter2 {
    type: date
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
