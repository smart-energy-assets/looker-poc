view: arima {
  derived_table: {
    persist_for: "24 hours"
    sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME} OPTIONS (
        model_type='ARIMA_PLUS',
        time_series_timestamp_col='fecha_lectura_month',
        time_series_data_col='energia_GWh',
        time_series_data_col = 'diferencia_de_energia_GWh',
        horizon=30,
        auto_arima=TRUE,
        data_frequency='DAILY'
        ) AS
      SELECT
         *
      FROM ${input_datos.SQL_TABLE_NAME};;
  }
}
