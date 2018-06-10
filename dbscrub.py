#!/usr/bin/env python

import argparse
import re
import sys
import pymysql.cursors


def get_catalog_db_creds():
    CI_CONFIG_FILE = ('/librivox/www/librivox.org/'
                      'catalog/application/config/database.php')

    username_regex = "\$db\['default'\]\['username'\] = '(\w+)'"
    password_regex = "\$db\['default'\]\['password'\] = '(\w+)'"
    database_regex = "\$db\['default'\]\['database'\] = '(\w+)'"

    with open(CI_CONFIG_FILE) as conf_file:
        conf = conf_file.read()
        username = re.search(username_regex, conf).group(1)
        password = re.search(password_regex, conf).group(1)
        database = re.search(database_regex, conf).group(1)

    return username, password, database

def scrub_catalog():
    username, password, database = get_catalog_db_creds()
    conn = pymysql.connect(user=username,
                           password=password,
                           database=database)

    with conn.cursor() as cursor:
        cursor.execute('SELECT * FROM users')
        # NOTE(artom) We could be smarter about this, but we only have ~13000
        # users.
        for user in cursor.fetchall():
            print(user)

parser = argparse.ArgumentParser()
parser.add_argument('database', choices=['catalog'],
                    help='The database to scrub.')
args = parser.parse_args()

if args.database == 'catalog':
    scrub_catalog()
