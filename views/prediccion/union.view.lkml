include: "arima_prediccion.view"

view: union {
  label: "ARIMA Model Prediction"
  derived_table: {
    sql: SELECT TIMESTAMP(fecha_lectura_month) AS fecha, diferencia_de_energia_GWh, NULL AS forecast_value, NULL AS standard_error, NULL AS confidence_level, NULL AS prediction_interval_lower_bound, NULL AS prediction_interval_upper_bound, false AS is_forecast
      FROM ${datos.SQL_TABLE_NAME}
      UNION ALL
      SELECT forecast_timestamp, forecast_value, forecast_value, standard_error, confidence_level, prediction_interval_lower_bound, prediction_interval_upper_bound, true AS is_forecast
      FROM ${arima_prediccion.SQL_TABLE_NAME} ;;
  }

  extends: [arima_prediccion]

  dimension: is_forecast {
    type:yesno
  }

  dimension_group: forecast {
    hidden: yes
  }

  dimension_group: fecha {
    type: time
    timeframes: [raw, date, day_of_year, week, week_of_year, month, month_name, quarter, year]
    sql: ${TABLE}.fecha ;;
  }

  dimension: forecast_value {
    hidden:yes
    type: number
    sql: ${TABLE}.total_delta_vn ;;
    value_format_name: decimal_2
  }

  measure: actual_delta_vn {
    type: sum
    sql: ${forecast_value} ;;
    filters: [is_forecast: "no"]
    value_format_name: decimal_2
  }

  measure: forecasted_delta_vn {
    type: sum
    sql: ${forecast_value} ;;
    filters: [is_forecast: "yes"]
    value_format_name: decimal_2
  }

  measure: total_delta_vn {
    type: number
    sql: ${actual_delta_vn} + ${forecasted_delta_vn} ;;
    value_format_name: decimal_2
  }

  measure: total_prediction_interval_lower_bound {
    type: sum
    sql: ${prediction_interval_lower_bound} ;;
    value_format_name: decimal_1
  }

  measure: total_prediction_interval_upper_bound {
    type: sum
    sql: ${prediction_interval_upper_bound} ;;
    value_format_name: decimal_1
  }
}
