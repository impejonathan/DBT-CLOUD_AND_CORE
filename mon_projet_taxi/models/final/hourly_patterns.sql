{{ config(materialized='table') }}

SELECT
    -- Date et heure de départ du trajet (granularité heure)
    DATE(PICKUP_DATETIME) AS pickup_date,
    PICKUP_HEURE,

    -- Demande : nombre de trajets par heure
    COUNT(*) AS demande,

    -- Revenus totaux générés sur ce créneau horaire
    SUM(TOTAL_AMOUNT) AS revenus,

    -- Vitesse moyenne par heure (miles/h)
    AVG(vitesse_moyenne_mph) AS vitesse_moyenne

FROM {{ ref('calcul') }}

GROUP BY
    DATE(PICKUP_DATETIME),
    PICKUP_HEURE

ORDER BY
    pickup_date,
    PICKUP_HEURE