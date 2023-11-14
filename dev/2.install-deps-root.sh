#!/bin/bash

source .env

printf '%s	ALL=(ALL:ALL)	NOPASSWD:	ALL' "$user" > /etc/sudoers.d/$user

apt install virtualbox-guest-dkms openssh-server unzip gcc make perl tar bzip2 \
    python python-setuptools python-cryptography python-paramiko python-yaml python-jinja2

mkdir -p /librivox

mount -t vboxsf -o rw,exec,uid=$uid,gid=$gid,dmode=755,fmode=644 librivox         /librivox
#mount -t vboxsf -o rw,exec,uid=$uid,gid=$gid,dmode=755,fmode=644 librivox-ansible $rootdir


