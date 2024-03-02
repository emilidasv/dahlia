# Design Document

Carolina Nilsson

Video overview: <URL HERE>

## About Flowers called Dahlia:
* Dahlias comes in many shapes and colors and to be able to easy plan our garden we need a tool to search for the right combinations.

* While there are only 42 species, there are over 57,000 different cultivated varieties registered with the Royal Horticultural Society. The dahlia's name in Nahuatl, the language spoken by the Aztec people, is acocoxochitl, meaning 'water pipe flower', as they used hollow Dahlia imperialis stems to transport water. (https://www.dahlia.org/docsinfo/species-dahlias/list-of-species-dahlias/)

* With over 50,000 thousand named cultivars dahlias are among the most beloved flowers in gardens around the world. Understand that not all 50,000 are still in existence; there are probably no more than 4,000-5,000 currently.

* We have had about 50 varieties in our garden but they will not be represented in this project. There are so many varieties of colors in the Dahlia world, and it is difficult to get a quick answer about which Dahlia you can use in each place in the garden to get good color combinations.
For this project, I have created fake data. I have generated fake names and this is to make sure this database in scalable. In reality I realise we never need to scale it, but this is to learn, right :-)

* The purpose of this database is that it will be a help track of all our Dahlia tubers we have; it will replace the Excel sheet we now have to store that information. The Excel sheet is not a very good solution, and it is hard to answer questions that you want to answer.

* In the future, we will also be able to get some statistics out of it, but that is not the main purpose, and for this project. We will be able to add data for each season, when we dig them up, when the first frost, etc, but as I said, this is out of this project's scope.

## Scope

* The main objects in this database are, of course, the Dahlias and their properties. It will also keep track of where and when the tubers were bought or if they were traded with a friend.

* It will keep track of which dahlias we had different planting seasons and how many of each tubers.
*

## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?
To tell which variety we had each year, know the inventory of each type of Dahlias, if it is a late or early variety, and which colors it has.
See which varieties we have of different types, sizes, and heights. How long we hav had a dahlias, see how many dahlias and which we had certain season.

* What's beyond the scope of what a user should be able to do with your database?
* Any information about the company where we bought the tubers will not be found in the database. We could have added another table for that but it is out of scope.

* There will not be a UI for this database.
* The images of the Dahlias will not be saved in the database. Instead, there will be a URL to a picture of the flower. The URL is, for now, only the name of an image of each Dahlia, but the actual images are not uploaded here, and that information is out of scope, but the column is kept in because of the thought process of how to store images in the database and we won't store the images, we will only store an url, even though in this case the url will not lead to anywhere.

## Representation

In the database, all varieties of Dahlias, which season we acquired them, and from whom. What attributes do all the Dahlias have, and how many of the tuber did we have each season? Which of the Dahlias we once had did we still have after each season.

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?

There will be five tables in the database.
Color, Dahlias, Acquired, Collections_dalia_per_season, Seasons

* What attributes will those entities have?

* Colors is a table with all possible combinations of colors.
Since there are 7 possible colors, it means this table will have 2^7 combinations, which is 128 rows. This should in the final application be a read-only table since this combination will never change. All combinations will never be represented by a real Dahlia in the real world, but in my fake data, that might happen.
Colors have 7 colors that either can be in the color or not so the table should potentially be named color_combinations instead but I kept the short name colors.

* Seasons
In this table, I have one column that is specific to the season, and that is where the planting took place. In the future, here is where I can add statistical data such as the first date of frost, the cutting date, how many days of rain, and how many days of sun, by adding new columns in this table.

* Dahlias
All dahlias have some specific attribute such as colors, name, type of bloom, the size of the bloom the height of the plant and when it starts to bloom. Those are specific for each Dahli, and we in our garden have given them a specific number, and in this database, we call that planting number.

Collections_per_dahlias and Season.

When doing the normalization of the database, I realized I needed the entity "Collections_dahlia_per_season"; otherwise, I would have ended up with an N-N relationship between Dahlias and season. By adding this table between Sesason and Dahlias I got two 1-N relationships instead.  This is why I have two foreign keys for this Collections_dahlia_per_season table as the only key for that table.


Acquired
Same happened for the relationship between Dahlias and Seasons there was an Many to Many relationship (N-N) so i added the table acquired between them.

In reality this fake data that I have created is randomized for every year and the data in our database will always take care
of that it is not. SInce it will be update every year.
That is the reason we have the attribute "stillalive" in the table acquired. In the real world this number would be the same as
above quiestion, but this will not be the case in this database full with fake data.

But when doing the queries for the database, I realized that one of the columns would be redundant data, so I removed the column 'still alive in the Acquired table. WE can still get this information via question 5 instead, and the column should have been redundant if I kept it.

Here is a question that would have worked with the old version of the database
SELECT "acquired"."dahlia_id" , "Collections_dahlias_per_seasons"."amountOfTuber" as "am_tubers", "acquired"."season_id" FROM "Acquired"
JOIN "Collections_dahlias_per_seasons" ON ("Collections_dahlias_per_seasons"."dahlia_id" = "Acquired"."dahlia_id")
WHERE acquired.stillalive = TRUE AND "acquired"."Season_id" = '2023';


## Relationships

In this section, you should include your entity relationship diagram and describe the relationships between the entities in your database.


![IMAGE TITLE](dahlias_relationship_image.png)

## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?
I did some "fake" data in the database for older seasons than 2023 to be able to try it out and make some time estimates. I did measure the times before and after adding some indexes to see how they affected the times, and I also measured the size of the database before and after.
DEspite the fact that I created "fake" data the data bas is very small and my queries

The size of the database before I did any indexing was: ( with help of command:$ du -b dahlias.db)
159744  dahlias.db, after creating an dindex on aquired bohts foreigh keys it grow to 163840  but the time for an update question was much shorter.
This will be a common thing to do, so the extra space it took to have an index on the table will be worth it when and if the databases should be scalable.

## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?
If I want to get information about the companies that sell tubers, that is nowhere to be found in this database. We could add a table for Company and have that information in that, but for now, it is only about where we acquired our dahlias.

* What might your database not be able to represent very well?
The price changes of Dahlias will not be shown. It will only store a historical price for the Dahlias.

## Future implementations
First of all it would be a UI for the database. but after that I would add some other tables to store more information. As I mentioned earlier, I would add a table Company to store information about different seller on their website and potentially their inventory.
Some other aspects that I have not included in the project are also would be a table such as "Garden Location" for the location in the garden or a table for "mainteenance for each Dahlia. Were they attacked by diseases etc?. But that again is out cope for this project.

## Transcript for voice over video on video:

Carolina Nilsson, Lafayette, Colorado, in the US.
Final project in the course CS50SQL from Harvard.
Project: "Dahlia Depot".
Github username: emilidasv.
Edx username: emilida.
Video recorded: January 8, 2024.

Dahlias come in many shapes and colors, and to be able to plan our garden easily and choose the right color combinations and types, we want a better tool than Excel. Dahlia Depot will be the first step to getting that tool.

Here is a diagram of all the tables in the database.

From the left to the right, you first see the table "Colors."
This is a table for all combinations of colors taht exist when using Dahlias' seven most common colors.

Going to the right, you see the table "Dahlias", which has all varieties of the Dahlias and their attributes.

Then you have two tables, "Collections..." and "Acquired," and they both are added between the table "Seasons" and the table "Dahlias".
I added them since, otherwise, those tables would have had an N-N type of relationship.
Seasons is the table where information about the season is stored. while
Acquired tells when we did buy a specific Dahlia.
Collection... gives information about how many tubers a specific dahlia produced during a season.

You see the code for creating all the tables on the right.

To test my database, I created "fake" data to test scalability with the help of a function for getting Random data in Excel. I created a total of five CSV files and imported them into the database.

I created a view called "ourdahlias," which is a Join between the tables "colors" and "Dahlias". The colors table is really a table that easily creates all existing combinations, so we will only ask questions towards this created view.

I also tested some queries, and one of them took a while when the table acquired was involved. I explored the query, and saw that it "scanned" the table. so I created an index called acquired_index. The time it took for the query didn't decrease, but the size of the database increased, so I dropped the index.  The database, even though I tried to create fake data, doesn't have enough data, to need an index beyond the primary keys.

I also created some common queries:

Next step for me is to work on creating real data CSV files and then a GUI and meanwhile, you can see some of our real Dahlias:





