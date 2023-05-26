# The name of this view in Looker is "Piloto Electrovalvulas"
view: piloto_electrovalvulas {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.piloto_electrovalvulas`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Delta E" in Explore.

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

  dimension: delta_vbc {
    type: number
    sql: ${TABLE}.delta_Vbc ;;
  }

  dimension: delta_vn {
    type: number
    sql: ${TABLE}.delta_Vn ;;
  }

  dimension: linea {
    type: string
    sql: ${TABLE}.linea ;;
  }

  dimension: presion {
    type: number
    sql: ${TABLE}.presion ;;
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

  dimension: um {
    type: string
    sql: ${TABLE}.um ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
