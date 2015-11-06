- connection: thelook

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

# - explore: events


- explore: inventory_items
  joins:
    - join: products
      type: left_outer
      sql_on: ${inventory_items.product_id} = ${products.id}
      relationship: many_to_one
      
- explore: order_items
  joins:
    - join: inventory_items
      type: left_outer
      sql_on: ${order_items.inventory_item_id} = ${inventory_items.id}
      relationship: many_to_one

    - join: orders
      type: left_outer
      sql_on: ${order_items.order_id} = ${orders.id}
      relationship: many_to_one
    
    - join: users
      type: left_outer
      sql_on: ${orders.user_id} = ${users.id}
      relationship: many_to_one
      
    - join: user_data
      type: left_outer
      sql_on: ${users.id} = ${user_data.user_id}
      relationship: one_to_many
      
- explore: orders
  joins:
    - join: users
      type: left_outer
      sql_on: ${orders.user_id} = ${users.id}
      relationship: many_to_one
      
- explore: products
  joins:
    - join: inventory_items
      type: left_outer
      sql_on: ${products.id} = ${inventory_items.product_id}
      relationship: one_to_many
      
# - explore: schema_migrations

- explore: user_data
  joins:
    - join: users
      type: left_outer
      sql_on: ${user_data.user_id} = ${users.id}
      relationship: many_to_one
      
- explore: users
  joins:
    - join: user_data
      type: left_outer
      sql_on: ${users.id} = ${user_data.user_id}
      relationship: one_to_many

    - join: orders
      type: left_outer
      sql_on: ${users.id} = ${orders.user_id}
      relationship: one_to_many
      
- explore: users_nn

