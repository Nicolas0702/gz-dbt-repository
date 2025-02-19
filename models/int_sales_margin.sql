WITH sales_data AS (
    SELECT
        s.orders_id,
        s.pdt_id,
        s.quantity,
        s.revenue,
        -- Ici, tu devras faire la jointure avec un modèle qui contient `purchase_price`
        p.purchase_price
    FROM {{ ref('stg_raw__sales') }} s
    -- Remplace 'stg_raw__product' par le modèle correct si nécessaire
    JOIN {{ ref('stg_raw__product') }} p
        ON s.pdt_id = p.pdt_id
),

calculated_margin AS (
    SELECT
        orders_id,
        pdt_id,
        quantity,
        revenue,
        purchase_price,
        (quantity * purchase_price) AS purchase_cost,
        (revenue - (quantity * purchase_price)) AS margin
    FROM sales_data
)

SELECT * FROM calculated_margin;

