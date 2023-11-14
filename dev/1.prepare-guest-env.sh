#!/bin/bash
echo "enter the name of the VirtualBox VM:"
read -r vbname

printf 'vbname=%s\n' $vbname > .env
printf 'user=%s\n' "$USER" >> .env
printf 'uid=%s\n' "$(id -u)" >> .env
printf 'gid=%s\n' "$(id -g)" >> .env
printf 'rootdir=%s\n' $(git rev-parse --show-toplevel) >> .env

echo "environment file created"

