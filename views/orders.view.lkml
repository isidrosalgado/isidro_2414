include: "kavya_test.view"
view: orders {
  extends: [kavya_test]
sql_table_name: thelook.orders ;;
  drill_fields: [id]

  parameter: order_display_option {
    type: unquoted
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

  # parameter: status {
  #   type: unquoted
  #   allowed_value: {
  #     label: "Completed"
  #     value: "complete"
  #   }
  #   allowed_value: {
  #     label: "Pending"
  #     value: "pending"
  #   }
  #   allowed_value: {
  #     label: "Cancelled"
  #     value: "cancelled"
  #   }
  # }

  dimension: id_lastname {
    type: string
    sql: CONCAT(${user_id}, ' ', ${users.last_name}) ;;
    #hidden: yes
  }

  dimension: status_colored {
    type: string
    sql: ${status} ;;
    #hidden: yes
    html:
    {% if value == 'complete' %}
   <font color="darkgreen">{{ rendered_value }}</font>
    {% elsif value == 'pending' %}
    <font color="orange">{{ rendered_value }}</font>
    {% else %}
    <font color="red">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: sale_price_formatted {
    type: number
    sql: concat('$' , ${order_items.sale_price});;
    #hidden: yes
  }


  dimension: order_display {
    label_from_parameter: order_display_option
    sql:
    {% if order_display_option._parameter_value == 'id_last_name' %}
        ${id_lastname}
    {% elsif order_display_option._parameter_value == 'status' %}
        ${status}
    {% elsif order_display_option._parameter_value == 'sale_price' %}
      ${sale_price_formatted}
    {% else %}
      ${id_lastname}
    {% endif %} ;;
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
