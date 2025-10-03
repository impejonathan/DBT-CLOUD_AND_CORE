{{ config(materialized='table') }}

SELECT
    -- La zone de départ
    PULOCATIONID AS zone_depart,

    -- Nombre de trajets (volume) pour chaque zone
    COUNT(*) AS volume_trajets,

    -- Revenu moyen par course pour chaque zone
    AVG(TOTAL_AMOUNT) AS revenu_moyen,

    -- Popularité : proportion du volume de la zone par rapport à l'ensemble (en %)
    (COUNT(*)*100.0) / SUM(COUNT(*)) OVER () AS popularite_pourcent

FROM {{ ref('calcul') }}

GROUP BY
    PULOCATIONID

ORDER BY
    volume_trajets DESC