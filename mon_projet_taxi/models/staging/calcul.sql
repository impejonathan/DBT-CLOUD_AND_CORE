{{ config(materialized='view') }}

SELECT
    -- Nouvelles colonnes d'enrichissement d'abord
    DATEDIFF('minute', PICKUP_DATETIME, DROPOFF_DATETIME) AS duree_trajet_minutes,

    CASE 
        WHEN DATEDIFF('minute', PICKUP_DATETIME, DROPOFF_DATETIME) > 0
            THEN TRIP_DISTANCE / (DATEDIFF('minute', PICKUP_DATETIME, DROPOFF_DATETIME) / 60.0)
        ELSE NULL
    END AS vitesse_moyenne_mph,

    -- Catégorisation de la distance du trajet
    CASE
        WHEN TRIP_DISTANCE <= 1 THEN 'Court trajet'
        WHEN TRIP_DISTANCE > 1 AND TRIP_DISTANCE <= 5 THEN 'Trajet moyen'
        WHEN TRIP_DISTANCE > 5 AND TRIP_DISTANCE <= 10 THEN 'Long trajet'
        WHEN TRIP_DISTANCE > 10 THEN 'Très long trajet'
        ELSE 'Inconnu'
    END AS categorie_trajet,

    CASE 
        WHEN FARE_AMOUNT > 0
            THEN (TIP_AMOUNT / FARE_AMOUNT) * 100
        ELSE NULL
    END AS pourcentage_pourboire,

    -- Toutes les autres colonnes
    *
FROM {{ ref('clean_raw') }}
WHERE PICKUP_ANNEE IN (2024, 2025)