# Docs

## Database

While the databases are created by the Ansible playbooks, they must be imported
manually. On localdev, the catalog database can be
imported from a scrubbed (all personal information removed) database snapshot.
The other databases are left empty.

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
/librivox/www/wiki.librivox.org/maintenance
$ php update.php
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
