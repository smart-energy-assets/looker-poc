# If necessary, uncomment the line below to include explore_source.

# include: "neptuno_looker_poc.model.lkml"

view: entradas_balance {
  derived_table: {
    explore_source: looker_deltas_historical_daily {
      column: ts_date {}
      column: total_delta_e {}
      column: total_delta_vn {}
      column: in_branch_id { field: looker_measurement_unit.in_branch_id }
      filters: {
        field: looker_deltas_historical_daily.ts_year
        value: "1 years"
      }
      expression_custom_filter: (NOT is_null(${looker_measurement_unit.in_branch_name}) OR NOT is_null( ${looker_measurement_unit.out_branch_name})) ;;
    }
  }
  dimension: ts_date {
    description: ""
    type: date
  }
  dimension: total_delta_e {
    label: "Consumo en Energía"
    description: ""
    value_format: "0.000,,\" GWh\""
    type: number
  }
  dimension: total_delta_vn {
    label: "Consumo en Volumen Normalizado"
    description: ""
    value_format: "0.000,\" dam3\""
    type: number
  }
  dimension: in_branch_id {
    label: "Id Ramal de Entrada"
    description: ""
  }
  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${TABLE}.ts_date, ${TABLE}.in_branch_id) ;;
  }

  measure: total_vn {
    type: sum
    sql: ${total_delta_vn} ;;
    value_format: "0.000,\" dam3\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
    label: "Consumo Total en Volumen Normalizado"
  }
  measure: total_e {
    type: sum
    sql: ${total_delta_e} ;;
    value_format: "0.000,,\" GWh\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
    label: "Consumo Total en Energia"
  }


}
