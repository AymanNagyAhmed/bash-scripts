#!/bin/bash

# Exit on error
set -e

echo "Setting up GitHub Actions SSH access..."

# Generate SSH key pair for GitHub Actions
echo "Generating SSH key pair..."
ssh-keygen -t ed25519 -f /root/.ssh/github_id_rsa -C "your_email" -N ""

# Set correct permissions for SSH keys
echo "Setting correct permissions for SSH keys..."
chmod 600 /root/.ssh/github_id_rsa
chmod 600 /root/.ssh/github_id_rsa.pub

# Start ssh-agent and add the key
echo "Starting ssh-agent and adding the key..."
eval "$(ssh-agent -s)"
ssh-add /root/.ssh/github_id_rsa

# Create or update SSH config
echo "Updating SSH config..."
mkdir -p /root/.ssh
cat >> /root/.ssh/config << EOF
Host github.com
    HostName github.com
    User git
    IdentityFile /root/.ssh/github_id_rsa
    IdentitiesOnly yes
EOF

# Display the public key
echo "Your GitHub Actions public key (add this to your GitHub repository secrets):"
cat /root/.ssh/github_id_rsa.pub

# Test GitHub connection
echo "Testing GitHub SSH connection..."
ssh -T git@github.com -o StrictHostKeyChecking=no || true

echo "Setup complete! Don't forget to:"
echo "1. Add the public key above to your GitHub repository secrets"
echo "2. Use this key in your GitHub Actions workflow"