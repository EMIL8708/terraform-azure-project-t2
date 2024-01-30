#!/bin/bash 
sudo apt update
sudo apt install apache2 \
              ghostscript \
              libapache2-mod-php \
              mysql-server \
              php \
              php-bcmath \
              php-curl \
              php-imagick \
              php-intl \
              php-json \
              php-mbstring \
              php-mysql \
              php-xml \
              php-zip -y 

# Create the installation directory and download the file from WordPress.org:
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
# Install MySQL
sudo apt install mysql-server -y
# Install PHP
sudo apt install php libapache2-mod-php php-mysql -y