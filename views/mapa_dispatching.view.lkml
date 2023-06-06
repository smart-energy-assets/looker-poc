# The name of this view in Looker is "Mapa Dispatching"
view: mapa_dispatching {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.mapa_dispatching`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Caudal Nominal" in Explore.

  dimension: caudal_nominal {
    type: number
    description: "Caudal nominal medio horario de la posición."
    sql: ${TABLE}.caudal_nominal ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_caudal_nominal {
    type: sum
    sql: ${caudal_nominal} ;;
  }

  measure: average_caudal_nominal {
    type: average
    sql: ${caudal_nominal} ;;
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

  dimension: posicion {
    type: string
    description: "Código único identificador de la posición."
    sql: ${TABLE}.posicion ;;
  }

  dimension: posicion_descripcion {
    type: string
    description: "Nombre de la posición."
    sql: ${TABLE}.posicion_descripcion ;;
  }

  dimension: posicion_latitud {
    type: number
    description: "Latitud de la posición."
    sql: ${TABLE}.posicion_latitud ;;
  }

  dimension: posicion_longitud {
    type: number
    description: "Longitud de la posición."
    sql: ${TABLE}.posicion_longitud ;;
  }

  dimension: presion {
    type: number
    description: "Presión media horaria de la posición."
    sql: ${TABLE}.presion ;;
  }

  dimension: temperatura {
    type: number
    description: "Temperatura media horaria de la posición."
    sql: ${TABLE}.temperatura ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: location {
    type: location
    sql_latitude: ${posicion_latitud} ;;
    sql_longitude: ${posicion_longitud} ;;
  }
}
