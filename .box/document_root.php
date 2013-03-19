<?php

# get domain parts
$path = explode('.', $_SERVER['HTTP_HOST']);

# remove static suffix
$path = array_slice($path, 0, count($path) - 1);

# magic stuff happens, kinda oO
if(count($path) < 3) {
	$path = implode('.', $path);
} else {
	$path = implode('.', array_slice($path, -2, 2)) . '-' . implode('.', array_slice($path, 0, count($path) - 2));
}

# set new documment root
$_SERVER['DOCUMENT_ROOT'] .= $path;

# clean up
unset($path);
