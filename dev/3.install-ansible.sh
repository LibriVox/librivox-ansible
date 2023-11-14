#!/bin/bash

uid=$(id -u)
if [[ $uid -eq 0 ]] 
then
  echo "[ERROR] please run this script as a normal user"
  exit;
fi

source .env

cd ~ || exit

echo "downloading Ansible 2.5"
wget https://github.com/ansible/ansible/archive/refs/heads/stable-2.5.zip
unzip stable-2.5.zip

cd ansible-stable-2.5 || exit
python setup.py build
python setup.py install --user

echo "generating ssh key and uploading to localhost"
ssh-keygen -N '' -f $HOME/.ssh/id_rsa
cp $HOME/.ssh/{id_rsa,authorized_keys}

cd $rootdir || exit

echo "running Ansible playbook"
echo "type 'yes' if you are asked to trust the remote server"
ansible-playbook -i hosts localdev.yaml

echo "[DONE] LibriVox is now installed and should be accessible from https://librivox.org"