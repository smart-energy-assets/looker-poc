# The name of this view in Looker is "Branch Union Stock Daily"

view: branch_union_stock_daily {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `sea-produccion.target_reporting.branch_union_stock_daily`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Branch ID" in Explore.


  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${ts_date}, ${branch_id},${microsection_id}) ;;
    hidden: yes
  }

  dimension: branch_id {
    type: string
    sql: ${TABLE}.branchId ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created_at_max {
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
    sql: ${TABLE}.created_at_max ;;
    description: "Fecha"
    hidden: yes
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
  dimension: id_microsection {
    type: string
    sql: ${TABLE}.id_microsection ;;
  }

  dimension: microsection_id {
    type: string
    sql: ${TABLE}.microsectionId ;;
  }

  dimension: stock_e {
    type: number
    sql: ${TABLE}.stock_E ;;
  }

  dimension: stock_e_diff {
    type: number
    sql: ${TABLE}.stock_E_diff ;;
    value_format: "0.000,,\" GWh\""
    description: "Delta de Stock en Energia"
  }

  dimension: stock_vn {
    type: number
    sql: ${TABLE}.stock_Vn ;;
  }

  dimension: stock_vn_diff {
    type: number
    sql: ${TABLE}.stock_Vn_diff ;;
    value_format: "0.000,\" dam3\""
    description: "Delta de Stock en Volumen"
  }
  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_stock_e {
    type: sum
    sql: ${stock_e} ;;
    hidden: yes
  }

  measure: average_stock_e {
    type: average
    sql: ${stock_e} ;;
    hidden: yes
  }

  measure: total_stock_e_diff {
    type: sum
    sql: ${stock_e_diff} ;;
    value_format: "0.000,,\" GWh\""
    description: "Total Delta Stock en Energía"

  }
  measure: total_stock_vn_diff{
    type: sum
    sql: ${stock_vn_diff};;
    value_format: "0.000,\" dam3\""
    description: "Total Delta Stock en Volumen"
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
