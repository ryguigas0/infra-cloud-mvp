<?php
$host = 'db';
$user = 'user';
$pass = 'password';
$db = 'crud_db';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}
?>
