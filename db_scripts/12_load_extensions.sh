#!/bin/sh
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  -- must quote extension names or else symbolic error will be thrown.

  -- "postgis" will be installed by the 10_postgis.sh script (provided from postgis/postgis:14-3.1)
  -- CREATE EXTENSION IF NOT EXISTS "postgis";

  -- CREATE EXTENSION IF NOT EXISTS "pg_trgm";

  SELECT * FROM pg_extension;
EOSQL
