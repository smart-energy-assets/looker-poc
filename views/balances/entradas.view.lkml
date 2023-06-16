view: entradas {
  derived_table: {
    explore_source: looker_deltas_historical_daily {
      column: ts_time {}
      column: total_delta_e {}
      column: total_delta_vn {}
      column: in_branch_id { field: looker_measurement_unit.in_branch_id }
      column: name { field: looker_measurement_unit.name }
      filters: {
        field: looker_measurement_unit.in_branch_id
        value: "-NULL"
      }
    }
  }
  dimension: ts_time {
    description: ""
    type: date_time
  }

  dimension_group: time_stamp {
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
    sql: ${ts_time} ;;
  }

  dimension: total_delta_e {
    label: "Looker Deltas Historical Daily Consumo en Energía"
    description: ""
    value_format: "0.000,,\" GWh\""
    type: number
  }
  dimension: total_delta_vn {
    label: "Looker Deltas Historical Daily Consumo en Volumen Normalizado"
    description: ""
    value_format: "0.000,\" dam3\""
    type: number
  }
  dimension: in_branch_id {
    label: "Looker Measurement Unit Id Ramal de Entrada"
    description: ""
  }
  dimension: name {
    label: "Looker Measurement Unit Nombre de Unidad de Medida"
    description: ""
  }

  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${entradas.ts_time}, ${entradas.in_branch_id}) ;;
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

  measure: average_delta_e {
    type: average
    sql: ${total_delta_e} ;;
    #drill_fields:[looker_measurement_unit.name,looker_lines.name]
    value_format: "0.000,,\" GWh\""
    label: "Consumo Medio en Energía"
  }
  measure: average_delta_vn {
    type: average
    sql: ${total_delta_vn} ;;
    value_format: "0.000,\" dam3\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
    label: "Consumo Medio en Volumen Normalizado"
  }


}
