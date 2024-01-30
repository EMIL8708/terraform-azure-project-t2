#!/bin/bash

# Disable SELinux
sudo setenforce 0

# Install Apache and MySQL
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

sudo yum install mysql-server -y
sudo systemctl start mysqld
sudo systemctl enable mysqld

# Install WGET and Unzip
sudo yum install wget unzip -y

# Download and extract website template
wget https://www.free-css.com/assets/files/free-css-templates/download/page296/finexo.zip
unzip finexo.zip
mv finexo-html/* /var/www/html/

# Install PHP 7.3
sudo yum install epel-release yum-utils -y