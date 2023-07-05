view: datos {
  derived_table: {
    explore_source: delta_factor_compresibilidad_linea_check {
      column: fecha_lectura_month {}
      column: diferencia_de_energia_GWh {}
      filters: {
        field: delta_factor_compresibilidad_linea_check.um
        value: "-B35X,-41.10.01E,-F14A.EC,-F14D.EC,-K01-M.MA,-CC.BE.GN,-CC.SR.GN-P,-B72"
      }
    }
  }
}
