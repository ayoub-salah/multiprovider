#!/bin/bash

# Install Apache
apt-get update
apt-get install -y apache2

# Restart Apache service
systemctl restart apache2

#Change apache index to Hello World + Hostname
echo "<h1>Hello World</h1>" + $(hostname) > /var/www/html/index.html