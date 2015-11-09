- view: inventory_items
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: cost
    type: number
    sql: ${TABLE}.cost

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: product_id
    type: int
    # hidden: true
    sql: ${TABLE}.product_id

  - dimension_group: sold
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sold_at

  - measure: count
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
    
  #derived
  
  - dimension: days_in_inventory
    type: number
    sql: DATEDIFF(${sold_date}, ${created_date})
    
    
  - dimension: days_in_inventory_tier
    type: tier
    style: integer
    tiers: [0,5,10,20,40,80,160,360]
    sql: ${days_in_inventory}
    
  - dimension: days_since_arrival
    type: number
    sql: DATEDIFF(NOW(), ${created_date})

  - dimension: days_since_arrival_tier
    type: tier
    style: integer
    tiers: [0,5,10,20,40,80,160,360]
    sql: ${days_since_arrival}
 
  - measure: average_cost
    type: average
    sql: ${cost}
    value_format: '$0.00' 
  
  - measure: sold_count
    type: count
    drill_fields: detail*
    filters:
      sold_date: -NULL
      
  - measure: number_on_hand
    type: number
    sql: ${count} - ${sold_count}
    