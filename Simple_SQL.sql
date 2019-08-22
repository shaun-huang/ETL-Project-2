select *
from "Crash";

select *
from "Area";

select *
from "Ethnicity";

select *
from "Gender";

select *
from "Race";

select *
from "Victim";

SELECT crash_date_time, crash_location, age
FROM "Crash" c
LEFT JOIN "Victim" v
ON c.id = v.crash_id
LIMIT 50;

