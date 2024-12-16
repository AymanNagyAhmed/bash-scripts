# Generating SSH Keys for DigitalOcean Deployment

This guide explains how to generate and set up SSH keys for secure access to your DigitalOcean droplet.

## Generate SSH Key
1. Open your terminal 
```
cd ~/.ssh
```
2. Generate a new SSH key pair:   
```
ssh-keygen -t ed25519 -C "aymannagy.ahmed@gmail.com"
```
3. When prompted, specify where to save the key:
   - choose a custom name like: `digitalocean_id_rsa`

4. Change file mode
```
sudo chmod 600 ~/.ssh/digitalocean_id_rsa ~/.ssh/digitalocean_id_rsa.pub
```
5. Adding your SSH key to the ssh-agent
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/digitalocean_id_rsa
```
6. Add this file: [~/.ssh/config](./.ssh/config)
```
nano ~/.ssh/config 
```
7. Get public key
```
cat ~/.ssh/digitalocean_id_rsa.pub
ssh -T digitalocean_droplet_alias
```
