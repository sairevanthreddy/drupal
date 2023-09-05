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
else
    echo "MySQL is already installed."
fi
