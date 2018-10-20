<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$active_group = 'default';
$query_builder = TRUE;

$db['default'] = array(
	'hostname' => 'localhost',
	'username' => 'catalog',
	'password' => '{{ catalog_db_password }}',
	'database' => 'librivox_catalog',
	'dbdriver' => 'mysqli',
);

$db['librivox_forum'] = array(
	'hostname' => 'localhost',
	'username' => 'catalog',
	'password' => '{{ catalog_db_password }}',
	'database' => 'librivox_forum',
	'dbdriver' => 'mysqli',
);

$db['catalog'] = array(
	'hostname' => 'localhost',
	'username' => 'catalog',
	'password' => '{{ catalog_db_password }}',
	'database' => 'librivox_catalog',
	'dbdriver' => 'mysqli',
);

/* End of file database.php */
/* Location: ./application/config/database.php */
