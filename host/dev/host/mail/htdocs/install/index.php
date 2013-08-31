<?php

$return = 0;

if(!file_exists('install.lock')) {
	exec('phing -f ../../install.xml', $output, $return);
}

if($return > 0) {
	var_dump($output);
} else {
	touch('install.lock');
	header('Location: ..');
}
