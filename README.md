# LibriVox-ansible

These are the Ansible playbooks used to deploy
[LibriVox](https://librivox.org/). They are designed for and tested on an
Ubuntu Xenial target with networking and SSH already configured. The playbooks
do everything else.

While some considerations were given towards using the playbooks for deploying
local development versions of LibriVox for dev work, that use case isn't fully
supported yet, so for now only production and staging environments can be
deployed on LibriVox's [Internet Archive](https://archive.org) servers.
For setting up a LibriVox development environment,
see [the development setup guide](setup-localdev.md).

The playbooks do handle importing databases from the latest backups if
necessary, but no other user-generated content is managed. Specifically, the
following folders need to be populated manually:

* /librivox/www/librivox.org/wordpress/wp-content/uploads/
* /librivox/www/wiki.librivox.org/images/
* /librivox/shared/librivox-validator-books/
* /librivox/shared/uploads/uploads/

Another thing that the playbooks don't (and can't) do for production
deployments: setup the PTR and SPF records to allow the server to send out
emails. This is needed by the forum.
