<?php

CONST SCHEMA = 'schema';
CONST FUNCTIONS = 'function';
CONST OUTPUT_FILE_NAME = "upgrade.sql";
CONST OMMITED_NAMES =  [".", ".."];
CONST EXTENSION = "sql";

$functionFiles = array_diff(scandir('./' . FUNCTIONS), OMMITED_NAMES);
$files = array_diff(scandir('./' . SCHEMA), OMMITED_NAMES);

try {
    $upgradeFile = fopen(OUTPUT_FILE_NAME, "w");
} catch(Exception $e) {
    throw new Error("Error while creating upgrade.sql file. Error msg: " . $e->getMessage());
} 

if($upgradeFile) {    
    foreach($files as $file) {
        $extension = pathinfo($file, PATHINFO_EXTENSION);
        if($extension === EXTENSION) {
            $content = file_get_contents('./' . SCHEMA . '/' . $file);
            file_put_contents(OUTPUT_FILE_NAME, PHP_EOL . "--" . $file . PHP_EOL,FILE_APPEND);
            file_put_contents(OUTPUT_FILE_NAME, PHP_EOL . $content,FILE_APPEND);
        }
    }

    foreach ($functionFiles as $file) {
        $extension = pathinfo($file, PATHINFO_EXTENSION);
        if($extension === EXTENSION) {
            $content = file_get_contents('./' . FUNCTIONS . '/' . $file);
            file_put_contents(OUTPUT_FILE_NAME, PHP_EOL . "--" . $file . PHP_EOL,FILE_APPEND);
            file_put_contents(OUTPUT_FILE_NAME, PHP_EOL . $content,FILE_APPEND);
        }
    }
}

