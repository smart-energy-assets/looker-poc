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
    label: "Id de Unidad de Medida"
    hidden: yes
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Active Chroma" in Explore.


  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    drill_fields: [looker_lines.name]
    label: "Nombre de Unidad de Medida"
  }

  dimension: in_branch_name {
    # Realiza el JOIN con la tabla looker_branch para obtener el nombre de la sucursal de entrada
    type: string
    sql: CASE WHEN ${in_branch_id} IS NOT NULL THEN
           (SELECT code FROM looker_branch WHERE id = ${in_branch_id})
         END ;;
  label: "Nombre Ramal de Entrada"
  drill_fields: [name,looker_lines.name]
  }

  dimension: out_branch_name {
    # Realiza el JOIN con la tabla looker_branch para obtener el nombre de la sucursal de entrada
    type: string
    sql: CASE WHEN ${out_branch_id} IS NOT NULL THEN
           (SELECT code FROM looker_branch WHERE id = ${out_branch_id})
         END ;;
    label: "Nombre Ramal de Salida"
    drill_fields: [name,looker_lines.name]
  }

  dimension: active_chroma {
    type: string
    sql: ${TABLE}.active_chroma ;;
    hidden: yes
  }

  dimension: active_stream_id {
    type: string
    sql: ${TABLE}.activeStreamId ;;
    hidden: yes
  }

  dimension: backup_id {
    type: string
    sql: ${TABLE}.backupId ;;
    hidden: yes
  }

  dimension: bidireccional_id {
    type: string
    sql: ${TABLE}.bidireccionalId ;;
    hidden: yes
  }

  dimension: boiler {
    type: yesno
    sql: ${TABLE}.boiler ;;
    hidden: yes
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: default_chroma {
    type: yesno
    sql: ${TABLE}.default_chroma ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: gas_quality_backup_id {
    type: string
    sql: ${TABLE}.gasQualityBackupId ;;
    hidden: yes
  }

  dimension: gas_quality_id {
    type: string
    sql: ${TABLE}.gasQualityId ;;
    hidden: yes
  }

  dimension: group_id {
    type: string
    sql: ${TABLE}.groupId ;;
    hidden: yes
  }

  dimension: in_branch_id {
    type: string
    sql: ${TABLE}.inBranchId ;;
    label: "Id Ramal de Entrada"
  }

  dimension: is_reserve {
    type: yesno
    sql: ${TABLE}.is_reserve ;;
    hidden: yes
  }

  dimension: is_self_consumised {
    type: yesno
    sql: ${TABLE}.is_selfConsumised ;;
    hidden: yes
  }

  dimension: linear_schema {
    type: string
    sql: ${TABLE}.linearSchema ;;
    hidden: yes
  }


  dimension: old_id {
    type: string
    sql: ${TABLE}.old_id ;;
    hidden: yes
  }

  dimension: out_branch_id {
    type: string
    sql: ${TABLE}.outBranchId ;;
    label: "Id Ramal de Salida"
  }

  dimension: physical_chroma {
    type: string
    sql: ${TABLE}.physical_chroma ;;
    hidden: yes
  }

  dimension: position_id {
    type: string
    sql: ${TABLE}.positionId ;;
    hidden: yes
  }

  dimension: reads_from {
    type: string
    sql: ${TABLE}.reads_from ;;
    hidden: yes
  }

  dimension: self_consumised_id {
    type: string
    sql: ${TABLE}.selfConsumisedId ;;
    hidden: yes
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
    label: "Procedencia de Datos"
    hidden: yes
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
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
    drill_fields: [id, name]
    label: "Numero de Unidades de Medida"
  }
}
