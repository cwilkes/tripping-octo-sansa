CREATE FUNCTION group_ns_cat(events text[])
	RETURNS text[]
AS $$
	info = dict()
	for p in (_.split() for _ in events):
		for i in range(0, len(p), 2):
			ns_cat = p[i]
			freq, recency = [int(_) for _ in p[i+1].split('_')]
			if not ns_cat in info:
				info[ns_cat] = [freq, recency]
			else:
				info[ns_cat][0] = max(info[ns_cat][0], freq)
				info[ns_cat][1] = min(info[ns_cat][1], recency)
	ret = list()
	for key, val in info.items():
		ret.append(key)
		ret.append('%d_%d' % tuple(val))
	return ret
$$ LANGUAGE plpythonu;
