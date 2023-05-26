# The name of this view in Looker is "Calidad Biometano B211"
view: calidad_biometano_b211 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.calidad_biometano_B211`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: fecha_lectura {
    type: time
    description: "Fecha horaria de lectura de la información de la medida."
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

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Mean C1" in Explore.

  dimension: mean_c1 {
    type: number
    description: "Media del porcentaje molar de Metano (CH4)."
    sql: ${TABLE}.Mean_C1 ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_mean_c1 {
    type: sum
    sql: ${mean_c1} ;;
  }

  measure: average_mean_c1 {
    type: average
    sql: ${mean_c1} ;;
  }

  dimension: mean_c2 {
    type: number
    description: "Media del porcentaje molar de Etano (C2H6)."
    sql: ${TABLE}.Mean_C2 ;;
  }

  dimension: mean_c3 {
    type: number
    description: "Media del porcentaje molar de Propano (C3H8)."
    sql: ${TABLE}.Mean_C3 ;;
  }

  dimension: mean_c6plus {
    type: number
    description: "Media del porcentaje molar del agregado de todas las moléculas pesadas (C6+)."
    sql: ${TABLE}.Mean_C6plus ;;
  }

  dimension: mean_co2 {
    type: number
    description: "Media del porcentaje molar de Dióxido de Carbono (CO2)."
    sql: ${TABLE}.Mean_CO2 ;;
  }

  dimension: mean_h2 {
    type: number
    description: "Media del porcentaje molar de Hidrógeno (H2)."
    sql: ${TABLE}.Mean_H2 ;;
  }

  dimension: mean_hs {
    type: number
    description: "Media del poder Calorífico Superior (PCS) (kWh/Nm3)."
    sql: ${TABLE}.Mean_Hs ;;
  }

  dimension: mean_i_c4 {
    type: number
    description: "Media del porcentaje molar de iso-Butano (C4H10)."
    sql: ${TABLE}.Mean_iC4 ;;
  }

  dimension: mean_i_c5 {
    type: number
    description: "Media del porcentaje molar de iso-Pentano (C5H12)."
    sql: ${TABLE}.Mean_iC5 ;;
  }

  dimension: mean_n2 {
    type: number
    description: "Media del porcentaje molar de Nitrógeno (N2)."
    sql: ${TABLE}.Mean_N2 ;;
  }

  dimension: mean_n_c4 {
    type: number
    description: "Media del porcentaje molar de normal-Butano (C4H10)."
    sql: ${TABLE}.Mean_nC4 ;;
  }

  dimension: mean_n_c5 {
    type: number
    description: "Media del porcentaje molar de normal-Pentano (C5H12)."
    sql: ${TABLE}.Mean_nC5 ;;
  }

  dimension: mean_rd {
    type: number
    description: "Media de la densidad relativa."
    sql: ${TABLE}.Mean_rd ;;
  }

  dimension: mean_wi {
    type: number
    description: "Media del indice de Wobbe superior (kWh/m3)."
    sql: ${TABLE}.Mean_WI ;;
  }

  dimension: qn {
    type: number
    description: "Caudal normalizado horario."
    sql: ${TABLE}.qn ;;
  }

  dimension: um {
    type: string
    description: "Código único identificador de la unidad de medida."
    sql: ${TABLE}.um ;;
  }

  dimension: um_descripcion {
    type: string
    description: "Nombre de la unidad de medida."
    sql: ${TABLE}.um_descripcion ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
