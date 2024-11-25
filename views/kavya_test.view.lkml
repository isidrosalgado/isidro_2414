view: kavya_test {
  dimension: first_name {
      type: string
      sql: ${TABLE}.first_name ;;
    }

    dimension: last_name {
      type: string
      sql: ${TABLE}.last_name ;;
    }
  dimension: full_name {
    type: string
    sql: CONCAT(${TABLE}.first_name, ' ', ${TABLE}.last_name) ;;
  }
  }
