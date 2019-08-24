--Joining all tables 

SELECT C.*, A.*, CO.*, D.*, G.*, E.ethnicity, L.*
FROM "Crash" C
JOIN "Victim" V
ON C.crash_id = V.crash_id
JOIN "Area" A
ON  V.area_id = A.area_id
JOIN "Coordinates" CO
ON  V.location_id = CO.location_id
JOIN "District" D
ON  V.district_id = D.district_id
JOIN "Gender" G
ON  V.gender_id = G.gender_id
JOIN "Ethnicity" E
ON  V.ethnicity_id = E.ethnicity_id
JOIN "LAPopulation" L
ON E.ethnicity_bucket = L.ethnicity_bucket
LIMIT 100


