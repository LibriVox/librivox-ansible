<?php

$config = array(
	'protocol'    => 'smtp',
	'smtp_host'   => 'mail.smtp2go.com',
	'smtp_port'   => 2525,
    'smtp_crypto' => 'tls',
	'smtp_user'   => '{{ codeigniter_smtp_username }}',
	'smtp_pass'   => '{{ codeigniter_smtp_password }}',
);
