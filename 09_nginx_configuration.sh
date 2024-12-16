#!/bin/bash

# Exit on error
set -e

# Configure Nginx
echo "Configuring Nginx..."
cat > /etc/nginx/sites-available/nextjs_app.conf <<EOF
server {
    listen 80;
    server_name your_domain;
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name your_domain;
    
    # SSL Configuration
    ssl_certificate /etc/letsencrypt/live/your_domain/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your_domain/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    root /var/www/html/nextjs_app;
    index index.html index.htm;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }

    location /_next/static {
        alias /var/www/html/nextjs_app/.next/static;
        expires 365d;
        access_log off;
        add_header Cache-Control "public, max-age=31536000, immutable";
    }

    location /static {
        alias /var/www/html/nextjs_app/public/static;
        expires 365d;
        access_log off;
        add_header Cache-Control "public, max-age=31536000, immutable";
    }

    # Gzip Configuration
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
EOF

# Enable the Nginx site
ln -sf /etc/nginx/sites-available/nextjs_app.conf /etc/nginx/sites-enabled/

# Test Nginx configuration
nginx -t

# Configure firewall
echo "Configuring firewall..."
ufw allow OpenSSH
ufw allow 'Nginx Full'
ufw --force enable

# Create directory for Next.js application
echo "Creating application directory..."
mkdir -p /var/www/html/nextjs_app
chown -R $USER:$USER /var/www/html/nextjs_app

# Restart Nginx
echo "Restarting Nginx..."
systemctl restart nginx

echo "Nginx setup completed successfully!"