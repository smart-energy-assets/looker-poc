view: nueva2 {
  derived_table: {
    sql: SELECT * FROM `sea-produccion.target_reporting.delta_factor_compresibilidad_linea` LIMIT 10
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: fecha_lectura {
    type: time
    sql: ${TABLE}.fecha_lectura ;;
  }

  dimension: um {
    type: string
    sql: ${TABLE}.um ;;
  }

  dimension: um_descricion {
    type: string
    sql: ${TABLE}.um_descricion ;;
  }

  dimension: linea {
    type: string
    sql: ${TABLE}.linea ;;
  }

  dimension: q_min {
    type: number
    sql: ${TABLE}.q_min ;;
  }

  dimension: q_max {
    type: number
    sql: ${TABLE}.q_max ;;
  }

  dimension: q_t {
    type: number
    sql: ${TABLE}.q_t ;;
  }

  dimension: croma {
    type: number
    sql: ${TABLE}.croma ;;
  }

  dimension: croma_modelo {
    type: number
    sql: ${TABLE}.croma_modelo ;;
  }

  dimension: croma_marca {
    type: number
    sql: ${TABLE}.croma_marca ;;
  }

  dimension: delta_e {
    type: number
    sql: ${TABLE}.delta_e ;;
  }

  dimension: delta_vn {
    type: number
    sql: ${TABLE}.delta_vn ;;
  }

  dimension: delta_vbc {
    type: number
    sql: ${TABLE}.delta_vbc ;;
  }

  dimension: delta_vbc_procesado {
    type: number
    sql: ${TABLE}.delta_vbc_procesado ;;
  }

  dimension: z_conversor {
    type: number
    sql: ${TABLE}.z_conversor ;;
  }

  dimension: factor_conversion_conversor {
    type: number
    sql: ${TABLE}.factor_conversion_conversor ;;
  }

  dimension: z_slm {
    type: number
    sql: ${TABLE}.z_slm ;;
  }

  dimension: tipo_error {
    type: number
    sql: ${TABLE}.tipo_error ;;
  }

  dimension: zn_slm {
    type: number
    sql: ${TABLE}.zn_slm ;;
  }

  dimension: fcv_slm {
    type: number
    sql: ${TABLE}.fcv_slm ;;
  }

  dimension: vn_slm {
    type: number
    sql: ${TABLE}.vn_slm ;;
  }

  dimension: e_slm {
    type: number
    sql: ${TABLE}.e_slm ;;
  }

  dimension: z_neptuno {
    type: number
    sql: ${TABLE}.z_neptuno ;;
  }

  dimension: zn_neptuno {
    type: number
    sql: ${TABLE}.zn_neptuno ;;
  }

  dimension: fcv_neptuno {
    type: number
    sql: ${TABLE}.fcv_neptuno ;;
  }

  dimension: vn_neptuno {
    type: number
    sql: ${TABLE}.vn_neptuno ;;
  }

  dimension: e_neptuno {
    type: number
    sql: ${TABLE}.e_neptuno ;;
  }

  dimension: presion {
    type: number
    sql: ${TABLE}.presion ;;
  }

  dimension: temperatura {
    type: number
    sql: ${TABLE}.temperatura ;;
  }

  dimension: co2_slm {
    type: number
    sql: ${TABLE}.co2_slm ;;
  }

  dimension: h2_slm {
    type: string
    sql: ${TABLE}.h2_slm ;;
  }

  dimension: pcs_slm {
    type: number
    sql: ${TABLE}.pcs_slm ;;
  }

  dimension: dr_slm {
    type: number
    sql: ${TABLE}.dr_slm ;;
  }

  dimension: co2_neptuno {
    type: number
    sql: ${TABLE}.co2_neptuno ;;
  }

  dimension: h2_neptuno {
    type: number
    sql: ${TABLE}.h2_neptuno ;;
  }

  dimension: pcs_neptuno {
    type: number
    sql: ${TABLE}.pcs_neptuno ;;
  }

  dimension: dr_neptuno {
    type: number
    sql: ${TABLE}.dr_neptuno ;;
  }

  set: detail {
    fields: [
      fecha_lectura_time,
      um,
      um_descricion,
      linea,
      q_min,
      q_max,
      q_t,
      croma,
      croma_modelo,
      croma_marca,
      delta_e,
      delta_vn,
      delta_vbc,
      delta_vbc_procesado,
      z_conversor,
      factor_conversion_conversor,
      z_slm,
      tipo_error,
      zn_slm,
      fcv_slm,
      vn_slm,
      e_slm,
      z_neptuno,
      zn_neptuno,
      fcv_neptuno,
      vn_neptuno,
      e_neptuno,
      presion,
      temperatura,
      co2_slm,
      h2_slm,
      pcs_slm,
      dr_slm,
      co2_neptuno,
      h2_neptuno,
      pcs_neptuno,
      dr_neptuno
    ]
  }
}
