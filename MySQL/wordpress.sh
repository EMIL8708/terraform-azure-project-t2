# Disable SELinux enforcement temporarily
sudo setenforce 0

# Stop the firewalld service
sudo systemctl stop firewalld

# Disable the firewalld service to prevent it from starting on boot
sudo systemctl disable firewalld

# Install the Apache HTTP server
sudo yum install httpd -y

# Start the Apache service
sudo systemctl start httpd

# Enable the Apache service to start on boot
sudo systemctl enable httpd

# Install unzip and wget utilities
sudo yum install unzip wget -y

# Remove the contents of the default web server directory
sudo rm -rf /var/www/html/*

# Download the latest version of WordPress
sudo wget https://wordpress.org/latest.zip

# Unzip the WordPress archive
sudo unzip latest.zip

# Move the extracted WordPress files to the web server's document root
sudo mv wordpress/* /var/www/html/

# Install EPEL repository and yum-utils package
sudo yum install epel-release yum-utils -y

# Install Remi repository for PHP
sudo yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

# Enable Remi repository for PHP 7.3
sudo yum-config-manager --enable remi-php73

# Install PHP and PHP MySQL extension
sudo yum install php php-mysql -y

# Restart the Apache service to apply PHP changes
sudo systemctl restart httpd

# Check the installed PHP version
sudo php --version

# Change ownership of the web server's document root to the Apache user and group
sudo chown -R apache:apache /var/www/html

# Remove the existing WordPress configuration file
sudo rm -f /var/www/html/wp-config.php
