<?php

$cfg['DefaultLang'] = 'de';
$cfg['ServerDefault'] = 1;
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
$cfg['CheckConfigurationPermissions'] = false;
$cfg['PmaNoRelation_DisableWarning'] = true;
$cfg['McryptDisableWarning'] = true;
$cfg['UserprefsDeveloperTab'] = true;
$cfg['Error_Handler']['display'] = true;
$cfg['NumRecentTables'] = 100;
$cfg['MaxRows'] = 100;

/* Server: localhost [1] */
$cfg['Servers'][1]['verbose'] = 'localhost';
$cfg['Servers'][1]['host'] = 'localhost';
$cfg['Servers'][1]['port'] = '';
$cfg['Servers'][1]['socket'] = '';
$cfg['Servers'][1]['connect_type'] = 'tcp';
$cfg['Servers'][1]['extension'] = 'mysqli';
$cfg['Servers'][1]['nopassword'] = true;
$cfg['Servers'][1]['auth_type'] = 'config';
$cfg['Servers'][1]['user'] = 'root';
$cfg['Servers'][1]['password'] = '';
$cfg['Servers'][1]['hide_db'] = '(information_schema|performance_schema|phpmyadmin|mysql|test)';
$cfg['Servers'][1]['AllowNoPassword'] = true;

?>
