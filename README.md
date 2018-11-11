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
see [the development setup guide](doc/localdev.md).
