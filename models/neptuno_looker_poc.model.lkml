# Define the database connection to be used for this model.
connection: "neptuno"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: neptuno_looker_poc_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: neptuno_looker_poc_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Neptuno Looker Poc"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: delta_factor_compresibilidad_linea_check {}

explore: delta_factor_compresibilidad_linea_recalculo {}

explore: calendario_dia_gas {}

explore: calendario {}

explore: calidad_biometano_1503_a {}

explore: delta_factor_compresibilidad_linea {}

explore: calidad_biometano_b211 {
  join: infraestructuras {
    sql_on: ${calidad_biometano_b211.um} = ${infraestructuras.um} ;;
    relationship: one_to_many
    type: inner # Could be excluded since left_outer is the default
  }
}

explore: delta_factor_compresibilidad_um {}

explore: infraestructuras {}

explore: estudio_mermas {
  join: infraestructuras {
    sql_on: ${estudio_mermas.um_linea} = ${infraestructuras.um_linea} ;;
    relationship: one_to_many
    type: left_outer
  }
}


explore: mapa_dispatching {}

explore: piloto_electrovalvulas {}

explore: um_deltas_volumen_caudal_horario {}

explore: um_deltas_volumen_horario {}


explore: looker_deltas_historical_daily {
  join: looker_lines{
    sql_on: ${looker_deltas_historical_daily.l_name}=${looker_lines.id};;
    relationship: many_to_one
    type: left_outer
  }
  join: looker_measurement_unit{
    sql_on: ${looker_deltas_historical_daily.mu_name}=${looker_measurement_unit.id};;
    relationship: many_to_one
    type: inner
  }
}

# BQML ARIMA_PLUS
explore: arima_prediction_union {}
