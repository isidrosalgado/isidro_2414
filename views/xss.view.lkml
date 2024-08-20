view: xss {
  sql_table_name: thelook.xss ;;

  dimension: attack_strings {
    type: string
    sql: ${TABLE}.attack_strings ;;
  }
  measure: count {
    type: count
  }
}
