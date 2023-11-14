#!/bin/bash

uid=$(id -u)
if [[ $uid -eq 0 ]] 
then
  echo "[ERROR] please run this script as a normal user"
  exit;
fi

devdir=$PWD
rootdir=$(git rev-parse --show-toplevel)
ipaddr=$(ifconfig | perl -ne 'printf("%s\n", $1) if /^\s+inet addr:\s*(\S+)/ && $1 ne "127.0.0.1"')

printf 'vbname=%s\n' "$hostname" > .env
printf 'user=%s\n' "$USER" >> .env
printf 'uid=%s\n' "$(id -u)" >> .env
printf 'gid=%s\n' "$(id -g)" >> .env
printf 'devdir=%s\n' "$devdir" >> .env
printf 'rootdir=%s\n' "$rootdir" >> .env
printf 'ipaddr=%s\n' "$ipaddr" >> .env

echo "environment file created"
cat '.env'

cd $rootdir || exit
printf '[localdev]\n%s\n' "$ipaddr" > hosts

echo "hosts file created"
cat 'hosts'

echo "now switch to the root user (su root) and run the next script"
