Coordinates 
-
location_id INTEGER PK
location VARCHAR

Ethnicity
-
ethnicity_id INTEGER PK
initial VARCHAR
ethnicity VARCHAR
ethnicity_bucket VARCHAR FK >- LAPopulation.ethnicity_bucket

Gender
-
gender_id INTEGER PK
gender VARCHAR

District
-
district_id INTEGER PK
district VARCHAR

Area
-
area_id INTEGER PK
area VARCHAR

Crash
-
crash_id INTEGER FK >- Victim.crash_id
crash_date_time TIMESTAMP
age INTEGER

VICTIM
-
crash_id INTEGER PK
area_id INTEGER FK >- Area.area_id
district_id INTEGER FK >- District.district_id
gender_id  INTEGER FK >- Gender.gender_id 
ethnicity_id INTEGER FK >- Ethnicity.ethnicity_id
location_id INTEGER FK >- Coordinates.location_id

LAPopulation
-
ethnicity_bucket VARCHAR PK
population_percentage DECIMAL