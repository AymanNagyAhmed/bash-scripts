# Deploying Next.js Application on DigitalOcean

This guide walks through deploying a Next.js application on a Digital Ocean droplet using Nginx and securing it with HTTPS.


## Deploy on Digital Ocean:
### Step 1: Generate ssh key to connect local machine with digital ocean
### Step 2: Create Droplet
### Step 3: Connect to the droplet using ssh & Setup dependances
### Step 4: Setup github ssh key `Don't forget to change your_email`
### Step 5: Clone and setup the project `Don't forget to change your_repo_url`
### Step 6: Configure Nginx `Don't forget to change your_domain`
### Step 7: Create ssl certificate `Don't forget to change your_email & your_domain`
### Step 8: Add cron job to renew the certificate
### Step 9: Add nestjs

### Step 10: Add github actions

Configure Nginx

## Step 1: generate ssh key
For detailed instructions on generating SSH keys, please refer to [SSH Setup Guide](./01_SSH_SETUP.md)


## Step 2: Create Droplet
01. Select the region 
02. Select Ubuntu
03. Select regular plan
04. 4GB Ram, 2CPU, 80GB ssd 
05. Backup/ Daily Backup 
06. Ssh => New ssh key
07. Add improved metrics
08. Hostname => `nextjsdemo`
09. After creation done copy `DROPLET_IP`

## Step 3: Connect to the droplet using ssh
1. Copy setup scrips [nextjs_droplet_setup.sh](./03_nextjs_droplet_setup.sh) & [nginx_configuration.sh](./04_nginx_configuration.sh)
 to the droplet:
```bash
scp 03_nextjs_droplet_setup.sh root@YOUR_DROPLET_IPV4:/root/

scp 04_nginx_configuration.sh root@YOUR_DROPLET_IPV4:/root/

```
2. Connect to the droplet:
```bash
ssh root@YOUR_DROPLET_IPV4
```
4. Make the scripts executable and run them:
```bash
chmod +x 03_nextjs_droplet_setup.sh

chmod +x 04_nginx_configuration.sh

./03_nextjs_droplet_setup.sh

./04_nginx_configuration.sh
```



echo "Next steps:"
echo "1. Clone your Next.js application to /var/www/nextjs_app"
echo "2. Install dependencies using npm install"
echo "3. Build your application using npm run build"
echo "4. Start your application using PM2"
echo "5. Update the Nginx configuration with your domain name"
echo "6. Set up SSL using: certbot --nginx -d your-domain.com"










## Step 4: Deploy Your Application
1. Clone your Next.js application:
```bash
cd /var/www/nextjs
git clone your_repo_url .
```

2. Install dependencies and build:
```bash
npm install
npm run build
```

3. Start the application with PM2:
```bash
pm2 start npm --name "nextjs" -- start
pm2 save
```

4. Configure your domain:
- Update the Nginx configuration in `/etc/nginx/sites-available/nextjs`
- Replace `your-domain.com` with your actual domain

5. Set up SSL:
```bash
certbot --nginx -d your-domain.com
```

6. Monitor your application:
```bash
pm2 status
pm2 logs
```