# The name of this view in Looker is "Looker Deltas Historical Daily"
view: looker_deltas_historical_daily {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `sea-produccion.target_reporting.looker_deltas_historical_daily`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Delta E" in Explore.
  dimension: delta_e {
    description: "delta energía"
    type: number
    sql: ${TABLE}.delta_E ;;
   # value_format_name: decimal_2
    value_format: "0.000,,\" GWh\""
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: delta_ee {
    type: number
    sql: ${TABLE}.delta_EE ;;

  }

  dimension: delta_vb {
    type: number
    sql: ${TABLE}.delta_Vb ;;
  }

  dimension: delta_vbc {
    type: number
    sql: ${TABLE}.delta_Vbc ;;
  }

  dimension: delta_veb {
    type: number
    sql: ${TABLE}.delta_Veb ;;
  }

  dimension: delta_vebc {
    type: number
    sql: ${TABLE}.delta_Vebc ;;
  }

  dimension: delta_ven {
    type: number
    sql: ${TABLE}.delta_Ven ;;
  }

  dimension: delta_vn {
    type: number
    sql: ${TABLE}.delta_Vn ;;
    value_format: "0.000,\" dam3\""
    drill_fields: [looker_lines.name,looker_measurement_unit.name]
  }

  dimension: l_name {
    primary_key: yes
    type: string
    sql: ${TABLE}.lName ;;
  }

  dimension: mu_name {
    type: string
    sql: ${TABLE}.muName ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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
    drill_fields: [looker_measurement_unit.name,looker_lines.name]
  }

  measure: average_delta_vn {
    type: average
    sql: ${delta_vn} ;;
    value_format: "0.000,\" dam3\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
  }
  measure: total_delta_vn {
    type: sum
    sql: ${delta_vn} ;;
    value_format: "0.000,\" dam3\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
  }
  measure: total_delta_e {
    type: sum
    sql: ${delta_e} ;;
    value_format: "0.000,,\" GWh\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
  }

  measure: average_delta_e {
    type: average
    sql: ${delta_e} ;;
    #drill_fields:[looker_measurement_unit.name,looker_lines.name]
    value_format: "0.000,,\" GWh\""
  }

}
