# The name of this view in Looker is "Infraestructuras"
view: infraestructuras {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.infraestructuras`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Centro Trabajo" in Explore.

  dimension: centro_trabajo {
    type: string
    description: "Centro."
    sql: ${TABLE}.centro_trabajo ;;
  }

  dimension: centro_trabajo_codigo {
    type: string
    description: "Código del centro de trabajo."
    sql: ${TABLE}.centro_trabajo_codigo ;;
  }

  dimension: computador_caudal_marca {
    type: string
    description: "Marca del computador de caudal."
    sql: ${TABLE}.computador_caudal_marca ;;
  }

  dimension: computador_caudal_modelo {
    type: string
    description: "Modelo del computador de caudal."
    sql: ${TABLE}.computador_caudal_modelo ;;
  }

  dimension: computador_caudal_numero_serie {
    type: string
    description: "Número de serie del computador de caudal."
    sql: ${TABLE}.computador_caudal_numero_serie ;;
  }

  dimension: contador_ansi {
    type: number
    description: "ANSI del contador (presión máxima) [bar]."
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
    description: "Caudal máximo por hora del contador [m3/h]."
    sql: ${TABLE}.contador_caudal_maximo ;;
  }

  dimension: contador_caudal_minimo {
    type: number
    description: "Caudal mínimo por hora del contador [m3/h]."
    sql: ${TABLE}.contador_caudal_minimo ;;
  }

  dimension: contador_caudal_transicion {
    type: number
    description: "Caudal de transición por hora del contador."
    sql: ${TABLE}.contador_caudal_transicion ;;
  }

  dimension: contador_codigo_certificado {
    type: string
    description: "Código de certificado del contador."
    sql: ${TABLE}.contador_codigo_certificado ;;
  }

  dimension: contador_diametro {
    type: number
    description: "Diametro del contador [mm]."
    sql: ${TABLE}.contador_diametro ;;
  }

  dimension: contador_familia {
    type: string
    description: "Familia del contador."
    sql: ${TABLE}.contador_familia ;;
  }

  dimension: contador_marca {
    type: string
    description: "Marca del contador."
    sql: ${TABLE}.contador_marca ;;
  }

  dimension: contador_modelo {
    type: string
    description: "Modelo del contador."
    sql: ${TABLE}.contador_modelo ;;
  }

  dimension: contador_numero_serie {
    type: string
    description: "Número de serie del contador."
    sql: ${TABLE}.contador_numero_serie ;;
  }

  dimension: cromatografo {
    type: string
    description: "Cromatógrafo."
    sql: ${TABLE}.cromatografo ;;
  }

  dimension: cromatografo_marca {
    type: string
    description: "Marca del cromatógrafo."
    sql: ${TABLE}.cromatografo_marca ;;
  }

  dimension: cromatografo_modelo {
    type: string
    description: "Modelo del cromatógrafo."
    sql: ${TABLE}.cromatografo_modelo ;;
  }

  dimension: cromatografo_numero_serie {
    type: string
    description: "Número de serie del cromatógrafo."
    sql: ${TABLE}.cromatografo_numero_serie ;;
  }

  dimension: linea {
    type: string
    description: "Línea de la unidad de medida."
    sql: ${TABLE}.linea ;;
  }

  dimension: linea_diametro {
    type: string
    description: "Diámetro de la línea de la unidad de medida [mm]."
    sql: ${TABLE}.linea_diametro ;;
  }

  dimension: linea_tamano {
    type: string
    description: "Tamaño de la línea de la unidad de medida (G-XXXX)."
    sql: ${TABLE}.linea_tamano ;;
  }

  dimension: linea_tipo {
    type: string
    description: "Tipo de medidor de la línea de la unidad de medida. Turbina o Ultrasonido"
    sql: ${TABLE}.linea_tipo ;;
  }

  dimension: posicion {
    type: string
    description: "Posición de las unidades de medición."
    sql: ${TABLE}.posicion ;;
  }

  dimension: posicion_descripcion {
    type: string
    description: "Descripción de la posición de las unidades de medición."
    sql: ${TABLE}.posicion_descripcion ;;
  }

  dimension: posicion_latitud {
    type: string
    description: "Latitud de la posición de las unidades de medición."
    sql: ${TABLE}.posicion_latitud ;;
  }

  dimension: posicion_longitud {
    type: string
    description: "Longitud de la posición de las unidades de medición."
    sql: ${TABLE}.posicion_longitud ;;
  }

  dimension: ramal_entrada {
    type: string
    description: "Ramal de entrada de gas de la unidad de medición."
    sql: ${TABLE}.ramal_entrada ;;
  }

  dimension: ramal_entrada_descripcion {
    type: string
    description: "Descripción del ramal de entrada de gas de la unidad de medición."
    sql: ${TABLE}.ramal_entrada_descripcion ;;
  }

  dimension: ramal_salida {
    type: string
    description: "Ramal de salida de gas de la unidad de medición."
    sql: ${TABLE}.ramal_salida ;;
  }

  dimension: ramal_salida_descripcion {
    type: string
    description: "Descripción del ramal de salida de gas de la unidad de medición."
    sql: ${TABLE}.ramal_salida_descripcion ;;
  }

  dimension: um {
    primary_key: yes
    type: string
    description: "Unidad de medición."
    sql: ${TABLE}.um ;;
  }

  dimension: um_descripcion {
    type: string
    description: "Descripción de la unidad de medición."
    sql: ${TABLE}.um_descripcion ;;
  }

  dimension: um_sistema_lectura {
    type: string
    description: "Fuente de lectura de la unidad de medición."
    sql: ${TABLE}.um_sistema_lectura ;;
  }

  dimension: um_tipo {
    type: string
    description: "Tipo de unidad de Medición: ERM = Estación de Regulación y Medición; EM = Unidad de Medición."
    sql: ${TABLE}.um_tipo ;;
  }

  dimension: unidad_organizativa {
    type: string
    description: "Unidad de gestión organizativa de Enagás."
    sql: ${TABLE}.unidad_organizativa ;;
  }

  dimension: zona {
    type: string
    description: "Zona geográfica."
    sql: ${TABLE}.zona ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
