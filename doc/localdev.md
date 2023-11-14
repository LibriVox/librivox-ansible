# Installing LibriVox locally

## Overview

This cookbook describes how to set up a local LibriVox installation
inside a VirtualBox VM using the `librivox-ansible` GitHub project.

Some parts of the LibriVox installation (files, databases) are made
accessible to the host system using shared folders, to allow the development to
happen on the host machine.

After you have successfully set up the development environment, once you reboot
the VM, the only part of this guide you need to repeat is mount the shared
folders. There is no need to run any of the other steps since the code is
already served by Apache inside the VM.

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
* Download Ubuntu Xenial, server edition
* Create a new VM inside VirtualBox with:
    * 1 GB RAM
    * 50 GB dynamic disk space
    * Bridged networking (change the network type in the settings,
      before the VM is started)
* Install Ubuntu in the VM
    * Select all the default feature sets

#### Shared Folders

To access the LibriVox files (blog, catalog, forum, wiki) from your
IDE, you need to configure some shared folders in the VirtualBox
machine settings:

| Folder Path                    | Folder Name | Mount Point | Auto-mount | Make Permanent |
|--------------------------------|-------------|-------------|------------|----------------|
| /home/user1/workspace/librivox | librivox    | `<empty>`   | true       | true           |

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
> 3. You have set the flag on the shared folder for creation of symlinks

#### Disable IPv6

From inside the VM, run:

    ping6 www.google.com

If that fails, you can skip to the next section. Otherwise, you need
to disable
IPv6:

    echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.d/01-disable-ipv6.conf
    reboot

#### Clone the repository

Switch to the root user, install Git and exit to the normal user:

    sudo su
    apt install git
    exit

Inside your home directory clone the `librivox-ansible` repository:

    git clone https://github.com/librivox/librivox

#### Run the scripts

Switch to the `librivox-ansible/dev` directory and run the scripts one by one in
the numbered order. These scripts will prepare the environment so Ansible can be
installed. After which, the scripts will run the Ansible playbook that
will install LibroVox on the guest machine.

Some of the scripts have the name `root` in them. These need to be run by the
root user (`su root`). For the other scripts, you need to exit root and run the
script as the normal user.

    cd librivox-ansible/dev
    ./1-[script-name].sh
    ./2-[script-name].sh
    ./3-[script-name].sh
    ./4-[script-name].sh

You shouldn't see any errors while running the scripts. A few warnings might be
about old libraries which is OK.

#### Access LibriVox from the host system

On your host system, edit `/etc/hosts`
or `C:\Windows\System32\drivers\etc\hosts` and add:

    192.168.178.87         librivox.org
    192.168.178.87     dev.librivox.org
    192.168.178.87   forum.librivox.org
    192.168.178.87    wiki.librivox.org
    192.168.178.87     www.librivox.org

Replace `192.168.178.87` with the IP of the LibriVox VM (see `ipaddr`
above).

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
