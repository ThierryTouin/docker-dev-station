<?php

$databases['default']['default'] = array (
  'database' => getenv('POSTGRES_DB'),
  'username' => getenv('POSTGRES_USER'),
  'password' => getenv('POSTGRES_PASSWORD'),
  'host' => getenv('POSTGRES_HOST'),
  'port' => '5432',
  'driver' => 'pgsql',
  'prefix' => '',
);

$settings['install_profile'] = 'standard';

// Autres configurations supplémentaires
$settings['hash_salt'] = 'SOME_RANDOM_HASH_SALT';
$settings['update_free_access'] = FALSE;
$config_directories = array();
