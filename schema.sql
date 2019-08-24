DROP TABLE "CrashRaw";
DROP TABLE areas;
DROP TABLE race;
DROP TABLE gender;
DROP TABLE crash;
DROP TABLE victim;


-- First Create Raw Data Table "CrashRaw" and race. Data are inserted using SQLAlchemy.
CREATE TABLE "CrashRaw" (
    "id" SERIAL NOT NULL,
    "datetime" TIMESTAMP   NOT NULL,
    "area" VARCHAR   NOT NULL,
    "district" VARCHAR   NOT NULL,
    "victim_age" INTEGER   NOT NULL,
    "victim_gender" VARCHAR   NOT NULL,
    "victim_race" VARCHAR   NOT NULL,
    "location" VARCHAR   NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE race (
    "race_init" VARCHAR NOT NULL,
    "race_description" VARCHAR NOT NULL,
	PRIMARY KEY (race_init)
);

-- After Inserting Data, Following Tables are created to Normalize the data.
CREATE TABLE crash (
    "crash_id" INT NOT NULL,
    "crash_date_time" TIMESTAMP NOT NULL,
    "crash_location" VARCHAR NOT NULL,
	PRIMARY KEY (crash_id)
);

INSERT INTO crash(crash_id, crash_date_time,crash_location)
	SELECT id, datetime, location
	FROM "CrashRaw";
	
CREATE TABLE areas (
    "area_id" SERIAL,
    "area" VARCHAR NOT NULL,
	"district" VARCHAR NOT NULL,
	PRIMARY KEY (area_id)
);
INSERT INTO areas (area,district)
	SELECT area, district
	FROM "CrashRaw"
	GROUP BY area, district;


CREATE TABLE gender (
    "gender_id" SERIAL NOT NULL,
    "gender" VARCHAR NOT NULL,
	PRIMARY KEY (gender_id)
);
INSERT INTO gender (gender)
	SELECT DISTINCT victim_gender
	FROM "CrashRaw";

CREATE TABLE victim(
	"victim_id" SERIAL NOT NULL,
	PRIMARY KEY (victim_id),
	"crash_id" INT NOT NULL ,
	CONSTRAINT fk_crash FOREIGN KEY (crash_id)
	REFERENCES "CrashRaw" (id),
	"area_id" INT NOT NULL,
	CONSTRAINT fk_area FOREIGN KEY (area_id)
	REFERENCES areas(area_id),	
	"race_init" VARCHAR,
	CONSTRAINT fk_race FOREIGN KEY (race_init)
	REFERENCES race(race_init),
	"gender_id" INT,
	CONSTRAINT fk_gender FOREIGN KEY (gender_id)
	REFERENCES gender(gender_id),
	"age" INT NOT NULL
);

INSERT INTO victim(crash_id, area_id,race_init,gender_id,age)
SELECT a.id, area_id,victim_race,gender_id, victim_age
	FROM (SELECT id , gender_id,victim_race,victim_age
		FROM "CrashRaw" craw
		JOIN gender g
		ON craw.victim_gender = g.gender) a
	JOIN
		(SELECT id, craw.area, area_id
		FROM "CrashRaw" craw
		JOIN areas a
		ON craw.district = a.district) b
	ON a.id = b.id;

-- ADD Ethnicity Bucket to race table
ALTER TABLE race
ADD COLUMN race_bucket VARCHAR;

UPDATE race
SET race_bucket = 'Asian'
WHERE
   race_init IN ('A','C','D','F','G','J','K','L','V');
 
UPDATE race
SET race_bucket = 'Black'
WHERE
   race_init = 'B';

UPDATE race
SET race_bucket = 'Hispanic'
WHERE
   race_init = 'H';
 
UPDATE race
SET race_bucket = 'American Indian'
WHERE
   race_init = 'I';
   
UPDATE race
SET race_bucket = 'Pacific Islander'
WHERE
   race_init IN ('P','S','U');
   
UPDATE race
SET race_bucket = 'White'
WHERE
   race_init = 'W';

UPDATE race
SET race_bucket = 'Other'
WHERE
   race_init IN ('O','X','Z','-');

-- Create Table LA Population
CREATE TABLE lapop (
	race_bucket VARCHAR NOT NULL,
	population_percentage DECIMAL,
	PRIMARY KEY (race_bucket)
);
INSERT INTO lapop(race_bucket, population_percentage)
	SELECT DISTINCT race_bucket, 1
	FROM race;
	
UPDATE lapop
SET population_percentage = 0.002
WHERE
   race_bucket = 'Pacific Islander';
UPDATE lapop
SET population_percentage = 0.089
WHERE
   race_bucket = 'Black';
UPDATE lapop
SET population_percentage = 0.284
WHERE
   race_bucket = 'White';
UPDATE lapop
SET population_percentage = 0.117
WHERE
   race_bucket = 'Asian';
UPDATE lapop
SET population_percentage = 0.035
WHERE
   race_bucket = 'Other';
UPDATE lapop
SET population_percentage = 0.487
WHERE
   race_bucket = 'Hispanic';
UPDATE lapop
SET population_percentage = 0.007
WHERE
   race_bucket = 'American Indian';

SELECT * FROM lapop;
	
	
