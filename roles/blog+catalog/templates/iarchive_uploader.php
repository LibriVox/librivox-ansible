<?php                                                                                           

// these can be reset at: http://archive.org/account/s3.php

//make this config ['iarchive_uploader'] so we can just grab $config['ias3uploader'] to pass to library
$config['iarchive_uploader']['access_key'] = '{{ iarchive_uploader_access_key }}';
$config['iarchive_uploader']['secret_key'] = '{{ iarchive_uploader_secret_key }}';

//if there is a direct iarchive alias, let's use that in case the s3 link changes
$config['iarchive_uploader']['amazon_endpoint'] = 'http://s3.us.archive.org';

// iarchive project page
$config['iarchive_uploader']['iarchive_project_page'] = 'https://archive.org/details';
