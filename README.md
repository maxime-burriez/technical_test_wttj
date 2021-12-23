# Welcome to the Jungle - Backend Technical Test

This is my [work](https://github.com/maxime-burriez/technical_test_wttj) (ref. [Maxime Burriez](https://github.com/maxime-burriez)) in response to the _Welcome to the Jungle - Backend Technical Test_.

## 01 / 03 . Exercise: Continents grouping

To see the result returned by the SQL script:

  * Run `docker-compose up`.
  * Wait for the application to be initialized. It may take a few minutes for all the data to be loaded into database.
  * Go-to `postgresql://wttj:password@localhost:5432/db_wttj` with your database client.
  * Open the `public.jobs_per_profession_category_per_continent` SQL view to see the result.

### Notes

For this first exercise, I chose to focus on the performance of a postgreSQL database. For the transformation of GPS coordinates into continents, the `geo.get_continent` function takes care of it through the [PostGIS](https://postgis.net/) plugin. The continent of a new job offer is calculated when this job is inserted in BDD. You will notice that for 156 job offers, it was not possible to determine the continent (_undetermined continent_). This is because the reference world map (`fixtures/World_Continents.geojson`) used here is not very precise and has not been optimized for this exercise. Moreover, with an optimized `.geojson` file, the data loading would be faster.

The `public.jobs_per_profession_category_per_continent` SQL view allows you to visualize the expected result.

The database load scripts found in the [db_scripts](db_scripts) folder will be played in alpha-numeric order:

  * `02_init_schemas.sql`
  * `10_postgis.sh` (Not visible here since provided originally in the PostGIS docker image used here.)
  * `12_load_extensions.sh`
  * `22_load_continents.sh`
  * [32_migrations.sql](db_scripts/32_migrations.sql) (This is where most of the magic happens.)
  * [42_seeds.sql](db_scripts/42_seeds.sql)

## 02 / 03 . Question: Scaling ?

> Now, let’s imagine we have 100 000 000 job offers in our database, and 1000 new job offers per second (yeah, it’s a lot coming in!). What do you implement if we want the same output than in the previous exercise in real-time?

In order to avoid a bottleneck in the insertion of job offers in the database, I propose to take advantage of [postgreSQL database schemas](https://www.postgresql.org/docs/current/ddl-schemas.html). Thus, with this multitenancy strategy, the workload would be better distributed.

Initially, before analyzing the results obtained in the first exercise, I had thought of creating a schema by continent. However, if we look at the distribution of job offers per continent, we can see that the majority of job offers are in Europe (4757/5069).

On the other hand, if we look at the distribution of job offers per profession category, we can see that this distribution seems more balanced.

So, I propose to create one database schema per profession category.

Finally, to complete the architecture, it is possible to implement the archiving of obsolete job offers. For example, these expired job offers could be transferred to a dedicated schema.

## About me

  * Github profile: https://github.com/maxime-burriez
  * Linkedin profile: https://www.linkedin.com/in/maxime-burriez/

Thank you !
