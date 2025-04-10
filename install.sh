#!/bin/bash

DB_NAME="meubanco"
DB_USER="meuusuario"
DB_PASSWORD="senhaSegura123"
WWW_DIR="/var/www/html"

echo "🚀 Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "📦 Instalando Apache..."
sudo apt install apache2 -y

echo "🐘 Instalando PHP e extensão mysqli para MySQL..."
sudo apt install php php-mysqli libapache2-mod-php -y

echo "🐬 Instalando MySQL Server..."
sudo apt install mysql-server -y

echo "🔧 Instalando Git..."
sudo apt install git -y

echo "🔒 Rodando mysql_secure_installation (modo automático simplificado)..."
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$DB_PASSWORD'; FLUSH PRIVILEGES;"

echo "🛠️ Criando banco de dados e tabela..."
sudo mysql -uroot -p$DB_PASSWORD <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
USE $DB_NAME;
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
EOF

echo "📁 Baixando arquivos PHP do repositório..."
sudo curl -o $WWW_DIR/create.php https://raw.githubusercontent.com/ryguigas0/infra-cloud-mvp/refs/heads/master/src/create.php
sudo curl -o $WWW_DIR/delete.php https://raw.githubusercontent.com/ryguigas0/infra-cloud-mvp/refs/heads/master/src/delete.php
sudo curl -o $WWW_DIR/db.php https://raw.githubusercontent.com/ryguigas0/infra-cloud-mvp/refs/heads/master/src/db.php
sudo curl -o $WWW_DIR/update.php https://raw.githubusercontent.com/ryguigas0/infra-cloud-mvp/refs/heads/master/src/update.php
sudo curl -o $WWW_DIR/index.php https://raw.githubusercontent.com/ryguigas0/infra-cloud-mvp/refs/heads/master/src/index.php

echo "🔐 Exportando variáveis de ambiente no Apache..."
echo "\n# Variáveis do banco de dados" | sudo tee -a /etc/apache2/envvars
echo "export DB_NAME=\"$DB_NAME\"" | sudo tee -a /etc/apache2/envvars
echo "export DB_USER=\"$DB_USER\"" | sudo tee -a /etc/apache2/envvars
echo "export DB_PASSWORD=\"$DB_PASSWORD\"" | sudo tee -a /etc/apache2/envvars

sudo chown www-data:www-data $WWW_DIR/*.php

echo "🔁 Reiniciando Apache..."
sudo systemctl restart apache2

echo "✅ Instalação concluída!"
echo "Acesse http://localhost no seu navegador para verificar o Apache."
php -v
