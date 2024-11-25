include: "kavya_test.view"
view: users {

  extends: [kavya_test]
    sql_table_name: thelook.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    link: {
      label: "Explore Top 20 Results"
      url: "{{ link }}&limit=20"
    }
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension: country_test {
    type: string
    sql:
    {% assign country = ${TABLE}.country %}

    {% case country %}
    {% when 'US' %}
    '<img src="https://example.com/flags/usa.png" alt="USA Flag" width="50" height="30">'
    {% when 'UK' %}
    '<img src="https://example.com/flags/uk.png" alt="UK Flag" width="50" height="30">'
    {% else %}
    'No Image Added'
    {% endcase %}
    ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }
  dimension: lng {
    type: number
    sql: ${TABLE}.lng ;;
  }
  dimension: postcode {
    type: string
    sql: ${TABLE}.postcode ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }
    dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }
  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, orders.count]
  }
}
