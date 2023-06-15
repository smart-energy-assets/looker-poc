view: input_data{
  derived_table: {
    explore_source: looker_deltas_historical_daily {
      column: ts_date {}
      column: total_delta_vn {}
      filters: {
        field: looker_deltas_historical_daily.ts_date
        value: "2023/04/01 to 2023/06/01"
      }
      filters: {
        field: looker_measurement_unit.name
        value: "K01-M.MA"
      }
    }
  }
}
