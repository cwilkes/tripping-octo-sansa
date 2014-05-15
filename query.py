import psycopg2
import sys
import simplejson as json
from collections import namedtuple

User = namedtuple('User', 'uuid actions')


def get_users(reader):
    for p in (_.strip().split() for _ in reader):
        uuid = int(p[0])
        actions = list()
        for ns, site, cat, freq, recency in (_.split(',') for _ in p[1:-1]):
            actions.append(dict(ns=ns, site=site, cat=cat, freq=freq, recency=recency))
        yield User(uuid, actions)


def main(args):
    sql = args[1]
    conn = psycopg2.connect('dbname=rads')
    cur = conn.cursor()
    cur.execute('select id from fires where %s' % (sql, ))
    for uuid in (_[0] for _ in cur):
        print uuid

if __name__ == '__main__':
    main(sys.argv)