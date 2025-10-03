SELECT
    COUNT(*) AS total_lignes,
    COUNT_IF(VENDORID IS NULL) AS nb_vendorid_null,
    COUNT_IF(PASSENGER_COUNT IS NULL) AS nb_passenger_null,
    COUNT_IF(TRIP_DISTANCE IS NULL) AS nb_trip_distance_null,
    COUNT_IF(FARE_AMOUNT IS NULL) AS nb_fare_null,
    COUNT_IF(TOTAL_AMOUNT IS NULL) AS nb_total_null,
    COUNT_IF(FARE_AMOUNT < 0) AS nb_fare_negatif,
    COUNT_IF(TOTAL_AMOUNT < 0) AS nb_total_negatif,
    COUNT_IF(TRIP_DISTANCE = 0) AS nb_trajet_distance_zero,
    COUNT_IF(TRIP_DISTANCE > 1000) AS nb_distance_aberrante
FROM {{ source('raw', 'yellow_taxi_trips_1') }}
