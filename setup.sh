dropdb rads
createdb rads
psql rads -c 'create extension hstore;'
echo "create table fires (id bigint, actions hstore)" | psql rads
