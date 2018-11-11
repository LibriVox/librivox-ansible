# Docs

## Database

On staging and production, creating a database calls a handler that imports
said database from the latest backups.

## Other notes

The following directories of user-generated content need to be populated
manually (ie, restored from backups):

* /librivox/www/librivox.org/wordpress/wp-content/uploads/
* /librivox/www/wiki.librivox.org/images/
* /librivox/shared/librivox-validator-books/
* /librivox/shared/uploads/uploads/

The playbooks don't (and can't) setup the PTR and SPF records to allow the
server to send out emails. This is needed by the forum.
