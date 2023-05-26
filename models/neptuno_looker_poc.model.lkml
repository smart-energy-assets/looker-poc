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

explore: calidad_biometano_b211 {}

explore: delta_factor_compresibilidad_um {}

explore: infraestructuras {}

explore: estudio_mermas {}

explore: mapa_dispatching {}

explore: piloto_electrovalvulas {}

explore: um_deltas_volumen_caudal_horario {}

explore: um_deltas_volumen_horario {}
