- view: users_nn
  sql_table_name: usersNN
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: first_name
    sql: ${TABLE}.first_name

  - dimension: last_name
    sql: ${TABLE}.last_name

  - measure: count
    type: count
    drill_fields: [id, first_name, last_name]

