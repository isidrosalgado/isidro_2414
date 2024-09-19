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
  dimension: data {
    type: number
    sql: EXTRACT(year from ${TABLE}.created_at);;
    }

#   dimension: data_1 {
#     type: number
#     sql: EXTRACT(month from ${TABLE}.created_at);;
#   }
  dimension: data_3 {
    type: string
    sql: EXTRACT(year from now()- interval 4 day);;
  }

  dimension: data_4 {
    type: number
    sql: EXTRACT(month from now()- interval 4 day);;
  }

  dimension: final {
    type: string
    sql: Case when ${created_date} = date(EXTRACT(year from now()- interval 4 day,EXTRACT(month from now()- interval 4 day),1) then 'yes' else 'no' end;;
  }

#   measure: full_data {
#     type: number
#     sql:concat('year from ${TABLE}.created_at): ', cast( EXTRACT(year from ${TABLE}.created_at) as char), 'month from ${TABLE}.created_at): ' , cast (EXTRACT(month from ${TABLE}.created_at) as char};;
# }

# dimension: forecast_date {
#   type: date
#   sql:  ADDDATE(DAY, -4, CURRENT_DATE());;
# }

#   dimension: forecast_year {
#     type: number
#     sql:  EXTRACT(YEAR FROM ADDDATE(DAY, -4, CURRENT_DATE()));;
#   }

#   dimension: forecast_month {
#     type: number
#     sql: EXTRACT(MONTH FROM ADDDATE(DAY, -4, CURRENT_DATE()));;
#   }

#   measure: Budget {
#   type: number
#   sql: CASE WHEN${forecast_month} =EXTRACT(MONTH FROM CURRENT_DATE()) THEN ${count} ELSE 0 END ;;
#   }
}
