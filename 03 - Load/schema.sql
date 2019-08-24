-- DROP TABLE "CrashRaw";
DROP TABLE area;
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
	
CREATE TABLE area (
    "area_id" SERIAL,
    "area" VARCHAR NOT NULL,
	"district" VARCHAR NOT NULL,
	PRIMARY KEY (area_id)
);
INSERT INTO area (area,district)
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
	"crash_id" INT NOT NULL ,
	CONSTRAINT fk_crash FOREIGN KEY (crash_id)
	REFERENCES crash(crash_id),
	"area_id" INT NOT NULL,
	CONSTRAINT fk_area FOREIGN KEY (area_id)
	REFERENCES area(area_id),	
	"race_init" VARCHAR,
	CONSTRAINT fk_race FOREIGN KEY (race_init)
	REFERENCES race(race_init),
	"gender_id" INT,
	CONSTRAINT fk_gender FOREIGN KEY (gender_id)
	REFERENCES gender(gender_id),
	"age" INT NOT NULL
);
INSERT INTO victim(crash_id, area_id,race_init,gender_id,age)
	SELECT c.crash_id, a.area_id, r.race_init, g.gender_id, victim_age
	FROM "CrashRaw" craw 
	JOIN gender g
	ON craw.victim_gender = g.gender
	JOIN area a
	ON craw.area = a.area
	JOIN crash c
	ON craw.id = c.crash_id
	JOIN race r
	ON craw.victim_race = r.race_init;
	
	
-- CREATE TABLE "Victim"    
-- FOREIGN KEY (crash_id) REFERENCES Crash(id),
--     FOREIGN KEY (gender_id) REFERENCES Gender(id),
--     FOREIGN KEY (race_init) REFERENCES Ethnicity(race_init),
--     FOREIGN KEY (area_id) REFERENCES Area(id),
--     "age" INTEGER NOT NULL
-- );
