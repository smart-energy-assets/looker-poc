view: arima_model {
  derived_table: {
    persist_for: "24 hours"
    sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME} OPTIONS (
        model_type='ARIMA_PLUS',
        time_series_timestamp_col='ts_date',
        time_series_data_col='total_delta_vn',
        horizon=30,
        auto_arima=TRUE,
        data_frequency='DAILY'
        ) AS
      SELECT
         *
      FROM ${input_data.SQL_TABLE_NAME};;
  }
}
