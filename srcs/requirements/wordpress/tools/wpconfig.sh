#!/bin/bash
set -e

echo "🔄 Starting WordPress setup..."

echo "⏳ Waiting for MariaDB to be ready..."
until mysql -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SELECT 1" >/dev/null 2>&1; do
    echo "   MariaDB is unavailable - sleeping"
    sleep 3
done
echo "✅ MariaDB is ready!"

cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "📥 Downloading WordPress..."
    
    # Download WordPress core
    wp core download --allow-root
    echo "✅ WordPress downloaded"
    
    # Create wp-config.php
    echo "⚙️  Creating wp-config.php..."
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root
	
    echo "✅ wp-config.php created"
    
    # Install WordPress
    echo "🔧 Installing WordPress..."
    wp core install \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_NAME" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_MAIL" \
        --skip-email \
        --allow-root
    echo "✅ WordPress installed"

	# Create additional user
    echo "👤 Creating WordPress user..."
    wp user create \
        "$WP_USER_NAME" \
        "$WP_USER_MAIL" \
        --role="$WP_USER_ROLE" \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root
    echo "✅ User '$WP_USER_NAME' created with role '$WP_USER_ROLE'"
    
    # Set proper permissions
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html

	echo ""
    echo "✅ WordPress setup complete!"
    echo "📊 Site URL: https://$DOMAIN_NAME"
    echo "👤 Admin: $WP_ADMIN_NAME"
    echo "👤 User: $WP_USER_NAME"
else
    echo "✅ WordPress already installed, skipping setup"
fi

echo ""
echo "🚀 Starting PHP-FPM..."

# Start PHP-FPM in foreground
exec php-fpm7.4 -F