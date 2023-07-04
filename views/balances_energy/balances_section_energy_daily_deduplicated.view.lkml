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
          section_name IN ("TR_SAG", "RT_ENA", "RT_ETN")
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
    description: "Filtro temporal de uso obligatotio, se aplica a todos los resultados que devuelve la tabla."
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
  measure: initial_stock {
    type: sum
    label: "Existencias Iniciales"
    sql: CAST(${stock_e} AS INT) ;;
    filters: [is_start: "Yes"]
    description: "Existencias en kWh registrados el primer dia del filtro temporal."
    value_format_name: energy_formatting
  }

  measure: end_stock {
    type: sum
    label: "Existencias Finales"
    sql: CAST(${stock_e} AS INT) ;;
    filters: [is_end: "Yes"]
    value_format_name: energy_formatting
  }

  measure: stock_delta {
    type: number
    label: "Delta de Existencias"
    sql: ${initial_stock} - ${end_stock} ;;
    value_format_name: energy_formatting
  }

  measure: input_measure {
    type: sum
    label: "Medida de Entrada"
    sql: CAST(${totalizados_in_e} AS INT) ;;
    value_format_name: energy_formatting
  }

  measure: output_measure {
    type:  sum
    label: "Medida de Salida"
    sql: CAST(${totalizados_out_e} AS INT) ;;
    value_format_name: energy_formatting

  }

  measure: operational_gas_measure {
    type: sum
    label: "Medida de Gas de Operación"
    sql: CAST(${totalizados_self_e} AS INT) ;;
    value_format_name: energy_formatting
    # drill_fields: [ec, erm]
  }

  measure: ec {
    type: sum
    label: "----- EC"
    sql: CAST(${delta_e_total_fuelgas} AS INT) ;;
    value_format_name: energy_formatting
  }

  measure: erm {
    type: sum
    label: "----- ERM"
    sql: CAST(${delta_e_total_cald} AS INT) ;;
    value_format_name: energy_formatting
  }

  measure: ddm_and_loses {
    type: sum
    label: "Perdidas y DDM"
    sql: CAST(${mermas_e} AS INT) ;;
    value_format_name: energy_formatting
  }
}
