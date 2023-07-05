view: arima_prediccion {
  derived_table: {
    sql: SELECT * FROM ML.FORECAST(
      MODEL ${arima.SQL_TABLE_NAME},
      STRUCT(5 AS horizon, 0.95 AS confidence_level)) ;;
  }

  dimension_group: forecast {
    type: time
    timeframes: [raw, date, day_of_year, week, week_of_year, month, month_name, quarter, year]
    sql: ${TABLE}.forecast_timestamp ;;
  }

  dimension: forecast_value {
    type: number
    value_format_name: decimal_2
  }

  dimension: standard_error {
    type: number
    value_format_name: decimal_2
  }

  dimension: confidence_level {
    type: number
    value_format_name: percent_1
  }

  dimension: prediction_interval_lower_bound {
    type: number
    value_format_name: decimal_2
  }

  dimension: prediction_interval_upper_bound {
    type: number
    value_format_name: decimal_2
  }

  measure: prediccion {
    type: sum
    sql:  ${forecast_value} ;;
    value_format_name: decimal_2
  }
}
