# Docs

## Database

While the databases are created by the Ansible playbooks, they must be imported
manually. On localdev, the catalog database can be
imported from a scrubbed (all personal information removed) database snapshot.
The other databases are left empty.

## TLS

Setting up and renewing TLS with Let's Encrypt is finicky enough that it's done
manually.

When the certs are first issued for a new deployment, no web server is running
(there are no TLS certs yet), so certbot must be run with the
`--standalone` plugin.

```
$ sudo certbot --agree-tos -n -m notartom@gmail.com \
    certonly --standalone \
    -d librivox.org,forum.librivox.org,wiki.librivox.org
```

Once the deployment is up and running, the `--webroot` plugin can be used.

```
$ sudo certbot --agree-tos -n -m notartom@gmail.com \
    certonly --webroot \
    -w /librivox/www/librivox.org/wordpress -d librivox.org \
    -w /librivox/www/forum.librivox.org/phpBB -d forum.librivox.org \
    -w /librivox/www/wiki.librivox.org -d wiki.librivox.org
```

`certbot` will install a systemd timer to renew the certs. `--webroot`
doesn't come with a `--post-hook` option (which we need to reload Apache), so
we disable the timer with `sudo systemctl disable certbot.timer`, and install a
`@weekly` cronjob to renew the certs that runs the above command line
followed by a `systemctl reload apache2.service`

### Cleanup

`certbot` persists a bunch of state, which we can cleanup with:

```
$ sudo find /etc/letsencrypt -name '*librivox.org*' -exec rm -r '{}' \;
```

### Staging

Staging doesn't have its own DNS (it's accessed by editing your local
`/etc/hosts` file), so we're stuck copying `/etc/letsencrypt/live/librivox.org`
from production.

## Upgrades and databases

WordPress, phpBB and MediaWiki may need to update their DB schemas following a
version update. For WordPress, this is done in the web console when accessing
the `wp-admin/` URL. For phpBB and MediaWiki, it is done via the CLI.

```
$ pwd
/librivox/www/forum.librivox.org/phpBB/bin
$ ./phpbbcli.php db:migrate
```

```
$ pwd
/librivox/www/wiki.librivox.org
$ php maintenance/run.php update
```

## Other notes

The following directories of user-generated content need to be populated
manually (ie, restored from backups):

* /librivox/www/librivox.org/wordpress/wp-content/uploads/
* /librivox/www/wiki.librivox.org/images/
* /librivox/shared/librivox-validator-books/
* /librivox/shared/uploads/uploads/

The playbooks don't (and can't) setup the PTR and SPF records to allow the
server to send out emails. This is needed by the forum.
