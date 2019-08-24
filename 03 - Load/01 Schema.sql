DROP TABLE IF EXISTS Coordinates;
DROP TABLE IF EXISTS Ethnicity;
DROP TABLE IF EXISTS Gender;
DROP TABLE IF EXISTS District;
DROP TABLE IF EXISTS Area;
DROP TABLE IF EXISTS Crash;
DROP TABLE IF EXISTS Victim;
DROP TABLE IF EXISTS LAPopulation;

CREATE TABLE "Coordinates" (
    "location_id" INTEGER   NOT NULL,
    "location" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Coordinates" PRIMARY KEY (
        "location_id"
     )
);

CREATE TABLE "Ethnicity" (
    "ethnicity_id" INTEGER   NOT NULL,
    "initial" VARCHAR   NOT NULL,
    "ethnicity" VARCHAR   NOT NULL,
    "ethnicity_bucket" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Ethnicity" PRIMARY KEY (
        "ethnicity_id"
     )
);

CREATE TABLE "Gender" (
    "gender_id" INTEGER   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Gender" PRIMARY KEY (
        "gender_id"
     )
);

CREATE TABLE "District" (
    "district_id" INTEGER   NOT NULL,
    "district" VARCHAR   NOT NULL,
    CONSTRAINT "pk_District" PRIMARY KEY (
        "district_id"
     )
);

CREATE TABLE "Area" (
    "area_id" INTEGER   NOT NULL,
    "area" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Area" PRIMARY KEY (
        "area_id"
     )
);

CREATE TABLE "Crash" (
    "crash_id" INTEGER   NOT NULL,
    "crash_date_time" TIMESTAMP   NOT NULL,
    "age" INTEGER   NOT NULL
);

CREATE TABLE "Victim" (
    "crash_id" SERIAL   NOT NULL,
    "area_id" INTEGER   NOT NULL,
    "district_id" INTEGER   NOT NULL,
    "gender_id" INTEGER   NOT NULL,
    "ethnicity_id" INTEGER   NOT NULL,
    "location_id" INTEGER   NOT NULL,
    CONSTRAINT "pk_Victim" PRIMARY KEY (
        "crash_id"
     )
);

CREATE TABLE "LAPopulation" (
    "ethnicity_bucket" VARCHAR   NOT NULL,
    "population_percentage" DECIMAL   NOT NULL,
    CONSTRAINT "pk_LAPopulation" PRIMARY KEY (
        "ethnicity_bucket"
     )
);

ALTER TABLE "Ethnicity" ADD CONSTRAINT "fk_Ethnicity_ethnicity_bucket" FOREIGN KEY("ethnicity_bucket")
REFERENCES "LAPopulation" ("ethnicity_bucket");

ALTER TABLE "Crash" ADD CONSTRAINT "fk_Crash_crash_id" FOREIGN KEY("crash_id")
REFERENCES "Victim" ("crash_id");

ALTER TABLE "Victim" ADD CONSTRAINT "fk_Victim_area_id" FOREIGN KEY("area_id")
REFERENCES "Area" ("area_id");

ALTER TABLE "Victim" ADD CONSTRAINT "fk_Victim_district_id" FOREIGN KEY("district_id")
REFERENCES "District" ("district_id");

ALTER TABLE "Victim" ADD CONSTRAINT "fk_Victim_gender_id" FOREIGN KEY("gender_id")
REFERENCES "Gender" ("gender_id");

ALTER TABLE "Victim" ADD CONSTRAINT "fk_Victim_ethnicity_id" FOREIGN KEY("ethnicity_id")
REFERENCES "Ethnicity" ("ethnicity_id");

ALTER TABLE "Victim" ADD CONSTRAINT "fk_Victim_location_id" FOREIGN KEY("location_id")
REFERENCES "Coordinates" ("location_id");

