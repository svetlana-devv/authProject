#!/bin/sh
set -e


until PGPASSWORD=$DB_PASSWORD psql -h "db" -U "laravel" -d "laravel" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing commands"


if [ ! -d /var/www/vendor ]; then
    composer install --no-interaction --no-progress
fi

composer require laravel/sanctum --no-interaction --no-progress
composer require laravel/socialite --no-interaction --no-progress

php artisan key:generate --no-interaction --force

chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

php artisan migrate --force
php artisan db:seed --force

php artisan test

php-fpm
