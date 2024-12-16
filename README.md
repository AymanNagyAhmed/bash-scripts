# Deploying Next.js Application on DigitalOcean

This guide walks through deploying a Next.js application on a Digital Ocean droplet using Nginx and securing it with HTTPS.


## Deploy on Digital Ocean:
### Step 1: Generate ssh key to connect local machine with digital ocean
### Step 2: Create Droplet
### Step 3: Connect to the droplet using ssh & Setup dependances
### Step 4: Setup github ssh key on your droplet `Don't forget to change your_email`
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
1. Copy setup scrips [nextjs_droplet_setup.sh](./03_nextjs_droplet_setup.sh) & [nestjs_droplet_setup.sh](./04_nestjs_droplet_setup.sh)
 to the droplet:
```bash
scp 03_nextjs_droplet_setup.sh root@YOUR_DROPLET_IPV4:/root/
or
scp 03_nextjs_droplet_setup.sh root@digitalocean_droplet_alias:/root/


scp 04_nestjs_droplet_setup.sh root@YOUR_DROPLET_IPV4:/root/
or
scp 04_nestjs_droplet_setup.sh root@digitalocean_droplet_alias:/root/

```
2. Connect to the droplet:
```bash
ssh root@YOUR_DROPLET_IPV4
or
sh root@digitalocean_droplet_alias


```
4. Make the scripts executable and run them:
```bash
chmod +x 03_nextjs_droplet_setup.sh

chmod +x 04_nestjs_droplet_setup.sh

./03_nextjs_droplet_setup.sh

./04_nestjs_droplet_setup.sh
```

## Step 4: Setup github ssh key on the droplet [SSH Setup Guide](./01_SSH_SETUP.md) `Don't forget to change your_email`
```bash
scp 05_guthub_sshkey_access.sh root@YOUR_DROPLET_IPV4:/root/

chmod +x 05_guthub_sshkey_access.sh

./05_guthub_sshkey_access.sh

```
## Step 5: Clone and setup the project `Don't forget to change your_repo_url`
```bash
scp 06_nextjs_project_install.sh 07_nestjs_project_install.sh root@YOUR_DROPLET_IPV4:/root/

chmod +x 06_nextjs_project_install.sh 07_nestjs_project_install.sh

./06_nextjs_project_install.sh 

./07_nestjs_project_install.sh
```

## Step 6: Configure Nginx `Don't forget to change your_domain`
1. make nginx serve your app without ssl
2. goto YOUR_DROPLET_IPV4:PORT
3. goto digitalocean => manage => networking => Domains
4. after add your domain inside it => HOSTNAME (nextjs-app)
5. Will direct to (select the drople) => create record
6. nextjs-app.your-domain.com
7. update nginx config file `/etc/nginx/sites-available/nextjs_app`
8. restart nginx
9. get ssl https://certbot.eff.org/instructions?ws=other&os=ubuntufocal
10. enable fire wall


```bash
scp 08_create_certificate.sh 09_nginx_configuration.sh root@YOUR_DROPLET_IPV4:/root/

chmod +x 08_create_certificate.sh 09_nginx_configuration.sh 
./08_create_certificate.sh 

./09_nginx_configuration.sh 
```



echo "Next steps:"
echo "1. Clone your Next.js application to /var/www/nextjs_app"
echo "2. Install dependencies using npm install"
echo "3. Build your application using npm run build"
echo "4. Start your application using PM2"
echo "5. Update the Nginx configuration with your domain name"
echo "6. Set up SSL using: certbot --nginx -d your-domain.com"







