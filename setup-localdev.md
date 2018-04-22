# Installing LibriVox locally

## Overview

This cookbook describes how to set up a local LibriVox installation
inside a VirtualBox VM using the `librivox-ansible` GitHub project.

Some parts of the LibriVox installation (files, databases) are made
accessible to the host system, to allow the development to happen
on the host machine.

The installation uses the original host names, which will be overridden
in the `hosts` file. This is because the whole setup currently has these
host names hardcoded.

Note: This guide is not meant to be perfect or finished, but helpful.
It tries to avoid many of the possible obstacles. 
If you want to improve this document, just edit it and send a pullup
request.

## VirtualBox

Download and install VirtualBox 5.2.8.

## Ubuntu

* Download Ubuntu Xenial, server edition
* Create a new VM inside VirtualBox:
    * 1 GB RAM
    * 50 GB dynamic disk space
    * Bridged networking
* Install Ubuntu in that VM
    * Select all feature sets

## Easy root privileges

The LibriVox playbook runs most of the tasks as root user.
To make this easy, give your user complete root permissions without password.
After all, this is just in a virtual machine in a private environment,
so convenience is more important than security.

    echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$USER"

## Disable IPv6

From inside the VM, run:

    ping6 www.google.com

If that works, skip the rest of this section.
But if you get a network timeout, disable IPv6 networking:

    echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.d/01-disable-ipv6.conf
    reboot

## Additional packages

    sudo su -
    apt update
    apt upgrade
    apt install git gcc make perl python
    exit

## Ansible

LibriVox requires Ansible >= 2.4, while Ubuntu comes with 2.0.
Therefore, install Ansible from source.

    mkdir git
    cd git
    git clone https://github.com/ansible/ansible
    cd ansible
    python setup.py build
    python setup.py install --user
    ansible --version

## Adjust LibriVox playbook for local development

    cd git
    git clone https://github.com/librivox/librivox-ansible
    cd librivox-ansible

    ipaddr=$(ifconfig | perl -ne 'printf("%s\n", $1) if /^\s+inet addr:\s*(\S+)/ && $1 ne "127.0.0.1"')
    printf '[server]\n%s\n' "$ipaddr" > hosts/localdev/hosts

Do not let Git overwrite the local changes when updating:

    perl -i -pe '
        s/force: yes/force: no/ if $module eq "git";
        $module = $1 if /^  (\w+)/;
        ' */*/tasks/main.yml

## Let the playbook run

Change the URL for the Advanced Custom Fields plugin for WordPress,
since you probably don't have a pro key:

*   Replace `https://connect.advanced`...
*   With `https://downloads.wordpress.org/plugin/advanced-custom-fields.4.4.12.zip`

Then:

    ansible deploy.yml -i hosts/localdev/hosts

## Generate a self-signed certificate

https://stackoverflow.com/a/21494483

    [ alternate_names ]
    DNS.1 =         librivox.org
    DNS.2 =     dev.librivox.org
    DNS.3 =   forum.librivox.org
    DNS.4 =    wiki.librivox.org
    DNS.5 =     www.librivox.org

Install it in:

    SSLCertificateFile /etc/letsencrypt/live/librivox.org/cert.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/librivox.org/privkey.pem
    SSLCACertificateFile /etc/letsencrypt/live/librivox.org/chain.pem

Also in:

    SSLCertificateFile /librivox/tls/STAR_librivox_org.crt
    SSLCertificateKeyFile /librivox/tls/STAR_librivox_org.key
    SSLCACertificateFile /librivox/tls/STAR_librivox_org.ca-bundle

On the host, register this certificate as a root certificate.

## Access LibriVox from the host system

In `/etc/hosts` or `C:\Windows\System32\drivers\etc\hosts`, add:

    192.168.178.87         librivox.org
    192.168.178.87     dev.librivox.org
    192.168.178.87   forum.librivox.org
    192.168.178.87    wiki.librivox.org
    192.168.178.87     www.librivox.org

Replace `192.168.178.87` with the IP of the LibriVox VM (see `ipaddr` above).

### Set up developer account for MySQL

To browse the LibriVox databases from the IDE, add a MySQL user:
 
    sudo mysql
    grant all privileges on *.* to `librivox`@`%` identified by 'librivox';

### Initialize the catalog database

    mysql -ulibrivox -plibrivox -e 'CREATE DATABASE librivox_catalog'
    mysql -ulibrivox -plibrivox librivox_catalog < roles/blog+catalog/files/librivox_catalog.schema.sql

### Share folders

To access the LibriVox files (blog, catalog, forum, wiki) from the IDE,
configure some shared folders in the VirtualBox machine settings.

    # TODO
    mount /mnt/sf_/... /librivox

### Summary

You have the LibriVox environment basically running now.
Visit https://librivox.org/ to check it out.
Most of the LibriVox components don't work yet:

* The blog is an uninitialized WordPress installation, with no content.
* The catalog is empty, so searching will always result in "No result".
* The forum doesn't work since the database is missing.
* The wiki doesn't work since the database is missing.

As said above, this guide is not yet finished. But it's better than nothing.

# Deinstall LibriVox

If you want to get rid of the whole local LibriVox installation, follow these steps:
 
* In VirtualBox, remove the virtual machine and all its files
* Deinstall VirtualBox
* Clean up the `hosts` file
* Remove the certificate from the trust store
