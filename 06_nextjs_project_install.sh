#!/bin/bash

# Exit on error
set -e

# Clone your Next.js application
git clone your_repo_url /var/www/html/nextjs_app

# Navigate to the application directory
cd /var/www/html/nextjs_app

# Copy .env.example to .env file
cp .env.example .env

# Edit .env file
nano .env

# Install dependencies
npm install

# Build the application
npm run build

# Start the application with PM2
pm2 start npm --name "nextjs_app" -- start

# Configure PM2 to start on system boot
pm2 startup systemd

# Save the PM2 process list
pm2 save

# PM2 Management Commands:
# Stop: pm2 stop nextjs_app
# Delete: pm2 delete nextjs_app
# Restart: pm2 restart nextjs_app
# View logs: pm2 logs nextjs_app
# List processes: pm2 list
