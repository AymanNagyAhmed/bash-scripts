#!/bin/bash

# Exit on error
set -e

echo "Starting Ubuntu droplet setup for Next.js application..."

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
npm install -g pm2@latest

echo "Droplet setup completed successfully!"
