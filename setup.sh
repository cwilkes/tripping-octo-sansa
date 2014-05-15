dropdb rads
createdb rads
psql rads -c 'create extension hstore;'
psql rads -c 'CREATE EXTENSION plpythonu;'
psql rads -c "create table fires (id bigint, actions hstore)"
