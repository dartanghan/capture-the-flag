#!/bin/bash
set -e

# Generate a random 6-character password
# Using /dev/urandom and filtering for alphanumeric characters
PASS=$(LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 6)
echo "$PASS" > /tmp/passwd

# Update the root password
echo "root:$PASS" | chpasswd

# Configure Nginx
# We need to ensure the directory for logs and the web root exist
mkdir -p /var/log/nginx
mkdir -p /var/lib/nginx
mkdir -p /tmp

# Generate a self-signed certificate for SSL
# This will be overwritten every time the container starts
openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snake.key -out /etc/ssl/certs/ssl-cert-snake.pem -subj "/C=US/ST=State/L=City/O=Org/CN=localhost" -addext "subjectAltName=DNS:localhost,IP:127.0.0.1" -days 365

# Configure Nginx sites-available/default
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name _;
    location / {
        default_type text/plain;
        default_content "Hello World";
    }
}

server {
    listen 443 ssl;
    server_name _;

    ssl_certificate /etc/ssl/certs/ssl-cert-snake.pem;
    ssl_certificate_key /etc/ssl/private/ssl-cert-snake.key;

    location / {
        default_type text/plain;
        default_content "password";
        root /tmp;
    }
}
EOF

# Start Nginx
exec nginx -g 'daemon off;'
