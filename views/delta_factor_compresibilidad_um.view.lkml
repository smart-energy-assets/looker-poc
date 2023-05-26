# The name of this view in Looker is "Delta Factor Compresibilidad Um"
view: delta_factor_compresibilidad_um {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.delta_factor_compresibilidad_um`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Co2 Neptuno" in Explore.

  dimension: co2_neptuno {
    type: number
    sql: ${TABLE}.co2_neptuno ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_co2_neptuno {
    type: sum
    sql: ${co2_neptuno} ;;
  }

  measure: average_co2_neptuno {
    type: average
    sql: ${co2_neptuno} ;;
  }

  dimension: co2_slm {
    type: number
    sql: ${TABLE}.co2_slm ;;
  }

  dimension: croma {
    type: number
    sql: ${TABLE}.croma ;;
  }

  dimension: croma_marca {
    type: number
    sql: ${TABLE}.croma_marca ;;
  }

  dimension: croma_modelo {
    type: number
    sql: ${TABLE}.croma_modelo ;;
  }

  dimension: delta_e {
    type: number
    sql: ${TABLE}.delta_e ;;
  }

  dimension: delta_vbc_procesado {
    type: number
    sql: ${TABLE}.delta_vbc_procesado ;;
  }

  dimension: diferencia_energia_calculada {
    type: number
    sql: ${TABLE}.diferencia_energia_calculada ;;
  }

  dimension: diferencia_energia_conversor {
    type: number
    sql: ${TABLE}.diferencia_energia_conversor ;;
  }

  dimension: dr_neptuno {
    type: number
    sql: ${TABLE}.dr_neptuno ;;
  }

  dimension: dr_slm {
    type: number
    sql: ${TABLE}.dr_slm ;;
  }

  dimension: e_neptuno {
    type: number
    sql: ${TABLE}.e_neptuno ;;
  }

  dimension: e_slm {
    type: number
    sql: ${TABLE}.e_slm ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: fecha_lectura {
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
    sql: ${TABLE}.fecha_lectura ;;
  }

  dimension: pcs_neptuno {
    type: number
    sql: ${TABLE}.pcs_neptuno ;;
  }

  dimension: pcs_slm {
    type: number
    sql: ${TABLE}.pcs_slm ;;
  }

  dimension: porcentaje_delta_e {
    type: number
    sql: ${TABLE}.porcentaje_delta_e ;;
  }

  dimension: retribucion {
    type: string
    sql: ${TABLE}.retribucion ;;
  }

  dimension: um {
    type: string
    sql: ${TABLE}.um ;;
  }

  dimension: um_descricion {
    type: string
    sql: ${TABLE}.um_descricion ;;
  }

  dimension: um_q_max {
    type: number
    sql: ${TABLE}.um_q_max ;;
  }

  dimension: um_q_min {
    type: number
    sql: ${TABLE}.um_q_min ;;
  }

  dimension: um_q_t {
    type: number
    sql: ${TABLE}.um_q_t ;;
  }

  dimension: vn_conversor {
    type: number
    sql: ${TABLE}.vn_conversor ;;
  }

  dimension: vn_neptuno {
    type: number
    sql: ${TABLE}.vn_neptuno ;;
  }

  dimension: vn_slm {
    type: number
    sql: ${TABLE}.vn_slm ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
