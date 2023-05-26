# The name of this view in Looker is "Delta Factor Compresibilidad Linea"
view: delta_factor_compresibilidad_linea {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.delta_factor_compresibilidad_linea`
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

  dimension: delta_vbc {
    type: number
    sql: ${TABLE}.delta_vbc ;;
  }

  dimension: delta_vbc_procesado {
    type: number
    sql: ${TABLE}.delta_vbc_procesado ;;
  }

  dimension: delta_vn {
    type: number
    sql: ${TABLE}.delta_vn ;;
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

  dimension: factor_conversion_conversor {
    type: number
    sql: ${TABLE}.factor_conversion_conversor ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_factor_conversion_conversor {
    type: sum
    sql: ${factor_conversion_conversor} ;;
  }

  measure: average_factor_conversion_conversor {
    type: average
    sql: ${factor_conversion_conversor} ;;
  }

  dimension: fcv_neptuno {
    type: number
    sql: ${TABLE}.fcv_neptuno ;;
  }

  dimension: fcv_slm {
    type: number
    sql: ${TABLE}.fcv_slm ;;
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

  dimension: h2_neptuno {
    type: number
    sql: ${TABLE}.h2_neptuno ;;
  }

  dimension: h2_slm {
    type: string
    sql: ${TABLE}.h2_slm ;;
  }

  dimension: linea {
    type: string
    sql: ${TABLE}.linea ;;
  }

  dimension: pcs_neptuno {
    type: number
    sql: ${TABLE}.pcs_neptuno ;;
  }

  dimension: pcs_slm {
    type: number
    sql: ${TABLE}.pcs_slm ;;
  }

  dimension: presion {
    type: number
    sql: ${TABLE}.presion ;;
  }

  dimension: q_max {
    type: number
    sql: ${TABLE}.q_max ;;
  }

  dimension: q_min {
    type: number
    sql: ${TABLE}.q_min ;;
  }

  dimension: q_t {
    type: number
    sql: ${TABLE}.q_t ;;
  }

  dimension: temperatura {
    type: number
    sql: ${TABLE}.temperatura ;;
  }

  dimension: tipo_error {
    type: number
    sql: ${TABLE}.tipo_error ;;
  }

  dimension: um {
    type: string
    sql: ${TABLE}.um ;;
  }

  dimension: um_descricion {
    type: string
    sql: ${TABLE}.um_descricion ;;
  }

  dimension: vn_neptuno {
    type: number
    sql: ${TABLE}.vn_neptuno ;;
  }

  dimension: vn_slm {
    type: number
    sql: ${TABLE}.vn_slm ;;
  }

  dimension: z_conversor {
    type: number
    sql: ${TABLE}.z_conversor ;;
  }

  dimension: z_neptuno {
    type: number
    sql: ${TABLE}.z_neptuno ;;
  }

  dimension: z_slm {
    type: number
    sql: ${TABLE}.z_slm ;;
  }

  dimension: zn_neptuno {
    type: number
    sql: ${TABLE}.zn_neptuno ;;
  }

  dimension: zn_slm {
    type: number
    sql: ${TABLE}.zn_slm ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
