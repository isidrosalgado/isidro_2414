view: products {
  sql_table_name: thelook.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: brand {
    type: string
    link: {
      label: "Liquid test"
      url: "http://www.google.com/search?q={{ value }}"
    }
    sql: ${TABLE}.brand ;;
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }
  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }
  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }
  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }
  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }
  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
  measure: total_liquid_issue{
    type: number
    sql: ${retail_price};;
    html: {% if value < 3 and count._value < 2 and rank._value== 772%}
<p style="color: black; background-color: lightgreen; font-size: 100%; text-align:center">{{ rendered_value }}</p> {% else %}
<p style="color: black; background-color: lightblue; font-size: 100%; text-align:center">{{ rendered_value }}</p> {% endif %} ;;
  }
}
