# The name of this view in Looker is "Balances Branch Energy Daily"
view: balances_branch_energy_daily {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `sea-produccion.target_reporting.balances_branch_energy_daily`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Branch ID" in Explore.

  dimension: branch_id {
    type: string
    sql: ${TABLE}.branch_id ;;
  }

  dimension: branch_name {
    type: string
    sql: ${TABLE}.branch_name ;;
  }

  dimension: delta_e {
    type: number
    sql: ${TABLE}.delta_E ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

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

  measure: count {
    type: count
    drill_fields: [measurementunit_name, branch_name]
  }
}
