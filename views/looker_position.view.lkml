# The name of this view in Looker is "Looker Position"
view: looker_position {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `sea-produccion.target_reporting.looker_position`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    label: "Id de Posición"
    hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    drill_fields: [looker_measurement_unit.name,looker_lines.name]
    label: "Nombre de Posición"
  }

  dimension: location {
    type: location
    sql_latitude:JSON_EXTRACT_SCALAR(geo_position, '$.latitude')   ;;
    sql_longitude:JSON_EXTRACT_SCALAR(geo_position, '$.longitude') ;;
    label: "Localización"
    #sql_longitude:JSON_EXTRACT_SCALAR(${TABLE}.geo_position.longitude) ;;
    #sql_latitude:JSON_EXTRACT_SCALAR(${TABLE}.geo_position.latitude);;
    drill_fields:[looker_measurement_unit.name,looker_lines.name]
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

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Description" in Explore.

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    label: "Descripción"
  }

  dimension: geo_position {
    type: string
    sql: ${TABLE}.geo_position ;;
    hidden: yes
  }


  dimension: measure_bool {
    type: yesno
    sql: ${TABLE}.measure_bool ;;
    hidden: yes
  }


  dimension: old_id {
    type: string
    sql: ${TABLE}.old_id ;;
    hidden: yes

  }

  dimension: owner_id {
    type: string
    sql: ${TABLE}.ownerId ;;
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
    label: "Numero de Posiciones"
  }
}
