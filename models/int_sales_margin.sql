SELECT
      products_id,
      date_date,
      orders_id,
      revenue,
      quantity,
      purchase_price,
      ROUND(s.quantity*p.purchase_price,2) AS purchase_cost,
      ROUND(s.revenue - s.quantity*p.purchase_price, 2) AS margin
  FROM {{ref("stg_raw__sales")}} s
  LEFT JOIN {{ref("stg_raw__product")}} p
      USING (products_id);

SELECT
     orders_id,
     date_date,
     ROUND(SUM(revenue),2) as revenue,
     ROUND(SUM(quantity),2) as quantity,
     ROUND(SUM(purchase_cost),2) as purchase_cost,
     ROUND(SUM(margin),2) as margin
 FROM {{ ref("int_sales_margin") }}
 GROUP BY orders_id,date_date
 ORDER BY orders_id DESC;

  SELECT
     o.orders_id
     ,o.date_date
     ,ROUND(o.margin + s.shipping_fee - (s.logcost + s.ship_cost),2) AS operational_margin
     ,o.quantity
     ,o.revenue
     ,o.purchase_cost
     ,o.margin
     ,s.shipping_fee
     ,s.logcost
     ,s.ship_cost
 FROM {{ref("int_orders_margin")}} o
 LEFT JOIN {{ref("stg_raw__ship")}} s
     USING(orders_id)
 ORDER BY orders_id desc


