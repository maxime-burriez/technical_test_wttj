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

## About me

  * Github profile: https://github.com/maxime-burriez
  * Linkedin profile: https://www.linkedin.com/in/maxime-burriez/

Thank you !
