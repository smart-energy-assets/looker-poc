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
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Certificate Code" in Explore.

  dimension: certificate_code {
    type: string
    sql: ${TABLE}.certificate_code ;;
  }

  dimension: counter_diameter {
    type: string
    sql: ${TABLE}.counter_diameter ;;
  }

  dimension: counter_values {
    type: string
    sql: ${TABLE}.counter_values ;;
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
  }

  dimension: diameter {
    type: string
    sql: ${TABLE}.diameter ;;
  }

  dimension: flow_computers_id {
    type: string
    sql: ${TABLE}.flowComputersId ;;
  }

  dimension: hardware {
    type: string
    sql: ${TABLE}.hardware ;;
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
  }

  dimension: m_model_id {
    type: string
    sql: ${TABLE}.mModelId ;;
  }

  dimension: m_number {
    type: string
    sql: ${TABLE}.m_number ;;
  }

  dimension: m_type {
    type: string
    sql: ${TABLE}.m_type ;;
  }

  dimension: measurement_unit_id {
    type: string
    sql: ${TABLE}.measurementUnitId ;;
  }

  dimension: modify_counter_values {
    type: yesno
    sql: ${TABLE}.modify_counter_values ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  #  drill_fields:[looker_measurement_unit.name,looker_lines.name]
  }

  dimension: old_id {
    type: string
    sql: ${TABLE}.old_id ;;
  }

  dimension: order {
    type: string
    sql: ${TABLE}.`order` ;;
  }

  dimension: preassure_max {
    type: string
    sql: ${TABLE}.preassure_max ;;
  }

  dimension: size {
    type: string
    sql: ${TABLE}.size ;;
  }

  dimension: size_counter {
    type: string
    sql: ${TABLE}.size_counter ;;
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
  }

  measure: count {
    type: count
  }
}
