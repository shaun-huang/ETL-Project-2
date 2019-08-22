ALTER TABLE "Victim"
-- 	ADD COLUMN crash_id SERIAL
-- 	REFERENCES "Crash" (id),
-- 	ADD COLUMN race_id VARCHAR
-- 	REFERENCES "Ethnicity" (race_init);
	ADD COLUMN gender_id INT
	REFERENCES "Gender" (id),
	ADD COLUMN area_id INT
	REFERENCES "Area" (id);
	
	

SELECT * FROM "Victim";