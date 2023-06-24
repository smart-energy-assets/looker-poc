view: stock {
  derived_table: {
    explore_source: branch_union_stock_daily {
      column: ts_date {}
      column: branch_id {}
      column: total_stock_e_diff {}
      column: total_stock_vn_diff {}
      filters: {
        field: branch_union_stock_daily.branch_id
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

  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${ts_date_date},${branch_id}) ;;
  }

  dimension: branch_id {
    description: ""
  }
  dimension: total_stock_e_diff {
    description: "Delta Stock en Energía"
    value_format: "0.000,,\" GWh\""
    type: number
  }
  dimension: total_stock_vn_diff {
    description: "Delta Stock en Volumen"
    value_format: "0.000,\" dam3\""
    type: number
  }

  measure: total_stock_vn {
    type: sum
    sql: ${total_stock_vn_diff} ;;
    value_format: "0.000,\" dam3\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
    label: "Total Delta stock en Volumen Normalizado"
  }
  measure: total_stock_e {
    type: sum
    sql: ${total_stock_e_diff} ;;
    value_format: "0.000,,\" GWh\""
    #drill_fields: [looker_measurement_unit.name,looker_lines.name]
    label: "Total Delta Stock en Energia"
  }

}
