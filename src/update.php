<?php
include 'db.php';

$id = $_GET['id'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $conn->query("UPDATE users SET name='$name', email='$email' WHERE id=$id");
    header("Location: index.php");
    exit();
}

$result = $conn->query("SELECT * FROM users WHERE id=$id");
$row = $result->fetch_assoc();
?>

<form method="POST">
    Nome: <input type="text" name="name" value="<?= $row['name'] ?>" required>
    Email: <input type="email" name="email" value="<?= $row['email'] ?>" required>
    <button type="submit">Atualizar</button>
</form>
