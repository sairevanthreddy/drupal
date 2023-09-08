#!/bin/bash

# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -q $1
}

# Check if Apache is installed
if ! is_installed apache2; then
    echo "Installing Apache..."
    sudo apt-get update -y
    sudo apt-get install apache2 -y
    systemctl start apache2
    systemctl enable apache2
else
    echo "Apache is already installed."
fi

# Check if PHP is installed
if ! is_installed php; then
    echo "Installing PHP..."
    sudo apt-get update -y
    sudo apt-get install php -y
else
    echo "PHP is already installed."
fi

# Check if MySQL is installed
if ! is_installed mysql-server; then
    echo "Installing MySQL..."
    sudo apt-get update -y
    sudo apt-get install mysql-server -y
    mysql -u root -e 'CREATE DATABASE wordpress;'
    mysql -u root -e 'CREATE USER wordpress@localhost IDENTIFIED BY "revanth24";'
    mysql -u root -e 'GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost;'
    mysql -u root -e 'FLUSH PRIVILEGES;'
    mysql -u root -e 'quit'
else
    echo "MySQL is already installed."
fi

# Check if drupal.conf file exists in /etc/apache2/sites-available/
if [ ! -f /etc/apache2/sites-available/drupal.conf ]; then
    echo "Copying drupal.conf file..."
    sudo cp /var/www/html/drupal/drupal.conf /etc/apache2/sites-available/
    sudo a2ensite drupal.conf
    sudo systemctl reload apache2
else
    echo "drupal.conf file already exists in /etc/apache2/sites-available/"
fi
