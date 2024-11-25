view: order_items {
  sql_table_name: thelook.order_items ;;
  drill_fields: [id]

  parameter: order_items_date {
    type: unquoted
    allowed_value: {
      label: "Date"
      value: "date"
    }
    allowed_value: {
      label: "Week"
      value: "week"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    default_value: "date"
  }

  dimension: order_creation_date {
    type: date
    sql:
    CASE
      WHEN {% parameter ${order_items_date} %} = 'week' THEN
        ${created_week}
      WHEN {% parameter ${order_items_date} %} = 'month' THEN
        ${created_month}
      ELSE
        ${created_date}
    END ;;
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    label: "Order Date"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    label: "Total amount"
    sql: ${TABLE}.sale_price ;;
  }

  dimension: sale_price_formatted {
    type: number
    sql: ${sale_price} ;;
    value_format_name: "usd"  # This automatically formats the number as currency.
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
