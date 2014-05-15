select id, json_array_length(actions) from fires;
select * from fires where id = 5194021991962902528;
select id, actions->1 from fires where id=5194021991962902528;
select id, actions->1->'cat' from fires where id=5194021991962902528;
select id from fires where (actions->1->>'cat')::int = 1116;
select id, json_array_elements(actions)->'cat' from fires where id=5194021991962902528;
