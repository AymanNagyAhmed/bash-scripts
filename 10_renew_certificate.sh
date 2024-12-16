#!/bin/bash

# Exit on error
set -e

# Create a new script to renew the certificate
cat > /etc/cron.daily/certbot <<EOF
#!/bin/bash
certbot renew --quiet --nginx
EOF

echo "Certificate renewal script added to cron.daily."
