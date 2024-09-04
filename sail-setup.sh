#!/bin/bash

# Install Laravel Sail if not already installed
if ! [ -f "./vendor/bin/sail" ]; then
    echo "Installing Laravel Sail..."
    composer require laravel/sail --dev
    php artisan sail:install --with=mysql
fi

# Start Sail services
echo "Starting Sail services..."
./vendor/bin/sail up --build -d

# Fix directory permissions
echo "Fixing directory permissions..."
./vendor/bin/sail exec -u root app bash -c "mkdir -p storage/framework/{cache/data,sessions,views} && chown -R sail:sail storage bootstrap/cache && chmod -R 775 storage bootstrap/cache"

# Clear Laravel caches
echo "Clearing Laravel caches..."
./vendor/bin/sail artisan config:clear
./vendor/bin/sail artisan cache:clear
./vendor/bin/sail artisan view:clear
./vendor/bin/sail artisan route:clear

# Run migrations
echo "Running migrations..."
./vendor/bin/sail artisan migrate

echo "Laravel Sail setup is complete. Your application is running!"
