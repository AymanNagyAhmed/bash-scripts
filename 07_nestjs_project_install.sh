#!/bin/bash

# Exit on error
set -e

# Clone your Next.js application
git clone your_repo_url /var/www/nestjs_app

# Navigate to the application directory
cd /var/www/nestjs_app

# Copy .env.example to .env file
cp .env.example .env

# Edit .env file
nano .env

# Install dependencies
npm install

# Build the application
npm run build

# Start the application
pm2 start dist/main.js --name "nestjs_app"


pm2 startup systemd

pm2 save
