# Installing LibriVox locally

## Overview

This cookbook describes how to set up a local LibriVox installation
inside a VirtualBox VM using the `librivox-ansible` GitHub project.

The development environment is prepared using the Ansible automation
tool. Ansible is given a set of tasks to prepare the environment. In
Ansible, a set of tasks is called a playbook. Most of this guide is
about installing Ansible and also, the steps that could not be automated
using Ansible.

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
of `/home/user1/workspace`:

    cd /home/user1/workspace
    
    # librivox-catalog will be checked out in this directory
    mkdir librivox

    git clone https://github/librivox/librivox-ansible

The directories will then look like this:

    /home/user1/workspace/
    ├── librivox/
    └── librivox-ansible/

### Create the VM

* Download and install VirtualBox.
* Download Ubuntu Xenial, server edition
* Create a new VM inside VirtualBox with:
    * 1 GB RAM
    * 50 GB dynamic disk space
    * Bridged networking (change the network type in the settings,
      before the VM
      is started)
* Install Ubuntu in the VM
    * Select all the default feature sets

## Prepare the Guest Environment

The LibriVox playbook runs most of the tasks as root user. To make
this easy, give your user complete root permissions without password:

    echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$USER"

#### Shared Folders

To access the LibriVox files (blog, catalog, forum, wiki) from your
IDE, you need to configure some shared folders in the VirtualBox
machine settings. But before that, you need to install the VirtualBox Guest
Additions on your VM.

#### Install the Guest Additions

* Insert the Guest Additions ISO into your machine by going to
  Devices > Insert Guest Additions CD Image...
* Mount the CD in the Ubuntu machine and install the guest additions:

      sudo su
      mkdir cdrom
      mount /dev/sr0 cdrom

      cd cdrom
      # * indicates the version of the file which might be different for you
      ./VBOXLinux*.run

#### Create the Shared Folders

Define two shared folders for your VirtualBox machine as follows:

| Folder Path                            | Folder Name      | Mount Point | Auto-mount | Make Permanent |
|----------------------------------------|------------------|-------------|------------|----------------|
| /home/user1/workspace/librivox         | librivox         | `<empty>`   | true       | true           |
| /home/user1/workspace/librivox-ansible | librivox-ansible | `<empty>`   | true       | true           |

Shutdown the VM and run the following to enable creation of symbolic links
inside the shared folders:

    VBoxManage setextradata ub-server VBoxInternal2/SharedFoldersEnableSymlinksCreate/librivox 1

where `ub-server` is the name of the Ubuntu machine and `librivox` is
the name of the shared folder.

Start the VM and add your Ubuntu machine user to the `vboxsf` group, so you have
read and write access to the shared folders:

    sudo usermod -aG vboxsf $USER

Mount the shared folders:

    mount -t vboxsf -o rw,exec,uid=$(id -u),gid=$(id -g),dmode=755,fmode=644 librivox         /librivox
    mount -t vboxsf -o rw,exec,uid=$(id -u),gid=$(id -g),dmode=755,fmode=644 librivox-ansible /librivox-ansible

> NOTE: mounting the shared folders using /etc/fstab only works on the
> latest version of Ubuntu and not on Xenial. That's why we're doing it manually
> here.

#### Disable IPv6

From inside the VM, run:

    ping6 www.google.com

If that fails, you can skip to the next section. Otherwise, you need
to disable
IPv6:

    echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.d/01-disable-ipv6.conf
    reboot

#### Additional packages

    sudo su -
    apt update
    apt upgrade
    apt install git gcc make perl python tar bzip2 python-cryptography python-paramiko python-yaml python-jinja2
    exit

#### Ansible

LibriVox requires Ansible >= 2.4, while Ubuntu Xenial comes with 2.0.
Therefore, install Ansible from source.

    mkdir git
    cd git
    git clone https://github.com/ansible/ansible
    cd ansible
    git checkout v2.5.0
    python setup.py build
    python setup.py install --user
    ansible --version

#### Create hosts for Ansible

    cd /librivox-ansible
    ipaddr=$(ifconfig | perl -ne 'printf("%s\n", $1) if /^\s+inet addr:\s*(\S+)/ && $1 ne "127.0.0.1"')
    printf '[localdev]\n%s\n' "$ipaddr" > hosts

Do not let Git overwrite the local changes when updating:

    perl -i -pe '
        s/force: yes/force: no/ if $module eq "git";
        $module = $1 if /^  (\w+)/;
        ' */*/tasks/main.yml

#### Run the SSH Server

Enable and start the SSH server using:

    sudo systemctl enable sshd
    sudo systemctl start sshd

Generate an SSH key and upload it:

    # follow throw the steps without entering anything
    ssh-keygen

    # $USER is your username, $ipaddr is the ip of the VirtualBox
    ssh-copy-id -i .ssh/id_rsa $USER@$ipaddr

#### Run the Ansible playbook

    ansible-playbook -i hosts localdev.yml 

#### Set up developer account for MySQL

To browse the LibriVox databases from the IDE, add a MySQL user:

    sudo mysql
    grant all privileges on *.* to `librivox`@`%` identified by 'librivox';

#### Initialize the catalog database

    bzip2 -d -k resources/librivox_catalog_scrubbed.sql.bz2
    mysql -ulibrivox -plibrivox -e 'CREATE DATABASE librivox_catalog'
    mysql -ulibrivox -plibrivox librivox_catalog < resources/librivox_catalog_scrubbed.sql.bz2

#### Update MySQL's bind-address

Uncomment and update the value of bind-address
in `/etc/mysql/mariadb.conf.d/50-server.cnf` to `ipaddr` of the VM. Then restart
MySQL using `sudo systemctl restart mysql` so you can access the VM database
from the host system.

#### Access LibriVox from the host system

On your host system, edit `/etc/hosts`
or `C:\Windows\System32\drivers\etc\hosts` and add:

    192.168.178.87         librivox.org
    192.168.178.87     dev.librivox.org
    192.168.178.87   forum.librivox.org
    192.168.178.87    wiki.librivox.org
    192.168.178.87     www.librivox.org

Replace `192.168.178.87` with the IP of the LibriVox VM (see `ipaddr`
above). You should now be able to browse your local installation of LibriVox
by visiting https://librivox.org.

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
