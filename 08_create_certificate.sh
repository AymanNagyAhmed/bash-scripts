#!/bin/bash

# Exit on error
set -e

echo "Stopping Nginx..."
sudo systemctl stop nginx
# Set up SSL with automatic email confirmation
echo "sudo certbot certonly --standalone -d your_domain"
# sudo certbot certonly --standalone \
#     --non-interactive \
#     --agree-tos \
#     --email aymannagy.ahmed@gmail.com \
#     -d your_domain

# Restart Nginx
sudo systemctl start nginx
sudo systemctl restart nginx

echo "Certificate created successfully!"
