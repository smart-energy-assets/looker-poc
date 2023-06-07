# The name of this view in Looker is "Looker Measurement Unit"
view: looker_measurement_unit {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `sea-produccion.target_reporting.looker_measurement_unit`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Active Chroma" in Explore.

  dimension: active_chroma {
    type: string
    sql: ${TABLE}.active_chroma ;;
  }

  dimension: active_stream_id {
    type: string
    sql: ${TABLE}.activeStreamId ;;
  }

  dimension: backup_id {
    type: string
    sql: ${TABLE}.backupId ;;
  }

  dimension: bidireccional_id {
    type: string
    sql: ${TABLE}.bidireccionalId ;;
  }

  dimension: boiler {
    type: yesno
    sql: ${TABLE}.boiler ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  dimension: default_chroma {
    type: yesno
    sql: ${TABLE}.default_chroma ;;
  }

  dimension_group: deleted {
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
    sql: ${TABLE}.deleted ;;
  }

  dimension: gas_quality_backup_id {
    type: string
    sql: ${TABLE}.gasQualityBackupId ;;
  }

  dimension: gas_quality_id {
    type: string
    sql: ${TABLE}.gasQualityId ;;
  }

  dimension: group_id {
    type: string
    sql: ${TABLE}.groupId ;;
  }

  dimension: in_branch_id {
    type: string
    sql: ${TABLE}.inBranchId ;;
  }

  dimension: is_reserve {
    type: yesno
    sql: ${TABLE}.is_reserve ;;
  }

  dimension: is_self_consumised {
    type: yesno
    sql: ${TABLE}.is_selfConsumised ;;
  }

  dimension: linear_schema {
    type: string
    sql: ${TABLE}.linearSchema ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    drill_fields: [looker_lines.name,looker_measurement_unit.name]
  }

  dimension: old_id {
    type: string
    sql: ${TABLE}.old_id ;;
  }

  dimension: out_branch_id {
    type: string
    sql: ${TABLE}.outBranchId ;;
  }

  dimension: physical_chroma {
    type: string
    sql: ${TABLE}.physical_chroma ;;
  }

  dimension: position_id {
    type: string
    sql: ${TABLE}.positionId ;;
  }

  dimension: reads_from {
    type: string
    sql: ${TABLE}.reads_from ;;
  }

  dimension: self_consumised_id {
    type: string
    sql: ${TABLE}.selfConsumisedId ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
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
    drill_fields: [id, name]
  }
}
