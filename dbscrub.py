#!/usr/bin/env python

import argparse
import bcrypt
import pymysql.cursors
import re
import sys


def get_catalog_db_creds():
    # NOTE(artom) Get the creds from the CodeIgniter config file so that we can
    # keep this entire script in public version control.
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


def scrub_catalog(mysql_user=None, mysql_pass=None, mysql_db=None):
    if not mysql_user and not mysql_pass and not mysql_db:
        mysql_user, mysql_pass, mysql_db = get_catalog_db_creds()
    conn = pymysql.connect(user=mysql_user, password=mysql_pass,
                           database=mysql_db,
                           cursorclass=pymysql.cursors.DictCursor)

    salt = bcrypt.gensalt()
    password = bcrypt.hashpw(b'librivox', salt)

    with conn.cursor() as cursor:
        cursor.execute('TRUNCATE TABLE ci_sessions')
        cursor.execute('TRUNCATE TABLE login_attempts')
        cursor.execute('SELECT * FROM users')
        # NOTE(artom) We could be smarter about this, but we only have ~13000
        # users.
        users = cursor.fetchall()
        for user in users:
            if user['username'] == 'administrator':
                username = 'administrator'
            else:
                username = 'librivoxer_%d' % user['id']
            user.update({
                'ip_address': '127.0.0.1',
                'username': username,
                'password': password,
                'email': 'librivoxer_%d@example.com' % user['id'],
                'activation_code': None,
                'forgotten_password_code': None,
                'forgotten_password_time': None,
                'remember_code': None,
                'created_on': 0,
                'last_login': None,
                'active': 1,
                'max_projects': 0,
                'agreement': 1,
                'display_name': 'LibriVoxer %d' % user['id'],
                'forum_name': None,
                'website': None})
            # NOTE(artom) This builds a parametrized query such that we can
            # just use the user dict with cursor.execute(). The query ends up
            # looking like:
            # UPDATE users SET
            #     agreement=%(agreement)s,
            #     ip_address=%(ip_address)s,
            #     forum_name=%(forum_name)s,
            #     <snip>
            # WHERE id=%(id)s
            update_sql = (
                'UPDATE users SET {} WHERE id=%(id)s'.format(
                    ', '.join(
                        '{}=%({})s'.format(field, field) for field in user)))
            cursor.execute(update_sql, user)
            print('Scrubbed user id %d' % user['id'])
    conn.commit()


parser = argparse.ArgumentParser()
parser.add_argument('-u', dest='mysql_user')
parser.add_argument('-p', dest='mysql_pass')
parser.add_argument('-d', dest='mysql_db')
parser.add_argument('database', choices=['catalog'],
                    help='The database to scrub.')
args = parser.parse_args()
print(args)

if args.database == 'catalog':
    scrub_catalog(args.mysql_user, args.mysql_pass, args.mysql_db)
