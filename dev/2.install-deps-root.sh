#!/bin/bash

uid=$(id -u)
if [[ $uid -ne 0 ]] 
then
  echo "[ERROR] please run this script as the root user"
  exit;
fi

source .env

printf '%s	ALL=(ALL:ALL)	NOPASSWD:	ALL' "$user" > /etc/sudoers.d/$user
echo "[DONE] added rule so user can run sudo without password"

apt install virtualbox-guest-dkms openssh-server unzip gcc make perl tar bzip2 \
    python python-setuptools python-cryptography python-paramiko python-yaml python-jinja2

echo "creating /librivox directory"
mkdir -p /librivox

echo "mounting shared folders"
mount -t vboxsf -o rw,exec,uid=$uid,gid=$gid,dmode=755,fmode=644 librivox         /librivox

echo "[DONE] now exit the root user and run the next script"