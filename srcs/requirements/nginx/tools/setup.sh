#!/bin/bash
set -e

echo "🔄 Starting Nginx setup..."

# Check if SSL certificates already exist
if [ ! -f /etc/nginx/ssl/nginx.crt ] || [ ! -f /etc/nginx/ssl/nginx.key ]; then
    echo "🔐 Generating self-signed SSL certificate..."
    
    # Generate self-signed certificate
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=MA/ST=Rehamna/L=Benguerir/O=1337/OU=1337/CN=${DOMAIN_NAME}"
    
    # Set proper permissions
    chmod 600 /etc/nginx/ssl/nginx.key
    chmod 644 /etc/nginx/ssl/nginx.crt
    
    echo "✅ SSL certificate generated"
else
    echo "✅ SSL certificate already exists"
fi

echo ""
echo "🚀 Starting Nginx..."
echo "📊 Domain: ${DOMAIN_NAME}"
echo "🔒 HTTPS: Port 443"
echo ""

# Start Nginx in foreground
exec nginx -g "daemon off;"