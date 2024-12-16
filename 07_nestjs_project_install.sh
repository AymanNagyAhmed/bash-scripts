#!/bin/bash

# Exit on error
set -e

# Clone your NestJS application
git clone your_repo_url /var/www/html/nestjs_app

# Navigate to the application directory
cd /var/www/html/nestjs_app

# Copy .env.example to .env file
cp .env.example .env

# Edit .env file
nano .env

# Install dependencies
npm install

# Build the application
npm run build

# Start the application with PM2
pm2 start dist/src/main.js --name "nestjs_app"

# Configure PM2 to start on system boot
pm2 startup systemd

# Save the PM2 process list
pm2 save

# PM2 Management Commands:
# Stop: pm2 stop nestjs_app
# Delete: pm2 delete nestjs_app 
# Synchronize saved list with Current process list: pm2 save
# Restart: pm2 restart nestjs_app
# View logs: pm2 logs nestjs_app
# List processes: pm2 list

echo "Nest.js droplet setup completed successfully!"

