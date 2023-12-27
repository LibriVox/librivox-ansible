# LibriVox-ansible

These are the Ansible playbooks used to deploy
[LibriVox](https://librivox.org/).

## Scrubbed catalog database

A scrubbed (all personal information removed) catalog database snapshot is
[available](roles/db_import/files/librivox_catalog_scrubbed.sql.bz2). It can
be used as part of a local development environment (see next section) or on its
own by anyone interested.

## Local development environment

These playbooks can set up a local development environment, hereafter called
"localdev". Localdev is a limited version of LibriVox with only the catalog
operational. The forum, wiki, and WordPress blog are installed, but their
databases are empty. The catalog database is the scrubbed one, so while all the
book information is there, the user information is anonymized.

### Prerequisites

* An Ubuntu Jammy 22.04 environment, the target.
* An environment to run these Ansible playbooks in, the executor.
* SSH access to the target from the executor.
* Sudo access in the target.
* Ansible installed on the executor.

Setting up the target and the executor is purposefully left out of scope of
this guide. The most likely scenario is the executor being a laptop or PC, with
the target as a VM or container (LXC works well) on the executor. Other
combinations are possible, including the target and the executor being the same
system, as long as the prerequisites are met.

### Deployment

On the executor, clone this repository:

```
$ git clone https://github.com/librivox/librivox-ansible
$ cd librivox-ansible
```

Edit `inventory.yaml` and replace 192.168.122.12 with the IP address of the target system:

```
localdev:
  hosts:
    192.168.122.12:
```

Run the localdev playbook:

```
$ ansible-playbook -i inventory.yaml localdev.yaml --ask-become-pass
```

Ansible prompts for the BECOME password. Enter the sudo password.

### Access

To access the localdev target from a different environment (for example, from
the executor), the following line needs to be present in that environment's
hosts file (on most Unices including Mac, the hosts file is `/etc/hosts`, on
Windows it's `C:\Windows\System32\drivers\etc\hosts`):

```
192.168.122.12 librivox.org
```

Replace `192.168.122.12` with the IP address of the Ansible target.

### Caveats/disclaimers

* Localdev uses a self-signed TLS certificate. The scary TLS warning is
  expected, and needs to be accepted.
* The forum, wiki, and blog have empty databases, and thus do not work.
* Works:
    * [Search](https://librivox.org/search)
    * Individual books (ex:
      https://librivox.org/dust-of-the-desert-by-robert-welles-ritchie/)
    * [The workflow](https://librivox.org/workflow)
* Does not work:
    * [The home page](https://librivox.org) redirects to the WordPress
      initialization page.
    * [The forum](https://forum.librivox.org/)
    * [The wiki](https://wiki.librivox.org/)

### Development

The librivox-catalog repository is cloned to
`/librivox/www/librivox.org/catalog`.
