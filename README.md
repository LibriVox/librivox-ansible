# LibriVox-ansible

These are the Ansible playbooks used to deploy
[LibriVox](https://librivox.org/). They are designed for and tested on an
Ubuntu Xenial target with networking and SSH already configured. The playbooks
do everything else.

## Scrubbed catalog database

A scrubbed (all personal information removed) catalog database snapshot is
[available](roles/blog+catalog/files/librivox_catalog_scrubbed.sql.bz2). It can
be used as part of a local LibriVox development environment (see next section)
or on its own by anyone interested.

## Local development environments

These playbooks were written with production and staging deployments in mind.
That being said, some considerations were given towards using them for
deploying local development versions of LibriVox. That use case isn't fully
supported (yet?), but with some elbow grease it can be done. A guide is
[available](doc/localdev.md).
