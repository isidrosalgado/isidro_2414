include: "kavya_test.view"
view: orders {
  extends: [kavya_test]
sql_table_name: thelook.orders ;;
  drill_fields: [id]

  parameter: order_display_option {
    type: string
    allowed_value: {
      label: "User ID + Last Name"
      value: "id_last_name"
    }
    allowed_value: {
      label: "Status"
      value: "status"
    }
    allowed_value: {
      label: "Sale Price"
      value: "sale_price"
    }
    default_value: "id_lastname"
  }

  dimension: id_lastname {
    type: string
    sql: CONCAT(${user_id}, ' ', ${users.last_name}) ;;
    hidden: yes
  }

  dimension: status_colored {
    type: string
    sql: ${status} ;;
    hidden: yes
    html:
    {% if value == 'complete' %}
    <p style="color: black; background-color: light green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'pending' %}
    <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %} ;;
  }

  dimension: sale_price_formatted {
    type: number
    sql: ${order_items.sale_price} ;;
    value_format: "$#.00 "
    hidden: yes
  }


  dimension: order_display {
    type: string
    sql:
    CASE
      WHEN {% parameter order_display_option %} = 'User ID + Last Name' THEN ${id_lastname}
      WHEN {% parameter order_display_option %} = 'Status' THEN ${status_colored}
      WHEN {% parameter order_display_option %} = 'Sale_Price' THEN ${sale_price_formatted}
      ELSE ${id_lastname}
    END ;;
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    label: "Date"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
    #html: {{ rendered_value | date: "%b %d, %y" }};;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    html: {% if value == 'complete' %}
    <p style="color: black; background-color: light green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'pending' %}
    <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
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
