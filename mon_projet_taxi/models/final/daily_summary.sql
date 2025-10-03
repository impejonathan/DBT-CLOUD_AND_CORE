{{ config(materialized='table') }}

SELECT
    -- On isole la date du pickup pour le regroupement par jour
    DATE(PICKUP_DATETIME) AS pickup_date,

    -- Nombre de trajets dans la journée
    COUNT(*) AS nb_trajets,

    -- Distance moyenne par trajet ce jour-là
    AVG(TRIP_DISTANCE) AS distance_moyenne,

    -- Revenus totaux (total_amount = tout ce qui rapporte pour le chauffeur)
    SUM(TOTAL_AMOUNT) AS revenus_totaux

FROM {{ ref('calcul') }}

GROUP BY 
    DATE(PICKUP_DATETIME)
ORDER BY
    pickup_date