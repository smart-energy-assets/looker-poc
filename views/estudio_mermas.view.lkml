# The name of this view in Looker is "Estudio Mermas"
view: estudio_mermas {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.estudio_mermas`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Centro Trabajo" in Explore.

  dimension: um_linea {
    primary_key: yes
    type:string
    sql: CONCAT(${fecha_lectura_date},${TABLE}.um, ${TABLE}.linea) ;;
  }



  dimension: centro_trabajo {
    type: string
    sql: ${TABLE}.centro_trabajo ;;
  }

  dimension: centro_trabajo_codigo {
    type: string
    sql: ${TABLE}.centro_trabajo_codigo ;;
  }

  dimension: computador_caudal_marca {
    type: string
    sql: ${TABLE}.computador_caudal_marca ;;
  }

  dimension: computador_caudal_modelo {
    type: string
    sql: ${TABLE}.computador_caudal_modelo ;;
  }

  dimension: computador_caudal_numero_serie {
    type: string
    sql: ${TABLE}.computador_caudal_numero_serie ;;
  }

  dimension: contador_ansi {
    type: number
    sql: ${TABLE}.contador_ansi ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_contador_ansi {
    type: sum
    sql: ${contador_ansi} ;;
  }

  measure: average_contador_ansi {
    type: average
    sql: ${contador_ansi} ;;
  }

  dimension: contador_caudal_maximo {
    type: number
    sql: ${TABLE}.contador_caudal_maximo ;;
  }

  dimension: contador_caudal_minimo {
    type: number
    sql: ${TABLE}.contador_caudal_minimo ;;
  }

  dimension: contador_caudal_transicion {
    type: number
    sql: ${TABLE}.contador_caudal_transicion ;;
  }

  dimension: contador_codigo_certificado {
    type: string
    sql: ${TABLE}.contador_codigo_certificado ;;
  }

  dimension: contador_diametro {
    type: number
    sql: ${TABLE}.contador_diametro ;;
  }

  dimension: contador_familia {
    type: string
    sql: ${TABLE}.contador_familia ;;
  }

  dimension: contador_marca {
    type: string
    sql: ${TABLE}.contador_marca ;;
  }

  dimension: contador_modelo {
    type: string
    sql: ${TABLE}.contador_modelo ;;
  }

  dimension: contador_numero_serie {
    type: string
    sql: ${TABLE}.contador_numero_serie ;;
  }

  dimension: cromatografo {
    type: string
    sql: ${TABLE}.cromatografo ;;
  }

  dimension: cromatografo_marca {
    type: string
    sql: ${TABLE}.cromatografo_marca ;;
  }

  dimension: cromatografo_modelo {
    type: string
    sql: ${TABLE}.cromatografo_modelo ;;
  }

  dimension: cromatografo_numero_serie {
    type: string
    sql: ${TABLE}.cromatografo_numero_serie ;;
  }

  dimension: e {
    type: number
    sql: ${TABLE}.e ;;
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

  dimension: linea {
    type: string
    sql: ${TABLE}.linea ;;
  }

  dimension: linea_diametro {
    type: string
    sql: ${TABLE}.linea_diametro ;;
  }

  dimension: linea_tamano {
    type: string
    sql: ${TABLE}.linea_tamano ;;
  }

  dimension: linea_tipo {
    type: string
    sql: ${TABLE}.linea_tipo ;;
  }

  dimension: posicion {
    type: string
    sql: ${TABLE}.posicion ;;
  }

  dimension: posicion_descripcion {
    type: string
    sql: ${TABLE}.posicion_descripcion ;;
  }

  dimension: posicion_latitud {
    type: string
    sql: ${TABLE}.posicion_latitud ;;
  }

  dimension: posicion_longitud {
    type: string
    sql: ${TABLE}.posicion_longitud ;;
  }

  dimension: ramal_entrada {
    type: string
    sql: ${TABLE}.ramal_entrada ;;
  }

  dimension: ramal_entrada_descripcion {
    type: string
    sql: ${TABLE}.ramal_entrada_descripcion ;;
  }

  dimension: ramal_salida {
    type: string
    sql: ${TABLE}.ramal_salida ;;
  }

  dimension: ramal_salida_descripcion {
    type: string
    sql: ${TABLE}.ramal_salida_descripcion ;;
  }

  dimension: um {
    type: string
    sql: ${TABLE}.um ;;
  }

  dimension: um_descripcion {
    type: string
    sql: ${TABLE}.um_descripcion ;;
  }

  dimension: um_sistema_lectura {
    type: string
    sql: ${TABLE}.um_sistema_lectura ;;
  }

  dimension: um_tipo {
    type: string
    sql: ${TABLE}.um_tipo ;;
  }

  dimension: unidad_organizativa {
    type: string
    sql: ${TABLE}.unidad_organizativa ;;
  }

  dimension: vn {
    description: "Volumen normalizado de consumo"
    type: number
    sql: ${TABLE}.vn ;;
  }

  dimension: zona {
    type: string
    sql: ${TABLE}.zona ;;
    drill_fields: [centro_trabajo, unidad_organizativa]
  }

measure: volumen_normal_medio {
  type: average
  sql: ${vn} ;;
}
  measure: count {
    type: count
    drill_fields: []
  }

  measure: vn_promedio {
    type: average
    sql: ${vn} ;;
    drill_fields: [contador_familia, centro_trabajo, um, total_contador_ansi]
  }

}
