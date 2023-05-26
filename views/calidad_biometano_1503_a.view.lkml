# The name of this view in Looker is "Calidad Biometano 1503 A"
view: calidad_biometano_1503_a {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.calidad_biometano_1503A`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "C1" in Explore.

  dimension: c1 {
    type: number
    description: "Porcentaje molar de Metano (CH4)."
    sql: ${TABLE}.C1 ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_c1 {
    type: sum
    sql: ${c1} ;;
  }

  measure: average_c1 {
    type: average
    sql: ${c1} ;;
  }

  dimension: c2 {
    type: number
    description: "Porcentaje molar de Etano (C2H6)."
    sql: ${TABLE}.C2 ;;
  }

  dimension: c3 {
    type: number
    description: "Porcentaje molar de Propano (C3H8)."
    sql: ${TABLE}.C3 ;;
  }

  dimension: c6plus {
    type: number
    description: "Agregado de todas las moléculas pesadas (C6+)."
    sql: ${TABLE}.C6plus ;;
  }

  dimension: co2 {
    type: number
    description: "Porcentaje molar de Dióxido de Carbono (CO2)."
    sql: ${TABLE}.CO2 ;;
  }

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

  dimension: h2 {
    type: number
    description: "Porcentaje molar de Hidrógeno (H2)."
    sql: ${TABLE}.H2 ;;
  }

  dimension: hs {
    type: number
    description: "Poder Calorífico Superior (PCS) (kWh/Nm3)."
    sql: ${TABLE}.Hs ;;
  }

  dimension: i_c4 {
    type: number
    description: "Porcentaje molar de iso-Butano (C4H10)."
    sql: ${TABLE}.iC4 ;;
  }

  dimension: i_c5 {
    type: number
    description: "Porcentaje molar de iso-Pentano (C5H12)."
    sql: ${TABLE}.iC5 ;;
  }

  dimension: n2 {
    type: number
    description: "Porcentaje molar de Nitrógeno (N2)."
    sql: ${TABLE}.N2 ;;
  }

  dimension: n_c4 {
    type: number
    description: "Porcentaje molar de normal-Butano (C4H10)."
    sql: ${TABLE}.nC4 ;;
  }

  dimension: n_c5 {
    type: number
    description: "Porcentaje molar de normal-Pentano (C5H12)."
    sql: ${TABLE}.nC5 ;;
  }

  dimension: qn {
    type: number
    description: "Caudal normalizado horario."
    sql: ${TABLE}.qn ;;
  }

  dimension: rd {
    type: number
    description: "Densidad relativa."
    sql: ${TABLE}.rd ;;
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

  dimension: wis {
    type: number
    description: "Indice de Wobbe superior (kWh/m3)."
    sql: ${TABLE}.WIs ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
