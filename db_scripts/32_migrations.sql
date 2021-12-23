CREATE FUNCTION geo.get_continent(
  longitude double precision,
  latitude double precision
) RETURNS CHARACTER VARYING AS $$
  BEGIN RETURN (
    SELECT
      c.continent
    FROM
      geo.continents c
    WHERE
      ST_Contains(c.wkb_geometry, ST_SetSRID(ST_MakePoint(longitude, latitude), 4326))
    LIMIT 1
  ); END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE TABLE professions (
  id BIGSERIAL PRIMARY KEY,
  name CHARACTER VARYING,
  category_name CHARACTER VARYING
);

CREATE TABLE jobs (
  id BIGSERIAL PRIMARY KEY,
  profession_id BIGINT REFERENCES professions(id),
  contract_type CHARACTER VARYING,
  name CHARACTER VARYING,
  office_latitude double precision,
  office_longitude double precision,
  continent CHARACTER VARYING
    GENERATED ALWAYS
    AS ( geo.get_continent(office_longitude, office_latitude) )
    STORED
);

CREATE INDEX professions_category_name
  ON professions (category_name);

CREATE INDEX jobs_continent
  ON jobs (continent);

CREATE VIEW jobs_per_profession_category_per_continent AS (
  SELECT
    COALESCE(profession.category_name, 'no category selected') AS profession_category_name,
    COALESCE(job.continent, 'undetermined continent') AS job_continent,
    COUNT(*)
  FROM
    jobs job
  LEFT JOIN
    professions profession
  ON
    job.profession_id = profession.id
  GROUP BY
    GROUPING SETS (
      (profession_category_name, job_continent),
      (profession_category_name),
      (job_continent),
      ()
    )
);
