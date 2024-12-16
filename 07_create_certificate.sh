#!/bin/bash

# Exit on error
set -e

echo "Stopping Nginx..."
service nginx stop

# Set up SSL with automatic email confirmation
echo "sudo certbot certonly --standalone -d your_domain"
# sudo certbot certonly --standalone \
#     --non-interactive \
#     --agree-tos \
#     --email your_email \
#     -d your_domain

# Restart Nginx
service nginx start
service nginx restart

echo "Certificate created successfully!"
