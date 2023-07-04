view: balances_energy_open_closed {
  derived_table: {
    sql:
SELECT
  IF(
    EXTRACT(HOUR FROM CURRENT_TIMESTAMP) >= 6 AND EXTRACT(HOUR FROM CURRENT_TIMESTAMP) < 12,
    'ABIERTO',
    IF(
      EXTRACT(HOUR FROM CURRENT_TIMESTAMP) = 12 AND EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) < 30,
      'ABIERTO',
      'CERRADO'
    )
  ) AS status;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
}
