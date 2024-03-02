-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

--How many data in each table?
SELECT COUNT(*) FROM "Acquired";
SELECT COUNT(*) FROM "Seasons";
SELECT COUNT(*) FROM "Colors";
SELECT COUNT(*) FROM "Dahlias";
SELECT COUNT(*) FROM "Collections_dahlias_per_seasons";

-- DO  I need an index?

-- .timer ON

INSERT INTO "Acquired" ("dahlia_id","name","type","season_id","price" )
VALUES  (130, "Anna", "Company", 2023, 15 );

--EXPLAIN QUERY PLAN
SELECT acquired_id FROM acquired WHERE
                                                                    (dahlia_id = 130)
                                                                    and ("name" LIKE '%Anna%')
                                                                    and ( type = "Friend")
                                                                    and (Season_id =2023);

--create index
CREATE INDEX acquired_index ON "Acquired"("dahlia_id","season_id" );
-- This was not of any help for times on query and the database it too small so we Will DROP the index.
DROP INDEX "acquired_index";

--Questions for index

INSERT INTO "Acquired" ("dahlia_id","name","type","season_id","price" )
VALUES  (649, "SID", "Company", 2020, 15 );

INSERT INTO "Acquired" ("dahlia_id","name","type","season_id","price" )
VALUES  (130, "Anna", "Company", 2023, 15 );

UPDATE "Acquired"
SET "type"= "Friend"
WHERE acquired_id IN (SELECT acquired_id FROM acquired WHERE
                                                                    (dahlia_id = 130)
                                                                    and ("name" LIKE '%Anna%')
                                                                    and ( type = "Company")
                                                                    and (Season_id =2023));
SELECT acquired_id FROM acquired WHERE
                                                                    (dahlia_id = 130)
                                                                    and ("name" LIKE '%Anna%')
                                                                    and ( type = "Friend")
                                                                    and (Season_id =2023);
DELETE From acquired WHERE acquired_id= 100;

SELECT acquired_id FROM acquired
JOIN seasons ON (seasons.season_id = acquired.season_id)
WHERE seasons.place="Sammamish";


-- Below ther are some common questions

--1) What Dahlia do I have plant that has the colors Red and Yellow?
--To be able to plan the garden I need to know which colors the Dahlias have. There are many color combination,
--not all that exists in the table color_combinations do exist in real life though.

SELECT * FROM Dahlias WHERE color_id IN(SELECT color_id FROM colors WHERE "red"=TRUE and "yellow" =TRUE);
--but after creating the view "ourdahlias" this will simply be:

SELECT distinct * FROM ourdahlias WHERE  "red"=TRUE and "yellow" =TRUE;


--2 How many varited of Dahlia tuber did we have season 21?
--

SELECT COUNT(dahlia_id) FROM "Collections_dahlias_per_seasons"
WHERE Season_id = '2021';

--3) What dalias do I have that are of the type Pom Pon that are yellow and red?

SELECT "name" FROM (
SELECT dahlias.dahlia_id , dahlias.name as "name" FROM Dahlias
JOIN "Collections_dahlias_per_seasons" ON ("Collections_dahlias_per_seasons".dahlia_id = Dahlias.dahlia_id)
WHERE dahlias.bloom_type LIKE '%Pom Pon%' and
dahlias.color_id IN (SELECT color_id FROM colors WHERE "red"=TRUE and yellow =TRUE));

--4 How many tubers did we have of the above tubes in the end of season 2017?
SELECT "am_tubers" FROM (
SELECT "dahlias"."dahlia_id" , "Collections_dahlias_per_seasons"."amountOfTuber" as "am_tubers", season_id FROM "Dahlias"
JOIN "Collections_dahlias_per_seasons" ON ("Collections_dahlias_per_seasons"."dahlia_id" = "Dahlias"."dahlia_id")
WHERE "dahlias"."bloom_type" LIKE '%Pom Pon%'
and ("dahlias"."color_id" IN (SELECT color_id FROM colors WHERE "red"=TRUE and yellow =TRUE))
and ("Collections_dahlias_per_seasons"."season_id"='2017'));

--5 How many variteis of Dahlias do we still have and how many tubers of each?
SELECT "dahlias"."name" , "Collections_dahlias_per_seasons"."amountOfTuber" as "am_tubers", season_id FROM "Dahlias"
JOIN "Collections_dahlias_per_seasons" ON ("Collections_dahlias_per_seasons"."dahlia_id" = "Dahlias"."dahlia_id")
WHERE ("Collections_dahlias_per_seasons"."season_id"='2023');

--6 How many differnt varieties of Dahlias did we get/bought season 2022
SELECT dahlias.dahlia_id FROM dahlias
JOIN acquired ON (dahlias.dahlia_id = acquired.dahlia_id)
WHERE acquired.season_id = '2022';

EXPLAIN QUERY PLAN
SELECT dahlias.dahlia_id , acquired.name , acquired.season_id FROM dahlias
   JOIN acquired ON (dahlias.dahlia_id = acquired.dahlia_id)
   WHERE season_id='2022';



-- Other Queries

select * from collections where season='2023';






