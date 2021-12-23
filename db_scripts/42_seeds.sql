COPY professions(id, name, category_name)
FROM '/fixtures/technical-test-professions.csv'
DELIMITER ','
CSV HEADER;

COPY jobs(profession_id, contract_type, name, office_latitude, office_longitude)
FROM '/fixtures/technical-test-jobs.csv'
DELIMITER ','
CSV HEADER;
