# The name of this view in Looker is "Looker Lines"
view: looker_lines {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `sea-produccion.target_reporting.looker_lines`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    label: "Id de linea"
    hidden: yes

  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: calibration_counter {
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
    datatype: datetime
    sql: ${TABLE}.calibration_counter_date ;;
    hidden: yes
  }

  dimension_group: calibration_validation {
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
    datatype: datetime
    sql: ${TABLE}.calibration_validation ;;
    hidden: yes
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Certificate Code" in Explore.
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    label: "Nombre de linea"
    #  drill_fields:[looker_measurement_unit.name,looker_lines.name]
  }

  dimension: certificate_code {
    type: string
    sql: ${TABLE}.certificate_code ;;
    hidden: yes
  }

  dimension: counter_diameter {
    type: string
    sql: ${TABLE}.counter_diameter ;;
    hidden: yes
  }

  dimension: counter_values {
    type: string
    sql: ${TABLE}.counter_values ;;
    hidden: yes
  }

  dimension_group: created {
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
    datatype: datetime
    sql: ${TABLE}.created_at ;;
    hidden: yes
  }

  dimension: diameter {
    type: string
    sql: ${TABLE}.diameter ;;
    hidden: yes
  }

  dimension: flow_computers_id {
    type: string
    sql: ${TABLE}.flowComputersId ;;
    hidden: yes
  }

  dimension: hardware {
    type: string
    sql: ${TABLE}.hardware ;;
    hidden: yes
  }

  dimension_group: instalation_counter {
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
    datatype: datetime
    sql: ${TABLE}.instalation_counter_date ;;
    hidden: yes
  }

  dimension: m_model_id {
    type: string
    sql: ${TABLE}.mModelId ;;
    hidden: yes
  }

  dimension: m_number {
    type: string
    sql: ${TABLE}.m_number ;;
    hidden: yes
  }

  dimension: m_type {
    type: string
    sql: ${TABLE}.m_type ;;
    hidden: yes
  }

  dimension: measurement_unit_id {
    type: string
    sql: ${TABLE}.measurementUnitId ;;
    label: "Id de Unidad de Medida"
    hidden: yes
  }

  dimension: modify_counter_values {
    type: yesno
    sql: ${TABLE}.modify_counter_values ;;
    hidden: yes
  }

  dimension: old_id {
    type: string
    sql: ${TABLE}.old_id ;;
    hidden: yes
  }

  dimension: order {
    type: string
    sql: ${TABLE}.`order` ;;
    hidden: yes
  }

  dimension: preassure_max {
    type: string
    sql: ${TABLE}.preassure_max ;;
    hidden: yes
  }

  dimension: size {
    type: string
    sql: ${TABLE}.size ;;
    hidden: yes
  }

  dimension: size_counter {
    type: string
    sql: ${TABLE}.size_counter ;;
    hidden: yes
  }

  dimension_group: updated {
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
    datatype: datetime
    sql: ${TABLE}.updated_at ;;
    hidden: yes
  }

  measure: count {
    type: count
    label: "Número de lineas"
  }
}
