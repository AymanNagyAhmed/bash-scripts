#!/bin/bash

# Exit on error
set -e

echo "Starting Nest.js droplet setup..."

# Update system packages
echo "Updating system packages..."
apt-get update
apt-get upgrade -y

# Install essential tools
echo "Installing essential tools..."
apt-get install -y \
    curl \
    git \
    wget \
    build-essential \
    nginx \
    certbot \
    python3-certbot-nginx

# Install Node.js and npm
echo "Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
apt-get install -y nodejs

# Install PM2 globally
echo "Installing PM2..."
npm install -g pm2

# Install Nest.js CLI globally
echo "Installing Nest.js CLI..."
npm install -g @nestjs/cli


# Install Nest.js CLI and Prisma globally
echo "Installing Nest.js CLI and Prisma..."
npm install -g @nestjs/cli prisma

# Install MySQL server
echo "Installing MySQL server..."
apt-get install mysql-server -y

# Install MySQL client
echo "Installing MySQL client..."
apt-get install mysql-client -y

# Enable and start MySQL
echo "Enabling and starting MySQL..."
sudo systemctl enable mysql
sudo systemctl start mysql

# Secure MySQL installation
# echo "Securing MySQL installation..."
# sudo mysql_secure_installation

# Restart MySQL
echo "Restarting MySQL..."
sudo systemctl restart mysql

# Install and configure password validation plugin
echo "Configuring MySQL password validation..."
mysql -u root -p <<EOF
INSTALL PLUGIN validate_password SONAME 'validate_password.so';
SET GLOBAL validate_password_policy = 'LOW';
EOF

# Create a new MySQL user and grant privileges
echo "Creating a new MySQL user..."
mysql -u root -p <<EOF
CREATE USER 'admin'@'*' IDENTIFIED WITH mysql_native_password BY '@12345Admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'*' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Create a new database
echo "Creating a new database..."
mysql -u root -p -e "CREATE DATABASE nextjs_app_db;"

# Grant all privileges on the new database to the new user
echo "Granting all privileges on the new database to the new user..."
mysql -u root -p -e "GRANT ALL PRIVILEGES ON nextjs_app_db.* TO 'admin'@'*';"

# Flush privileges
echo "Flushing privileges..."
mysql -u root -p -e "FLUSH PRIVILEGES;"

exit

echo "MySQL setup completed successfully!"


echo "Nest.js droplet setup completed successfully!"
