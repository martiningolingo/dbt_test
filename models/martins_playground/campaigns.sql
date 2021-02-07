{# {{ config(materialized='table') }} #}

WITH campaigns_source AS(
    SELECT brands.id brand_id,
           brands.name AS brand_name,
           bc.id AS campaign_id,
           bc.name campaign_name,
           bc.flight_start::date AS start_dt
      FROM {{ source('sndw', 'brands') }} AS brands
      INNER JOIN {{ source('sndw', 'brands_campaign') }} AS bc
        ON brands.id = bc.brand_id
),

final AS(
    SELECT *
      FROM campaigns_source
)

    SELECT *
      FROM final
