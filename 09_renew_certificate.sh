#!/bin/bash

# Exit on error
set -e

cat > /etc/cron.daily/certbot <<EOF
#!/bin/bash
certbot renew --quiet --nginx
EOF
