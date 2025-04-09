<!DOCTYPE html>
<html>
<head><title>CRUD PHP</title></head>
<body>
    <h1>Usuários</h1>
    <form action="create.php" method="POST">
        Nome: <input type="text" name="name" required>
        Email: <input type="email" name="email" required>
        <button type="submit">Adicionar</button>
    </form>

    <h2>Lista de usuários</h2>
    <?php
    include 'db.php';
    $result = $conn->query("SELECT * FROM users");

    while($row = $result->fetch_assoc()) {
        echo "<p>{$row['name']} - {$row['email']} 
              <a href='update.php?id={$row['id']}'>Editar</a> 
              <a href='delete.php?id={$row['id']}'>Excluir</a></p>";
    }
    ?>
</body>
</html>
