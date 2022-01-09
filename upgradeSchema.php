<?php

const HOST = 'localhost';
const PORT = '5432';
const DB_NAME = 'admin';
const USERNAME = 'admin';
const PASSWORD = 'admin';
const CONN_STRING = "host=" . HOST . " port=" . PORT . " dbname=" . DB_NAME . " user=" . USERNAME . " password=" . PASSWORD; 

const SQL_FILE = 'upgrade.sql';


$pgConnect = pg_connect(CONN_STRING);

if($pgConnect) {

    $query = file_get_contents('./' . SQL_FILE);

    pg_query($query);

    pg_close($pgConnect); 
}
