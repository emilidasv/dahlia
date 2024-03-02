-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it
--Drop all tables
DROP table "Collections_dahlias_per_seasons";
DROP table "Acquired";
DROP table "Seasons";
DROP table "Dahlias";
DROP table "Colors";
DROP VIEW  "ourdahlias";



-- Create table for colors
CREATE TABLE "Colors"(
    "color_id" INTEGER NOT NULL,
    "white" INTEGER NOT NULL CHECK("white" IN ('1', '0')),
    "pink" INTEGER NOT NULL CHECK("pink" IN ('1', '0')),
    "red" INTEGER NOT NULL CHECK("red" IN ('1', '0')),
    "orange" INTEGER NOT NULL CHECK("orange" IN ('1', '0')),
    "yellow" INTEGER NOT NULL CHECK("yellow" IN ('1', '0')),
    "purple" INTEGER NOT NULL CHECK("purple" IN ('1', '0')),
    "black" INTEGER NOT NULL CHECK("black" IN ('1', '0')),
    PRIMARY KEY("color_id")
);

.import --csv --skip 1 colors.csv "Colors"

CREATE TABLE "Dahlias"(
    "dahlia_id" INTEGER,
    "planting_number" INTEGER,
    "name" TEXT NOT NULL,
    "color_id" INTEGER NOT NULL,
    "bloom_type" TEXT,
    "bloom_size" INTEGER,
    "plant_height" NUMERIC,
    "amountofDays" TEXT,
    "url_to_image" TEXT,
    PRIMARY KEY("dahlia_id"),
    FOREIGN KEY("color_id") REFERENCES "Colors"("color_id")
);

.import --csv --skip 1 Dahlias.csv "Dahlias"


CREATE TABLE "Seasons"(
    "season_id" YEAR NOT NULL,
    "place" TEXT,
    PRIMARY KEY("season_id")
);

.import --csv --skip 1 seasons.csv "Seasons"


CREATE TABLE "Collections_dahlias_per_seasons"(
    "dahlia_id" INTEGER NOT NULL,
    "season_id" INTEGER NOT NULL,
    "conditionforplant" TEXT CHECK("conditionforplant" IN ('sunny','shade')),
    "amountOfTuber" INTEGER NOT NULL,
    FOREIGN KEY("dahlia_id") REFERENCES "Dahlias"("dahlia_id"),
    FOREIGN KEY("season_id") REFERENCES "seasons"("season_id")
);

.import --csv --skip 1 Collections_dahlias_per_seasons.csv "Collections_dahlias_per_seasons"


CREATE TABLE "Acquired"(
    "acquired_id" INTEGER,
    "dahlia_id" INTEGER,
    "season_id" YEAR,
    "type" TEXT CHECK("type" IN ('Company', 'Friend')),
    "name" INTEGER NOT NULL,
    "price" INTEGER,
    PRIMARY KEY("acquired_id"),
    FOREIGN KEY("dahlia_id") REFERENCES "Dahlias"("dahlia_id"),
    FOREIGN KEY("season_id") REFERENCES "Seasons"("season_id")
);

.import --csv --skip 1 acquired.csv "Acquired"

-- create view
CREATE VIEW ourdahlias AS
    SELECT  dahlias.dahlia_id as "dahlia_id",
            dahlias.planting_number as "planting_number",
            dahlias.color_id as "color_id",
            dahlias.bloom_type as "bloom_type",
            dahlias.bloom_size as "bloom_size",
            dahlias.plant_height as "plant_height",
            dahlias.amountofDays as "amountofDays",
            dahlias.url_to_image as "url_to_image",
            colors.white as "white",
            colors.red as "red",
            colors.orange as "orange",
            colors.yellow as "yellow",
            colors.black as "black",
            colors.pink as "pink",
            colors.purple as "purple"
    FROM dahlias
    JOIN colors ON ( colors.color_id = dahlias.color_id);

    
