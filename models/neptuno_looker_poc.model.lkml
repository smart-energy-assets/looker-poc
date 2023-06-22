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


# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Neptuno Looker Poc"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

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

explore: um_deltas_volumen_caudal_horario {
  join: infraestructuras{
    sql_on: ${um_deltas_volumen_caudal_horario.um}=${infraestructuras.um};;
    relationship: many_to_one
    type: inner
  }
}

explore: um_deltas_volumen_horario {}


explore: looker_deltas_historical_daily {
  description: "Consumos Diarios de Volumen y Energia por Linea"

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
  join: looker_position {
    sql_on: ${looker_measurement_unit.position_id}=${looker_position.id} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: looker_branch {
    sql_on: ${looker_measurement_unit.in_branch_id}=${looker_branch.id} OR ${looker_measurement_unit.out_branch_id}=${looker_branch.id} ;;
    relationship: many_to_many
    type: left_outer
  }

}

explore: delta_factor_compresibilidad_linea_check {
  hidden: yes
}


explore: salidas_balance {
  hidden: yes
}

#explore: balances {
# a623834d86ab3a2f3565adc52a11b1796e017c0d
#}
explore: entradas_balance {
   join: salidas_balance {
    sql_on: ${entradas_balance.primary_key}=${salidas_balance.primary_key} ;;
#    sql_on:CONCAT(${entradas_balance.in_branch_id},${entradas_balance.ts_date}) = CONCAT(${salidas_balance.out_branch_id},${entradas_balance.ts_date}) ;;
     relationship: one_to_one
    type: inner
  }
  join: looker_branch {
    sql_on: ${entradas_balance.in_branch_id}=${looker_branch.id} ;;
    relationship: one_to_one
    type: left_outer
  }
}

# BQML ARIMA_PLUS
explore: arima_prediction_union {}

# Proyecto DLC: Automatización de balances
explore: balances_section_energy_daily {

}
