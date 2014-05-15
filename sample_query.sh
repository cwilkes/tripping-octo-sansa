select id, json_array_length(actions) from fires;
select * from fires where id = 5194021991962902528;
select id, actions->1 from fires where id=5194021991962902528;
select id, actions->1->'cat' from fires where id=5194021991962902528;
select id from fires where (actions->1->>'cat')::int = 1116;
select id, json_array_elements(actions)->'cat' from fires where id=5194021991962902528;

select hstore(group_ns_cat(avals(actions-ARRAY['2569','2964']))) from fires where id in(8381748350378967040, 990791273558900736, 2679043641729548288);


select id, hstore(group_ns_cat(avals(actions-ARRAY['2569','2964']))) ? '1_38249' from fires;


# select hstore(group_ns_cat(avals(actions-ARRAY['2569','2964']))) ? '1_38249' as pass, count(*) from fires group by pass;
 pass | count
------+-------
 f    |   988
 t    |    12
(2 rows)



# NOTE: subtract out the EXCLUDED sites to only get those one that partner has access to

# CREATE MATERIALIZED VIEW  partner_4 as select id, hstore(group_ns_cat(avals(actions-ARRAY['2569','2964']))) as ns_cat from fires;
SELECT 1000



# select ns_cat ? '1_38249' as pass, count(*) from partner_4 group by pass;
 pass | count
------+-------
 f    |   988
 t    |    12
(2 rows)


# select ns_cat ? '1_38249' as pass1, ns_cat ? '1_136282' as pass2, count(*) from partner_4 group by pass1, pass2;
 pass1 | pass2 | count
-------+-------+-------
 f     | f     |   983
 f     | t     |     5
 t     | f     |    12
(3 rows)


# select count(*) from partner_4 where ns_cat ? '1_38249' and not ns_cat ? '1_136282';
 count
-------
    12
(1 row)

# select skeys(ns_cat) as x, count(*) from partner_4 group by x order by count(*) desc limit 10;
     x      | count
------------+-------
 1_1116     |   758
 1745_16015 |   538
 1_1        |   442
 1745_16625 |   384
 1_232749   |   358
 1_152489   |   315
 1_67640    |   315
 1_5915     |   314
 1745_2981  |   312
 1_67642    |   312

# select ns_cat ? '1_1116' as pass1, ns_cat ? '1745_16015' as pass2 , count(*) from partner_4 group by pass1, pass2;
 pass1 | pass2 | count
-------+-------+-------
 f     | f     |   242
 t     | f     |   220
 t     | t     |   538
(3 rows)



