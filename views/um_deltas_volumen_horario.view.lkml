# The name of this view in Looker is "Um Deltas Volumen Horario"
view: um_deltas_volumen_horario {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.um_deltas_volumen_horario`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Delta Volumen Bruto" in Explore.

  dimension: delta_volumen_bruto {
    type: number
    description: "Delta del volumen de gas medido."
    sql: ${TABLE}.delta_volumen_bruto ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_delta_volumen_bruto {
    type: sum
    sql: ${delta_volumen_bruto} ;;
  }

  measure: average_delta_volumen_bruto {
    type: average
    sql: ${delta_volumen_bruto} ;;
  }

  dimension: estado_validacion {
    type: string
    description: "A definir."
    sql: ${TABLE}.estado_validacion ;;
  }

  dimension: observaciones {
    type: string
    description: "Observaciones identificadas sobre los datos."
    sql: ${TABLE}.observaciones ;;
  }

  dimension: puntuacion {
    type: number
    description: "A definir."
    sql: ${TABLE}.puntuacion ;;
  }

  dimension: tip {
    type: number
    description: "A definir."
    sql: ${TABLE}.tip ;;
  }

  dimension: um {
    type: string
    description: "Unidad de medición."
    sql: ${TABLE}.um ;;
  }

  dimension: um_descripcion {
    type: string
    description: "Descripción de la unidad de medida."
    sql: ${TABLE}.um_descripcion ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: um_fecha_lectura {
    type: time
    description: "Fecha de captura de datos de la unidad de medida."
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.um_fecha_lectura ;;
  }

  dimension: um_sistema_origen_datos {
    type: string
    description: "Sistema de origen de Medición: B = lectura del BRICK de Neptuno, G = lectura traída de GYCAM, A = lectura traída de ATR, O = lectura traída de ORION, S = lectura traída de SLM, SL-A = lectura traída de SL-ATR."
    sql: ${TABLE}.um_sistema_origen_datos ;;
  }

  dimension: um_tipo {
    type: string
    description: "Tipo de unidad de Medición: ERM = Estación de Regulación y Compresión; EM = Unidad de Medida."
    sql: ${TABLE}.um_tipo ;;
  }

  dimension: volumen_bruto {
    type: number
    description: "Volumen bruto de gas medido."
    sql: ${TABLE}.volumen_bruto ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
