#!/bin/bash

echo "🚀 Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "📦 Instalando Apache..."
sudo apt install apache2 -y

echo "🐘 Instalando PHP e extensão mysqli para MySQL..."
sudo apt install php php-mysqli libapache2-mod-php -y

echo "🔁 Reiniciando Apache..."
sudo systemctl restart apache2

echo "✅ Instalação concluída!"
echo "Acesse http://localhost no seu navegador para verificar o Apache."
php -v
