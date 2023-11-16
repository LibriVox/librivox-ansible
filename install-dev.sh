#!/bin/bash

set -e

uid=$(id -u)
if [[ $uid -eq 0 ]] 
then
  echo "[ERROR] please run this script as a normal user"
  exit;
fi

user=$USER
gid=$(id -g)
rootdir=$(git rev-parse --show-toplevel)

echo "ip address:"
ipaddr=$(ip route get to 8.8.8.8 | awk '{print $(NF-2);exit}')
printf '[localdev]\n%s\n' "$ipaddr" | tee hosts

sudo printf '%s	ALL=(ALL:ALL)	NOPASSWD:	ALL' "$user" | sudo tee /etc/sudoers.d/$user > /dev/null

echo ""
echo "installing dependencies"
sudo apt install -y ansible bzip2

echo ""
echo "disabling ipv6"
sudo echo 'net.ipv6.conf.all.disable_ipv6 = 1' | sudo tee /etc/sysctl.d/01-disable-ipv6.conf > /dev/null
sudo sysctl -q --system 2>/dev/null

echo ""
echo "mounting shared folders"
sudo mkdir -p /librivox
sudo mount -t vboxsf -o rw,exec,uid=$uid,gid=$gid,dmode=755,fmode=644 librivox /librivox

cd ~ || exit

echo ""
echo "generating SSH key"
if [[ ! -e "$HOME/.ssh/id_rsa.pub" ]]; then
  ssh-keygen -N '' -f "$HOME"/.ssh/id_rsa
fi 
ssh-keyscan "$ipaddr" >> "$HOME/.ssh/known_hosts"
cp "$HOME"/.ssh/{id_rsa.pub,authorized_keys}

cd "$rootdir" || exit

echo ""
echo "running Ansible playbook"
ansible-playbook -i hosts dev.yaml

echo "[DONE] LibriVox is now installed and should be accessible from https://librivox.org"

echo "populating database"
sudo mysql -e "grant all privileges on *.* to 'librivox'@'%' identified by 'librivox'"

bzip2 -fdk resources/librivox_catalog_scrubbed.sql.bz2
mysql -ulibrivox -plibrivox -e 'CREATE DATABASE IF NOT EXISTS librivox_catalog'
mysql -ulibrivox -plibrivox librivox_catalog < resources/librivox_catalog_scrubbed.sql
echo "[DONE] database populated"

sudo sed -i "s/bind-address.*/bind-address = $ipaddr/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mysql
sudo systemctl restart php8.1-fpm
sudo systemctl restart sphinxsearch
sudo systemctl restart apache2

echo "[DONE] database should now be accessible from host"
