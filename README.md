# LibriVox-ansible

These are the Ansible playbooks used to deploy
[LibriVox](https://librivox.org/). They are designed for and tested on an
Ubuntu Xenial target with networking and SSH already configured. The playbooks
do everything else.

## Local development environments

These playbooks were written with production and staging deployments in mind.
That being said, some considerations were given towards using them for
deploying local development versions of LibriVox. That use case isn't fully
supported (yet?), but with some elbow grease it can be done. A guide is
[available](localdev.md).
