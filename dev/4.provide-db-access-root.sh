#!/bin/bash

uid=$(id -u)
if [[ $uid -ne 0 ]] 
then
  echo "[ERROR] please run this script as the root user"
  exit;
fi

source .env

cd ~ || exit

su mysql -c "grant all privileges on *.* to \\\`librivox\\\`@\\\`%\\\` identified by 'librivox'";

bzip2 -d -k $rootdir/resources/librivox_catalog_scrubbed.sql.bz2
mysql -ulibrivox -plibrivox -e 'CREATE DATABASE librivox_catalog'
mysql -ulibrivox -plibrivox librivox_catalog < $rootdir/resources/librivox_catalog_scrubbed.sql
echo "[DONE] database populated"

sed -i "s/bind-address.*/bind-address = $ipaddr/" /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mysql

echo "[DONE] you should now be able to access the database from your host system"
