# The name of this view in Looker is "Calendario"
view: calendario {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `target_reporting.calendario`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ano Espana" in Explore.

  dimension: ano_espana {
    type: number
    description: "Año de España."
    sql: ${TABLE}.ano_espana ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_ano_espana {
    type: sum
    sql: ${ano_espana} ;;
  }

  measure: average_ano_espana {
    type: average
    sql: ${ano_espana} ;;
  }

  dimension: dia_espana {
    type: number
    description: "Dia de España."
    sql: ${TABLE}.dia_espana ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: fecha_espana {
    type: time
    description: "Fecha de España."
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.fecha_espana ;;
  }

  dimension_group: fecha_internacional_utc {
    type: time
    description: "Fecha internacional UTC."
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.fecha_internacional_utc ;;
  }

  dimension: hora_espana {
    type: number
    description: "Hora de España."
    sql: ${TABLE}.hora_espana ;;
  }

  dimension: mes_espana {
    type: number
    description: "Mes de España."
    sql: ${TABLE}.mes_espana ;;
  }

  dimension: semana_espana {
    type: number
    description: "Semana de España."
    sql: ${TABLE}.semana_espana ;;
  }

  dimension: trimestre_espana {
    type: number
    description: "Trimestre de España."
    sql: ${TABLE}.trimestre_espana ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
