#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Generate application key if not set
if [ -z "$APP_KEY" ]; then
    echo "APP_KEY is not set. Generating new key..."
    php artisan key:generate --ansi
fi

# Run Laravel optimizations
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Start PHP-FPM in the background
php-fpm &

# Start Nginx in the foreground
exec nginx -g 'daemon off;'