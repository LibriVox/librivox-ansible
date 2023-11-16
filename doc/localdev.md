# Installing LibriVox locally

## Overview

This cookbook describes how to set up a local LibriVox installation
inside a VirtualBox VM using the `librivox-ansible` GitHub project.

Some parts of the LibriVox installation (files, databases) are made
accessible to the host system using shared folders, to allow the development to
happen on the host machine.

The installation uses the original host names, which will be
overridden in the `/etc/hosts` file on your host system. This means that on
your host system, by entering `https://librivox.org` in the browser, the
requests will be forwarded to your VirtualBox VM.

> **Note:** This guide is not meant to be perfect or finished, but
> helpful. It tries to avoid many of the possible obstacles. If you
> want to improve this document, just edit it and create a pull
> request.

## On the host machine

Requirements: VirtualBox, Git and an IDE.

Assuming a username of `user1` and a workspace directory
of `/home/user1/workspace` create a directory called `librivox`:

    cd /home/user1/workspace/librivox

### Create the VM

* Download and install VirtualBox.
* Download Ubuntu Jammy, server edition
* Create a new VM inside VirtualBox with:
    * 1 GB RAM
    * 50 GB dynamic disk space
    * Bridged networking (change the network type in the settings,
      before the VM is started)
* Install Ubuntu in the VM
    * Choose to install the guest additions
    * Choose to install the OpenSSH server
    * Select all the default feature sets

### Shared Folders

To access the LibriVox files (blog, catalog, forum, wiki) from your
IDE, you need to configure some shared folders in the VirtualBox
machine settings:

| Folder Path                    | Folder Name | Mount Point | Auto-mount | Make Permanent |
|--------------------------------|-------------|-------------|------------|----------------|
| /home/user1/workspace/librivox | librivox    | `<empty>`   | false      | true           |

Shutdown the VM and run the following to enable creation of symbolic links
inside the shared folders:

    VBoxManage setextradata ub-server VBoxInternal2/SharedFoldersEnableSymlinksCreate/librivox 1

where `ub-server` is the name of the Ubuntu machine and `librivox` is
the name of the shared folder.

## On the Guest Machine

> NOTE: Please make sure the following requirements are met before working
> inside the guest machine:
> 1. Network type is set to bridge
> 2. Shared folder is created

### Clone the repository

Install Git and clone the `librivox-ansible` repository:

    sudo apt install git
    git clone https://github.com/librivox/librivox

### Run the installation script

Run the `install-dev.sh` file to install LibriVox on the guest machine. Some of
the commands need `sudo` to run so you will be asked for your password. The
script will install LibriVox inside the guest machine using SSH (i.e., by
accessing localhost using SSH). So, you will be asked to trust the remote (i.e.,
localhost) server.

    cd librivox-ansible
    ./install-dev.sh

The script will prepare the environment for installing LibriVox and make it
accessible to the host system.

### Access LibriVox from the host system

On your host system, edit `/etc/hosts`
or `C:\Windows\System32\drivers\etc\hosts` and add:

    192.168.178.87         librivox.org
    192.168.178.87     dev.librivox.org
    192.168.178.87   forum.librivox.org
    192.168.178.87    wiki.librivox.org
    192.168.178.87     www.librivox.org

Replace `192.168.178.87` with the IP of the LibriVox VM (see `ipaddr`
above).

The database will also be accessible at port 3306 using the same `ipaddr`.

### Summary

You have the LibriVox environment basically running now.
Visit https://librivox.org/search on your host system to check it out.
Most of the LibriVox components don't work yet:

* The blog (https://librivox.org) is an uninitialized WordPress installation,
  with no content.
* The forum and wiki don't work since the database is missing.

# Uninstalling LibriVox

If you want to get rid of the whole local LibriVox installation,
follow these
steps:

* In VirtualBox, remove the virtual machine and all its files
* Uninstall VirtualBox
* Clean up the `hosts` file
