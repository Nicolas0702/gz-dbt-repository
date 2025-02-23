dbt run --full-refresh
version: 2

sources:
  - name: raw
    schema: gz_raw_data
    tables:
      - name: sales
        identifier: raw_gz_sales
        description: sales of Greenweez / we have on row per product_id found in each orders_id
        tests:
          - unique:
              column_name: "(orders_id||pdt_id)"

      - name: product
        identifier: raw_gz_product
        description: products of Greenweez / we have on row per product_id with purchase_price
        columns:
        - name: products_id
          tests:
            - unique 
            - not_null       
      - name: ship
        identifier: raw_gz_ship
        description: ship of Greenweez / we have on row per order_id with shipping_fees, log_cost and ship_cost
        columns:
        - name: orders_id
          tests:
            - unique
            - not_null
