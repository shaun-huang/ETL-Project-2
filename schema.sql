-- DROP TABLE "CrashRaw";
-- DROP TABLE "Area";
-- DROP TABLE "Ethnicity";
-- DROP TABLE "Gender";
-- DROP TABLE "Crash";
-- DROP TABLE "Victim";

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
CREATE TABLE "Area" (
    "id" SERIAL NOT NULL,
    "area" VARCHAR NOT NULL,
	"district" INT NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE "Gender" (
    "id" SERIAL NOT NULL,
    "gender" VARCHAR NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE "Ethnicity" (
    "race_init" VARCHAR NOT NULL,
    "race_description" VARCHAR NOT NULL,
	PRIMARY KEY (race_init)
);
CREATE TABLE "Crash" (
    "id" SERIAL NOT NULL,
    "crash_date_time" TIMESTAMP NOT NULL,
    "crash_location" VARCHAR NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE "Victim"(
	"age" INT NOT NULL
    'crash_id' SERIAL REFERENCES "Crash" (id)
);
-- CREATE TABLE "Victim"    
-- FOREIGN KEY (crash_id) REFERENCES Crash(id),
--     FOREIGN KEY (gender_id) REFERENCES Gender(id),
--     FOREIGN KEY (race_init) REFERENCES Ethnicity(race_init),
--     FOREIGN KEY (area_id) REFERENCES Area(id),
--     "age" INTEGER NOT NULL
-- );
