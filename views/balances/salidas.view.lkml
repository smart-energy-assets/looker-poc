view: salidas {
  derived_table: {
    explore_source: looker_deltas_historical_daily {
      column: ts_date {}
      column: out_branch_id { field: looker_measurement_unit.out_branch_id }
      #column: name { field: looker_measurement_unit.name }
      column: total_delta_e {}
      column: total_delta_vn {}
      filters: {
        field: looker_measurement_unit.out_branch_id
        value: "-NULL"
      }
    }
  }
  dimension_group: ts_date {
    description: "Fecha"
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
  }

  dimension: out_branch_id {
    label: "Looker Measurement Unit Id Ramal de Salida"
    description: ""
  }

#  dimension: name {
#    label: "Nombre de Unidad de Medida de Salida"
#    description: ""
#  }

  dimension: total_delta_e {
    label: "Consumo  en Energía de Salida"
    description: ""
    value_format: "0.000,,\" GWh\""
    type: number
  }
  dimension: total_delta_vn {
    label: "Consumo en Volumen Normalizado de Salida"
    description: ""
    value_format: "0.000,\" dam3\""
    type: number
  }

  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${ts_date_date},${salidas.out_branch_id}) ;;
  }

  measure: total_vn {
    type: sum
    sql: ${total_delta_vn} ;;
    value_format: "0.000,\" dam3\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
    label: "Consumo Total en Volumen Normalizado de Salida"
  }
  measure: total_e {
    type: sum
    sql: ${total_delta_e} ;;
    value_format: "0.000,,\" GWh\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
    label: "Consumo Total en Energia de Salida"
  }

  measure: average_delta_e {
    type: average
    sql: ${total_delta_e} ;;
    #drill_fields:[looker_measurement_unit.name,looker_lines.name]
    value_format: "0.000,,\" GWh\""
    label: "Consumo Medio en Energía de Salida"
  }
  measure: average_delta_vn {
    type: average
    sql: ${total_delta_vn} ;;
    value_format: "0.000,\" dam3\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
    label: "Consumo Medio en Volumen Normalizado de Salida"
  }

}
