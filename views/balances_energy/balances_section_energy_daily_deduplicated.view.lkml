view: balances_section_energy_daily_deduplicated {
  derived_table: {
    sql:
      SELECT
        DISTINCT
          TS,
          mu_last_update,
          last_update,
          section_id,
          section_name,
          measurementunit_id,
          measurementunit_name,
          role,
          `source`,
          delta_E,
          totalizados_IN_E,
          totalizados_OUT_E,
          totalizados_SELF_E,
          stock_E,
          stock_E_diff,
          delta_E_cald,
          delta_E_fuelgas,
          mermas_E,
          delta_E_total_fuelgas,
          delta_E_total_cald
      FROM
        `sea-produccion.target_reporting.balances_section_energy_daily`
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

  measure: existencias_iniciales {
    type: sum
    sql: ${stock_e} ;;
  }
}
