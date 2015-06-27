<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$active_group = 'default';
$active_record = TRUE;

$db['default']['hostname'] = 'localhost';
$db['default']['username'] = 'catalog';
$db['default']['password'] = '{{ catalog_db_password.stdout }}';
$db['default']['database'] = 'librivox_catalog';
$db['default']['dbdriver'] = 'mysql';
$db['default']['dbprefix'] = '';
$db['default']['pconnect'] = TRUE;
$db['default']['db_debug'] = TRUE;
$db['default']['cache_on'] = FALSE;
$db['default']['cachedir'] = '';
$db['default']['char_set'] = 'utf8';
$db['default']['dbcollat'] = 'utf8_general_ci';
$db['default']['swap_pre'] = '';
$db['default']['autoinit'] = TRUE;
$db['default']['stricton'] = FALSE;

$db['catalog']['hostname'] = 'localhost';
$db['catalog']['username'] = 'catalog';
$db['catalog']['password'] = '{{ catalog_db_password.stdout }}';
$db['catalog']['database'] = 'librivox_catalog';
$db['catalog']['dbdriver'] = 'mysql';
$db['catalog']['dbprefix'] = '';
$db['catalog']['pconnect'] = TRUE;
$db['catalog']['db_debug'] = TRUE;
$db['catalog']['cache_on'] = FALSE;
$db['catalog']['cachedir'] = '';
$db['catalog']['char_set'] = 'utf8';
$db['catalog']['dbcollat'] = 'utf8_general_ci';
$db['catalog']['swap_pre'] = '';
$db['catalog']['autoinit'] = TRUE;
$db['catalog']['stricton'] = FALSE;

$db['librivox_forum']['hostname'] = 'localhost';
$db['librivox_forum']['username'] = 'catalog';
$db['librivox_forum']['password'] = '{{ catalog_db_password.stdout }}';
$db['librivox_forum']['database'] = 'librivox_forum';
$db['librivox_forum']['dbdriver'] = 'mysql';
$db['librivox_forum']['dbprefix'] = '';
$db['librivox_forum']['pconnect'] = TRUE;
$db['librivox_forum']['db_debug'] = TRUE;
$db['librivox_forum']['cache_on'] = FALSE;
$db['librivox_forum']['cachedir'] = '';
$db['librivox_forum']['char_set'] = 'utf8';
$db['librivox_forum']['dbcollat'] = 'utf8_general_ci';
$db['librivox_forum']['swap_pre'] = '';
$db['librivox_forum']['autoinit'] = TRUE;
$db['librivox_forum']['stricton'] = FALSE;

/* End of file database.php */
/* Location: ./application/config/database.php */
