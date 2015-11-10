- view: order_items
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: inventory_item_id
    type: int
    # hidden: true
    sql: ${TABLE}.inventory_item_id

  - dimension: order_id
    type: int
    # hidden: true
    sql: ${TABLE}.order_id

  - dimension_group: returned
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.returned_at

  - dimension: sale_price
    type: number
    sql: ${TABLE}.sale_price

  - measure: count
    type: count
    drill_fields: [id, inventory_items.id, orders.id]

  - filter: item_name
    suggest_dimension: products.item_name
    
  - filter: brand
    suggest_dimension: products.brand  

  #derived measures and dimensions
 
  - dimension: gross_margin
    type: number
    sql: ${sale_price} - ${inventory_items.cost}
    value_format: '$#,##0.00'
    
  - measure: average_sale_price
    type: average
    sql: ${sale_price}
    value_format: '$#,##0.00'
    
  - measure: total_sale_price
    type: sum
    sql: ${sale_price}
    value_format: '$#,##0.00'
    
  - measure: average_gross_margin
    type: average
    sql: ${gross_margin}
    value_format: '$#,##0.00'
    
  - measure: total_gross_margin
    type: sum
    sql: ${gross_margin}
    value_format: '$#,##0.00'
    
  - measure: total_gross_margin_percentage
    type: number
    sql: 100.0 * ${total_gross_margin}/NULLIF(${total_sale_price},0)
    value_format: '0.00\%'
    
  - dimension: item_gross_margin_percentage
    type: number
    sql: 100.0 * (${sale_price} - ${inventory_items.cost})/NULLIF(${sale_price},0)
    value_format: '0.00\%'
  
  - dimension: item_gross_margin_percentage_tiers
    type: tier
    sql: ${item_gross_margin_percentage}
    tiers: [0,10,20,30,40,50,60,70,80]