#!/bin/sh
set -e

ogr2ogr -f PostgreSQL\
        PG:"dbname=$POSTGRES_DB user=$POSTGRES_USER password=$POSTGRES_PASSWORD"\
        /fixtures/World_Continents.geojson -nln geo.continents
