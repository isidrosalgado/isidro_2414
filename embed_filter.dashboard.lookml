- dashboard: embed_dashboard
  title: Embed_dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: dkmXOv34HvrUbwLMY8LO5o

  elements:
  - title: Embed_dashboard
    name: Embed_dashboard
    model: isidro_2414
    explore: order_items
    type: looker_scatter
    fields: [inventory_items.cost, orders.status, orders.created_date]
    sorts: [inventory_items.cost]
    limit: 500
    column_limit: 50
    query_timezone: Mexico/General
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    x_axis_zoom: true
    y_axis_zoom: true
    cluster_points: false
    quadrants_enabled: false
    quadrant_properties:
      '0':
        color: ''
        label: Quadrant 1
      '1':
        color: ''
        label: Quadrant 2
      '2':
        color: ''
        label: Quadrant 3
      '3':
        color: ''
        label: Quadrant 4
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: ''
    custom_y_column: ''
    custom_value_label_column: ''
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Status: orders.status
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: Status
    title: Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: isidro_2414
    explore: order_items
    listens_to_filters: []
    field: orders.status
