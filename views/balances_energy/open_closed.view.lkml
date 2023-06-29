view: balances_energy_open_closed {
  derived_table: {
    sql:
SELECT CASE
    WHEN EXTRACT(HOUR FROM CURRENT_TIMESTAMP) >= 6 AND
         EXTRACT(HOUR FROM CURRENT_TIMESTAMP) < 12 AND
         EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) < 30
    THEN 'ABIERTO'
    ELSE 'CERRADO'
END AS status;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
}
