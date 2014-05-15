import psycopg2
import sys
import simplejson as json
from collections import namedtuple, defaultdict

Profile = namedtuple('Profile', 'uuid actions')
Event = namedtuple('Event', 'ns site cat freq recency')


def get_users(reader):
    for p in (_.strip().split() for _ in reader):
        uuid = int(p[0])
        actions = list()
        for p in (_.split(',') for _ in p[1:-1]):
            actions.append(Event(*p))
        yield Profile(uuid, actions)


def main(args):
    conn = psycopg2.connect('dbname=rads')
    cur = conn.cursor()
    for profile in get_users(sys.stdin):
        actions = defaultdict(list)
        for event in profile.actions:
            actions[event.site].append('%s_%s %s_%s' % (event.ns, event.cat, event.freq, event.recency))
        actions_str = list()
        for site, val in actions.items():
            actions_str.append(site)
            actions_str.append(' '.join(sorted(val)))
        sql = "insert into fires (id, actions) values (%d,hstore(ARRAY['%s']))" % (profile.uuid, "','".join(actions_str))
        cur.execute(sql)
    conn.commit()
    cur.close()
    conn.close()

if __name__ == '__main__':
    main(sys.argv)