<?php
$dbms = 'phpbb\\db\\driver\\mysqli';
$dbhost = 'localhost';
$dbport = '';
$dbname = 'librivox_forum';
$dbuser = 'librivox_forum';
$dbpasswd = '{{ forum_db_password }}';
$table_prefix = 'ngo_';
$phpbb_adm_relative_path = 'adm/';
$acm_type = 'phpbb\\cache\\driver\\memcached';
@define('PHPBB_INSTALLED', true);
?>
