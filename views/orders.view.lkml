view: orders {
  sql_table_name: thelook.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }
  measure: data {
    type: number
    sql: EXTRACT(year from ${TABLE}.created_at);;
    }

  measure: data_1 {
    type: number
    sql: EXTRACT(month from ${TABLE}.created_at);;
  }
  measure: data_3 {
    type: number
    sql: EXTRACT(year from current_date- interval 4 day);;
  }

  measure: data_4 {
    type: number
    sql: EXTRACT(month from current_date- interval 4 day);;
  }

  measure: full_data {
    type: number
    sql:concat('year from ${TABLE}.created_at): ', cast( EXTRACT(year from ${TABLE}.created_at) as char), 'month from ${TABLE}.created_at): ' , cast (EXTRACT(month from ${TABLE}.created_at) as char};;
}
}
