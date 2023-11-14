#!/bin/bash

source .env

cd $rootdir || exit

ipaddr=$(ifconfig | perl -ne 'printf("%s\n", $1) if /^\s+inet addr:\s*(\S+)/ && $1 ne "127.0.0.1"')
printf '[localdev]\n%s\n' "$ipaddr" > hosts

cd ~ || exit

wget https://github.com/ansible/ansible/archive/refs/heads/stable-2.5.zip
unzip stable-2.5.zip

cd ansible-stable-2.5 || exit
python setup.py build
python setup.py install --user

ssh-keygen -N '' -f $HOME/.ssh/id_rsa
cp $HOME/.ssh/{id_rsa,authorized_keys}

cd $rootdir
ansible-playbook -i hosts localdev.yaml

