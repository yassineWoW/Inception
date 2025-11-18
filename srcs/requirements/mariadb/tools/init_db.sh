#!/bin/bash
set -e

echo "🔄 Starting MariaDB initialization..."

mysqld --user=mysql --bootstrap --verbose=0 <<EOF
USE mysql;
FLUSH PRIVILEGES;

-- remove anonymous users
DELETE FROM mysql.user WHERE User='';
-- remove test database
DROP DATABASE IF EXISTS test;
-- set root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
-- create wordpress db
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
-- create WP user with remote access
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
-- grant privileges on WP database to user
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

-- apply changes
FLUSH PRIVILEGES;
EOF

echo ""
echo "✅ MariaDB initialization complete!"
echo "📊 Database '${MYSQL_DATABASE}' created"
echo "👤 User '${MYSQL_USER}' created with remote access"
echo ""
echo "🚀 Starting MariaDB daemon..."

exec mysqld --user=mysql --console