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
      

- explore: orders

- explore: products

- explore: schema_migrations

- explore: user_data

- explore: users

- explore: users_nn

