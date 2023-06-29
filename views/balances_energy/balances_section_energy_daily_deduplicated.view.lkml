view: balances_section_energy_daily_deduplicated {
  derived_table: {
    sql:
      WITH temp_table AS (
        SELECT
          *,
          ROW_NUMBER() OVER(PARTITION BY TS, section_name ORDER BY TS DESC) AS rn
        FROM
          `sea-produccion.target_reporting.balances_section_energy_daily`
        WHERE
          section_name = {% parameter infrastructure_parameter %}
          AND TS >= {% date_start date_filter %}
          AND TS <= {% date_end date_filter %}
        ORDER BY
          TS DESC
      )

      SELECT
        *
        EXCEPT(rn)
      FROM
        temp_table
      WHERE
        rn = 1
    ;;
  }

  dimension_group: ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.TS ;;
  }

  dimension: delta_e {
    type: number
    sql: ${TABLE}.delta_E ;;
  }

  measure: total_delta_e {
    type: sum
    sql: ${delta_e} ;;
  }

  measure: average_delta_e {
    type: average
    sql: ${delta_e} ;;
  }

  dimension: delta_e_cald {
    type: number
    sql: ${TABLE}.delta_E_cald ;;
  }

  dimension: delta_e_fuelgas {
    type: number
    sql: ${TABLE}.delta_E_fuelgas ;;
  }

  dimension: delta_e_total_cald {
    type: number
    sql: ${TABLE}.delta_E_total_cald ;;
  }

  dimension: delta_e_total_fuelgas {
    type: number
    sql: ${TABLE}.delta_E_total_fuelgas ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: last_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_update ;;
  }

  dimension: measurementunit_id {
    type: string
    sql: ${TABLE}.measurementunit_id ;;
  }

  dimension: measurementunit_name {
    type: string
    sql: ${TABLE}.measurementunit_name ;;
  }

  dimension: mermas_e {
    type: number
    sql: ${TABLE}.mermas_E ;;
  }

  dimension_group: mu_last_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.mu_last_update ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: section_id {
    type: string
    sql: ${TABLE}.section_id ;;
  }

  dimension: section_name {
    type: string
    sql: ${TABLE}.section_name ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: stock_e {
    type: number
    sql: ${TABLE}.stock_E ;;
  }

  dimension: stock_e_diff {
    type: number
    sql: ${TABLE}.stock_E_diff ;;
  }

  dimension: totalizados_in_e {
    type: number
    sql: ${TABLE}.totalizados_IN_E ;;
  }

  dimension: totalizados_out_e {
    type: number
    sql: ${TABLE}.totalizados_OUT_E ;;
  }

  dimension: totalizados_self_e {
    type: number
    sql: ${TABLE}.totalizados_SELF_E ;;
  }

  measure: count {
    type: count
    drill_fields: [section_name, measurementunit_name]
  }


  # FILTERS ADDED
  filter: date_filter {
    type: date
  }

  parameter: infrastructure_parameter {
    type:  string
    allowed_value: {
      label: "SAGGAS"
      value: "TR_SAG"
    }
    allowed_value: {
      label: "ENAGAS"
      value: "RT_ENA"
    }
    allowed_value: {
      label: "ETN"
      value: "RT_ETN"
    }
  }

  dimension: filter_start {
    type: date
    hidden: yes
    sql: {% date_start date_filter %} ;;
  }

  dimension: is_start {
    type: yesno
    hidden: yes
    sql: ${ts_date} = ${filter_start} ;;
  }

  dimension: filter_end {
    type: date
    sql:
      IF(
        {% date_end date_filter %} >= TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'),
        TIMESTAMP_SUB(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC'), INTERVAL 1 DAY),
        {% date_end date_filter %}) ;;
  }

  dimension: is_end {
    type: yesno
    hidden: yes
    sql: ${ts_date} = ${filter_end} ;;
  }


  # MEASURES ADDED
  measure: existencias_iniciales {
    type: sum
    sql: CAST(${stock_e} AS INT) ;;
    filters: [is_start: "Yes"]
  }

  measure: existencias_finales {
    type: sum
    sql: CAST(${stock_e} AS INT) ;;
    filters: [is_end: "Yes"]
  }

  measure: medida_de_entrada {
    type: sum
    sql: CAST(${totalizados_in_e} AS INT) ;;
  }

  measure: medida_de_salida {
    type:  sum
    sql: CAST(${totalizados_out_e} AS INT) ;;
  }

  measure: medida_de_gas_de_operacion {
    type: sum
    sql: CAST(${totalizados_self_e} AS INT) ;;
  }

  measure: EC {
    type: sum
    sql: CAST(${delta_e_total_fuelgas} AS INT) ;;
  }

  measure: ERM {
    type: sum
    sql: CAST(${delta_e_total_cald} AS INT) ;;
  }

  measure: perdidas_y_DDM {
    type: sum
    sql: CAST(${mermas_e} AS INT) ;;
  }
}
